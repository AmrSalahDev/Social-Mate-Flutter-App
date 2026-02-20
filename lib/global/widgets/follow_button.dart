import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_mate_app/core/l10n/generated/l10n.dart';

class FollowButton extends StatelessWidget {
  final double? width;
  final bool isFollowing;
  final String userId;
  final VoidCallback onFollow;
  final VoidCallback onUnfollow;
  
  const FollowButton({
    super.key,
    required this.isFollowing,
    this.width,
    required this.userId,
    required this.onFollow,
    required this.onUnfollow,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final strings = AppStrings.of(context);
    return ElevatedButton(
      onPressed: () {
        if (isFollowing) {
          onUnfollow();
        } else {
          onFollow();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isFollowing
            ? Colors.transparent
            : colorScheme.primary,
        foregroundColor: isFollowing ? Colors.grey : colorScheme.onPrimary,
        elevation: 0,
        fixedSize: width != null ? Size(width!, 45.h) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: isFollowing
              ? BorderSide(color: colorScheme.outline)
              : BorderSide.none,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      ),
      child: Text(isFollowing ? strings.unfollow : strings.follow),
    );
  }
}
