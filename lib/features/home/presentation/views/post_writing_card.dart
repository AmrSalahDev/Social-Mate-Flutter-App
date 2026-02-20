import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:social_mate_app/core/assets_gen/assets.gen.dart';
import 'package:social_mate_app/core/l10n/generated/l10n.dart';
import 'package:social_mate_app/core/routes/app_paths.dart';
import 'package:social_mate_app/features/profile/domain/entities/profile_entity.dart';
import 'package:social_mate_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:social_mate_app/global/widgets/shimmer_avater.dart';
import 'package:social_mate_app/global/widgets/svg_icon.dart';

class PostWritingCard extends StatelessWidget {
  const PostWritingCard({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    required this.strings,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        padding: EdgeInsets.zero,
        color: colorScheme.secondary,
        radius: Radius.circular(12.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        canRequestFocus: false,
        onTap: () {
          context.push(AppPaths.createPost);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.primary.withValues(alpha: 0.07),
                colorScheme.primary.withValues(alpha: 0.03),
              ],
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  BlocSelector<ProfileBloc, ProfileState, ProfileEntity?>(
                    selector: (state) {
                      return state is ProfileLoaded ? state.profile : null;
                    },
                    builder: (context, profile) {
                      return ShimmerAvater(
                        size: 40.w,
                        imageUrl: profile?.avatarUrl ?? '',
                      );
                    },
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: IgnorePointer(
                      child: AnimatedTextField(
                        animationType: Animationtype.typer,
                        readOnly: true,
                        enabled: false,
                        hintTexts: [
                          strings.whatsOnYourMind,
                          strings.shareThoughts,
                          strings.tellYourStory,
                          strings.thinkingAboutToday,
                          strings.writeSomething,
                        ],
                        hintTextStyle: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.8,
                          ),
                        ),

                        decoration: InputDecoration(
                          filled: false,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              30.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _PostWritingCardActions(
                      path: Assets.icons.image.path,
                      label: 'Image',
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                    _PostWritingCardActions(
                      path: Assets.icons.videos.path,
                      label: 'Videos',
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                    _PostWritingCardActions(
                      path: Assets.icons.attach.path,
                      label: 'Attach',
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostWritingCardActions extends StatelessWidget {
  final String path;
  final String label;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final bool? isLast;

  const _PostWritingCardActions({
    required this.path,
    required this.label,
    required this.colorScheme,
    required this.textTheme,

    this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(path: path, size: 24.w, color: colorScheme.secondary),
          Text(
            ' $label',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          if (isLast != true) ...[
            Text(
              '  |  ',
              style: textTheme.bodySmall?.copyWith(color: colorScheme.outline),
            ),
          ],
        ],
      ),
    );
  }
}
