import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_mate_app/core/l10n/generated/l10n.dart';
import 'package:social_mate_app/core/utils/time_ago_helper.dart';
import 'package:social_mate_app/features/notification/domain/entities/notification_entity.dart';
import 'package:social_mate_app/features/notification/presentation/views/notification_action_button.dart';
import 'package:social_mate_app/global/widgets/shimmer_avater.dart';

class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onTap;
  final VoidCallback? onActionPressed;

  const NotificationItem({
    super.key,
    required this.notification,
    this.onTap,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final strings = AppStrings.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerAvater(size: 48.w, imageUrl: notification.actorAvatar),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNotificationText(context, strings, textTheme),
                      InkWell(
                        borderRadius: BorderRadius.circular(20.r),
                        onTap: () {
                          // Show more options
                        },
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.grey,
                          size: 22.w,
                        ),
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Text(
                    TimeAgoHelper.format(notification.createdAt),
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                  if (_shouldShowActionButton()) ...[
                    8.verticalSpace,
                    NotificationActionButton(
                      label: _getActionButtonLabel(strings),
                      onPressed: onActionPressed ?? () {},
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationText(
    BuildContext context,
    AppStrings strings,
    TextTheme textTheme,
  ) {
    final actorNameStyle = textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
    );
    final contentStyle = textTheme.bodyMedium;

    switch (notification.type) {
      case NotificationType.profileView:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${notification.actorName} ',
                style: actorNameStyle,
              ),
              TextSpan(text: strings.viewedYourProfile, style: contentStyle),
            ],
          ),
        );

      case NotificationType.follow:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${notification.actorName} ',
                style: actorNameStyle,
              ),
              TextSpan(text: strings.followYou, style: contentStyle),
            ],
          ),
        );

      case NotificationType.congratulation:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${strings.congratulateYourFriend} ',
                style: contentStyle,
              ),
              TextSpan(text: notification.actorName, style: actorNameStyle),
              TextSpan(text: ' ${notification.content}', style: contentStyle),
            ],
          ),
        );

      case NotificationType.event:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(text: notification.actorName, style: actorNameStyle),
              TextSpan(text: ' ${notification.content}', style: contentStyle),
            ],
          ),
        );
    }
  }

  bool _shouldShowActionButton() {
    return notification.type == NotificationType.profileView ||
        notification.type == NotificationType.follow;
  }

  String _getActionButtonLabel(AppStrings strings) {
    switch (notification.type) {
      case NotificationType.profileView:
        return strings.seeAllView;
      case NotificationType.follow:
        return strings.followBack;
      default:
        return '';
    }
  }
}
