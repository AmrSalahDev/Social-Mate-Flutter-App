import 'dart:async';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:retry/retry.dart';
import 'package:social_mate_app/features/notification/data/models/notification_model.dart';
import 'package:social_mate_app/features/notification/data/remote/notification_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final SupabaseClient _supabaseClient;
  final RetryOptions _retryOptions;
  final Logger _logger;

  NotificationRemoteDataSourceImpl(this._supabaseClient, this._retryOptions, this._logger);

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) return [];

    try {
      final response = await _retryOptions.retry(
        () => _supabaseClient
            .from('notifications')
            .select('* , users:actor_id(*)')
            .eq('user_id', userId)
            .order('created_at', ascending: true),
       
        retryIf: (e) => e is TimeoutException || e is SocketException,
        onRetry: (e) => _logger.d('Retrying getNotifications due to: $e'),
      );

      return response.map((json) => NotificationModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await _retryOptions.retry(
        () => _supabaseClient
            .from('notifications')
            .update({'is_read': true})
            .eq('id', notificationId),
        
        retryIf: (e) => e is TimeoutException || e is SocketException,
        onRetry: (e) => _logger.d('Retrying markAsRead due to: $e'),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> markAllAsRead() async {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) return;

    try {
      await _retryOptions.retry(
        () => _supabaseClient
            .from('notifications')
            .update({'is_read': true})
            .eq('user_id', userId)
            .eq('is_read', false),
        retryIf: (e) => e is TimeoutException || e is SocketException,
        onRetry: (e) => _logger.d('Retrying markAllAsRead due to: $e'),
      );
    } catch (e) {
      rethrow;
    }
  }

  Stream<NotificationModel>? _sharedNotificationStream;

  @override
  Stream<NotificationModel> get notificationStream {
    if (_sharedNotificationStream != null) return _sharedNotificationStream!;

    final controller = StreamController<NotificationModel>.broadcast();
    final userId = _supabaseClient.auth.currentUser?.id;

    if (userId == null) {
      return const Stream.empty();
    }

    final channel = _supabaseClient.channel('public:notifications:$userId');

    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'notifications',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) async {
            _logger.d(
              'Notification Stream: Received event: ${payload.eventType}',
            );
            final newRecord = payload.newRecord;
            if (newRecord.isEmpty) return;

            try {
              // Fetch notification with actor details
              final notificationId = newRecord['id'];

              final response = await _retryOptions.retry(
                () => _supabaseClient
                    .from('notifications')
                    .select('*, users:actor_id(name, avatar_url)')
                    .eq('id', notificationId)
                    .single(),
                retryIf: (e) => e is TimeoutException || e is SocketException,
                onRetry: (e) =>
                    _logger.d('Retrying notification fetch due to: $e'),
              );

              if (!controller.isClosed) {
                controller.add(NotificationModel.fromJson(response));
              }
            } catch (e) {
              _logger.d('Error processing notification: $e');
            }
          },
        )
        .subscribe((status, error) {
          _logger.d('Notification Stream Status: $status, error: $error');
        });

    controller.onCancel = () {
      if (!controller.hasListener) {
        _supabaseClient.removeChannel(channel);
        _sharedNotificationStream = null;
        controller.close();
      }
    };

    _sharedNotificationStream = controller.stream;
    return _sharedNotificationStream!;
  }
}
