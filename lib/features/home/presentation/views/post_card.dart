import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:go_router/go_router.dart';
import 'package:number_display/number_display.dart';
import 'package:readmore/readmore.dart';
import 'package:social_mate_app/core/assets_gen/assets.gen.dart';
import 'package:social_mate_app/core/enums/post_type.dart';
import 'package:social_mate_app/core/routes/app_paths.dart';
import 'package:social_mate_app/features/home/domain/entities/post_entity.dart';
import 'package:social_mate_app/features/home/presentation/bloc/post_bloc.dart';
import 'package:social_mate_app/features/home/presentation/views/post_file_view.dart';
import 'package:social_mate_app/features/home/presentation/views/post_video_player.dart';
import 'package:social_mate_app/global/widgets/shimmer_avater.dart';
import 'package:social_mate_app/global/widgets/shimmer_image.dart';
import 'package:social_mate_app/global/widgets/svg_icon.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:social_mate_app/core/di/di.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});
  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final icons = Assets.icons;

    final formatNumber = createDisplay(length: 5, decimal: 1, separator: ',');
    final formatTime = GetTimeAgo.parse(post.createdAt);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              final supabase = getIt<SupabaseClient>();
              if (post.user.id == supabase.auth.currentUser?.id) {
                context.push(AppPaths.profile);
                return;
              }
              context.push('${AppPaths.profile}/${post.user.id}');
            },
            child: Row(
              children: [
                ShimmerAvater(size: 40.w, imageUrl: post.user.avatarUrl),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.user.name, style: textTheme.titleMedium),
                    2.verticalSpace,
                    Text(
                      formatTime,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          12.verticalSpace,
          ReadMoreText(
            post.content,
            trimMode: TrimMode.Line,
            trimLines: 3,
            trimCollapsedText: 'Read More',
            trimExpandedText: 'Read Less',
            moreStyle: textTheme.bodyMedium?.copyWith(
              color: colorScheme.primary,
            ),
            style: textTheme.bodyMedium,
          ),
          12.verticalSpace,
          if (post.mediaUrl.isNotEmpty) ...[_PostMediaDisplay(post: post)],
          12.verticalSpace,
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<PostBloc>().add(ToggleLikeEvent(post.id));
                },
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  post.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  size: 22.w,
                  color: post.isLiked
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              2.horizontalSpace,
              if (post.likesCount > 0) ...[
                Text(
                  formatNumber(post.likesCount),
                  style: textTheme.bodyMedium?.copyWith(
                    color: post.isLiked
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              10.horizontalSpace,
              IconButton(
                onPressed: () {
                  context.read<PostBloc>().add(ToggleDislikeEvent(post.id));
                },
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  post.isDisliked
                      ? Icons.thumb_down
                      : Icons.thumb_down_outlined,
                  size: 22.w,
                  color: post.isDisliked
                      ? colorScheme.error
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              if (post.dislikesCount > 0) ...[
                Text(
                  formatNumber(post.dislikesCount),
                  style: textTheme.bodyMedium?.copyWith(
                    color: post.isDisliked
                        ? colorScheme.error
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              12.horizontalSpace,
              IconButton(
                onPressed: () {},
                visualDensity: VisualDensity.compact,
                icon: SvgIcon(
                  path: icons.chatCircleDots.path,
                  size: 24.w,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              2.horizontalSpace,
              Text(
                formatNumber(post.commentsCount),
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              12.horizontalSpace,
              IconButton(
                onPressed: () {},
                visualDensity: VisualDensity.compact,
                icon: SvgIcon(
                  path: icons.share.path,
                  size: 24.w,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                visualDensity: VisualDensity.compact,
                icon: SvgIcon(
                  path: icons.bookmark.path,
                  size: 24.w,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostMediaDisplay extends StatelessWidget {
  final PostEntity post;
  const _PostMediaDisplay({required this.post});

  @override
  Widget build(BuildContext context) {
    if (post.mediaUrl.isEmpty) return const SizedBox.shrink();

    switch (post.postType) {
      case PostType.video:
        return PostVideoPlayer(videoUrl: post.mediaUrl);
      case PostType.file:
        return PostFileView(fileUrl: post.mediaUrl);
      case PostType.image:
        return ShimmerImage(
          width: double.infinity,
          height: 200.h,
          imageUrl: post.mediaUrl,
          borderRadius: 12.r,
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
