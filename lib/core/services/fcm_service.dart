import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:social_mate_app/core/routes/app_paths.dart';
import 'package:social_mate_app/core/routes/app_router.dart';
import 'package:social_mate_app/core/services/local_notification_service.dart';
import 'package:social_mate_app/features/notification/domain/entities/notification_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton
class FcmService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final SupabaseClient _supabaseClient;
  final LocalNotificationService _localNotificationService;
  final Logger _logger;

  FcmService(
    this._supabaseClient,
    this._localNotificationService,
    this._logger,
  );

  Future<void> init() async {
    _logger.d('FcmService: Initializing...');

    // 1. Request permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _logger.d('FcmService: User granted permission');
    } else {
      _logger.d('FcmService: User declined or has not accepted permission');
    }

    // 2. Get and save token
    await _updateToken();

    // 3. Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((token) {
      _logger.d('FcmService: Token refreshed: $token');
      _saveTokenToSupabase(token);
    });

    // 4. Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _logger.d(
        'FcmService: Received foreground message: ${message.messageId}',
      );
      _handleForegroundMessage(message);
    });

    // 5. Handle background message clicks (when app is in background but not killed)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _logger.d(
        'FcmService: App opened from notification: ${message.messageId}',
      );
      _handleNotificationClick(message.data);
    });

    // 6. Handle clicks from Foreground notifications (local notifications)
    _localNotificationService.onNotificationClick.listen((payload) {
      if (payload != null) {
        try {
          final data = jsonDecode(payload) as Map<String, dynamic>;
          _handleNotificationClick(data);
        } catch (e) {
          _logger.e('FcmService: Error parsing local notification payload: $e');
        }
      }
    });

    // 7. Handle app launch from killed state
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _logger.d(
        'FcmService: App launched from killed state: ${initialMessage.messageId}',
      );
      _handleNotificationClick(initialMessage.data);
    }
  }

  Future<void> _handleNotificationClick(Map<String, dynamic> data) async {
    if (data.isEmpty) return;

    final String? type = data['type'];
    final String? actorId = data['actorId'];

    if (actorId == null) return;

    if (type == NotificationType.follow.name ||
        type == NotificationType.profileView.name) {
      _logger.d('FcmService: Navigating to profile: $actorId');

      // Wait for router to be ready
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
  }

  Future<void> _updateToken() async {
    final token = await _firebaseMessaging.getToken();
    if (token != null) {
      _logger.d('FcmService: FCM Token: $token');
      await _saveTokenToSupabase(token);
    }
  }

  Future<void> _saveTokenToSupabase(String token) async {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) return;

    try {
      await _supabaseClient.from('user_fcm_tokens').upsert({
        'user_id': userId,
        'token': token,
        'updated_at': DateTime.now().toIso8601String(),
      }, onConflict: 'user_id');
      _logger.d('FcmService: Token saved to Supabase');
    } catch (e) {
      _logger.e('FcmService: Error saving token to Supabase: $e');
    }
  }

  Future<void> deleteToken() async {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) return;

    try {
      await _supabaseClient
          .from('user_fcm_tokens')
          .delete()
          .eq('user_id', userId);
      _logger.d('FcmService: Token deleted from Supabase');
    } catch (e) {
      _logger.e('FcmService: Error deleting token: $e');
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    if (message.notification != null) {
      _localNotificationService.showNotification(
        id: message.messageId.hashCode,
        title: message.notification!.title ?? 'Social Mate',
        body: message.notification!.body ?? '',
        payload: jsonEncode(message.data),
      );
    }
  }
}

// Background message handler (Must be a top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you need to do something in background without showing a notification
  // (FCM automatically shows notification if 'notification' field is present)
  print("Handling a background message: ${message.messageId}");
}
