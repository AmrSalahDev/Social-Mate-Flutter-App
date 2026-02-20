import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';
import 'package:social_mate_app/core/routes/app_paths.dart';
import 'package:social_mate_app/core/routes/app_router.dart';
import 'package:social_mate_app/core/services/local_notification_service.dart';
import 'package:social_mate_app/core/services/media_cache_service.dart';
import 'package:social_mate_app/features/notification/domain/entities/notification_entity.dart';
import 'package:social_mate_app/features/notification/domain/repos/notification_repo.dart';

@lazySingleton
class NotificationListenerService {
  final NotificationRepo _notificationRepo;
  final LocalNotificationService _localNotificationService;
  StreamSubscription<NotificationEntity>? _subscription;
  StreamSubscription<String?>? _clickSubscription;
  final Set<String> _shownNotificationIds = {};

  NotificationListenerService(
    this._notificationRepo,
    this._localNotificationService,
  );

  void init() {
    debugPrint('NotificationListenerService: Initializing...');
    _subscription = _notificationRepo.notificationStream.listen((notification) {
      debugPrint(
        'NotificationListenerService: Received notification: ${notification.id}',
      );
      _showNotification(notification);
    });

    _clickSubscription = _localNotificationService.onNotificationClick.listen((
      payload,
    ) {
      if (payload != null) {
        _handleNotificationClick(payload);
      }
    });
  }

  Future<void> _handleNotificationClick(String payload) async {
    try {
      final Map<String, dynamic> data = jsonDecode(payload);
      final String type = data['type'];
      final String actorId = data['actorId'];

      if (type == NotificationType.follow.name ||
          type == NotificationType.profileView.name) {
        // Wait for router to be initialized if needed
        int retries = 0;
        while (retries < 10) {
          try {
            AppRouter.instance.push('${AppPaths.profile}/$actorId');
            break;
          } catch (e) {
            await Future.delayed(const Duration(milliseconds: 500));
            retries++;
          }
        }
      }
    } catch (e) {
      // Ignore click error
    }
  }

  Future<void> _showNotification(NotificationEntity notification) async {
    debugPrint(
      'NotificationListenerService: _showNotification called for ${notification.id}',
    );
    if (notification.isRead ||
        _shownNotificationIds.contains(notification.id)) {
      debugPrint(
        'NotificationListenerService: Skipping notification. isRead: ${notification.isRead}, already shown: ${_shownNotificationIds.contains(notification.id)}',
      );
      return;
    }
    _shownNotificationIds.add(notification.id);

    String title = 'Social Mate';
    String body = notification.content;

    switch (notification.type) {
      case NotificationType.profileView:
        title = 'Profile View';
        body = '${notification.actorName} viewed your profile';
        break;
      case NotificationType.follow:
        title = 'New Follower';
        body = '${notification.actorName} started following you';
        break;
      case NotificationType.congratulation:
        title = 'Congratulation';
        break;
      case NotificationType.event:
        title = 'Event';
        break;
    }

    String? largeIconPath;
    if (notification.actorAvatar.isNotEmpty) {
      try {
        final file = await MediaCacheService.imageCache.getSingleFile(
          notification.actorAvatar,
        );
        largeIconPath = file.path;
      } catch (e) {
        // Ignore image loading error
      }
    }

    debugPrint(
      'NotificationListenerService: Calling local notification service for ${notification.id}',
    );
    await _localNotificationService.showNotification(
      id: notification.id.hashCode,
      title: title,
      body: body,
      payload: jsonEncode({
        'id': notification.id,
        'type': notification.type.name,
        'actorId': notification.actorId,
      }),
      largeIconPath: largeIconPath,
    );
    debugPrint(
      'NotificationListenerService: Local notification service call completed',
    );
  }

  void dispose() {
    _subscription?.cancel();
    _clickSubscription?.cancel();
  }
}
