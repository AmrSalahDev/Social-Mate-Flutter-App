import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_display/number_display.dart';
import 'package:social_mate_app/core/l10n/generated/l10n.dart';
import 'package:social_mate_app/features/profile/domain/entities/profile_entity.dart';

final _formatNumber = createDisplay(length: 5, decimal: 1, separator: ',');

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final strings = AppStrings.of(context);

    return Container(
      width: double.infinity,
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          _StatItem(
            label: strings.posts,
            count: profile.postsCount,
            textTheme: textTheme,
            colorScheme: colorScheme, 
          ),
          _StatDivider(colorScheme: colorScheme),
          _StatItem(
            label: strings.photos,
            count: profile.photosCount,
            textTheme: textTheme,
            colorScheme: colorScheme,
          ),
          _StatDivider(colorScheme: colorScheme),
          _StatItem(
            label: strings.followers,
            count: profile.followersCount,
            textTheme: textTheme,
            colorScheme: colorScheme,
          ),
          _StatDivider(colorScheme: colorScheme),
          _StatItem(
            label: strings.following,
            count: profile.followingCount,
            textTheme: textTheme,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.count,
    required this.textTheme,
    required this.colorScheme,
  });

  final String label;
  final int count;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _formatNumber(count),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: constraints.maxWidth * 0.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: colorScheme.outline,
      thickness: 1,
      indent: 14.h,
      endIndent: 14.h,
    );
  }
}
