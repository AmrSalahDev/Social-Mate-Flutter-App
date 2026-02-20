import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:number_display/number_display.dart';
import 'package:social_mate_app/core/l10n/generated/l10n.dart';
import 'package:social_mate_app/core/routes/app_paths.dart';
import 'package:social_mate_app/features/discover_people/presentation/bloc/discover_people_bloc.dart';
import 'package:social_mate_app/features/profile/domain/entities/profile_entity.dart';
import 'package:social_mate_app/global/widgets/follow_button.dart';
import 'package:social_mate_app/global/widgets/shimmer_avater.dart';

class DiscoverPeopleItem extends StatelessWidget {
  const DiscoverPeopleItem({super.key, required this.user});

  final ProfileEntity user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final strings = AppStrings.of(context);
    
    final numberFormatter = createDisplay(
      decimal: 1,
      separator: ',',
      length: 5,
    );

    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline, width: 1.w),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              context.push('${AppPaths.profile}/${user.id}');
              //await context.push('${AppPaths.profile}/${user.id}');

              // if (context.mounted) {
              //   context.read<DiscoverPeopleBloc>().add(
              //     GetDiscoverPeopleEvent(),
              //   );
              // }
            },
            child: ShimmerAvater(size: 50.w, imageUrl: user.avatarUrl ?? ''),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.verticalSpace,
                Text(
                  '${numberFormatter(user.followersCount)} ${strings.followers.toLowerCase()}',
                  style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: FollowButton(
              userId: user.id,
              isFollowing: user.isFollowing,
              onFollow: () {
                context.read<DiscoverPeopleBloc>().add(
                  FollowUserEvent(user.id),
                );
              },
              onUnfollow: () {
                context.read<DiscoverPeopleBloc>().add(
                  UnfollowUserEvent(user.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
