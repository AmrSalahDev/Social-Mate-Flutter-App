import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:social_mate_app/core/l10n/generated/l10n.dart';
import 'package:social_mate_app/features/notification/domain/entities/notification_entity.dart';
import 'package:social_mate_app/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:social_mate_app/features/notification/presentation/views/notification_item.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key, required this.notifications});

  final List<NotificationEntity> notifications;

  @override
  Widget build(BuildContext context) {
    // First, prepare a property in NotificationEntity to indicate group
    // For example, add a getter inside NotificationEntity:
    // String get group {
    //   final now = DateTime.now();
    //   final today = DateTime(now.year, now.month, now.day);
    //   final yesterday = today.subtract(const Duration(days: 1));
    //   final date = DateTime(createdAt.year, createdAt.month, createdAt.day);
    //   if (date.isAtSameMomentAs(today)) return 'today';
    //   if (date.isAtSameMomentAs(yesterday)) return 'yesterday';
    //   return 'earlier';
    // }

    final strings = AppStrings.of(context);
    final textTheme = Theme.of(context).textTheme;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<NotificationBloc>().add(LoadNotificationsEvent());
      },
      child: GroupedListView<NotificationEntity, String>(
        elements: notifications,
        groupBy: (notification) {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final yesterday = today.subtract(const Duration(days: 1));

          final localDate = notification.createdAt.toLocal();

          final date = DateTime(localDate.year, localDate.month, localDate.day);

          if (date.isAtSameMomentAs(today)) return strings.today;
          if (date.isAtSameMomentAs(yesterday)) return strings.yesterday;
          return strings.earlier;
        },
        groupSeparatorBuilder: (String groupValue) => Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              groupValue,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        itemBuilder: (context, notification) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: NotificationItem(
            notification: notification,
            onTap: () {
              context.read<NotificationBloc>().add(
                MarkAsReadEvent(notification.id),
              );
            },
            onActionPressed: () {
              _handleNotificationAction(context, notification);
            },
          ),
        ),
        useStickyGroupSeparators: false,
        floatingHeader: false,
        order: GroupedListOrder.DESC,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      ),
    );
  }

  void _handleNotificationAction(
    BuildContext context,
    NotificationEntity notification,
  ) {
    // Handle different notification actions
    switch (notification.type) {
      case NotificationType.profileView:
        // Navigate to profile views page
        break;
      case NotificationType.follow:
        // Follow back the user
        break;
      default:
        break;
    }
  }
}
