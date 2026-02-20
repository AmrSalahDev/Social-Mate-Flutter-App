import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_mate_app/features/notification/domain/entities/notification_entity.dart';
import 'package:social_mate_app/features/notification/domain/usecases/get_notifications_usecase.dart';
import 'package:social_mate_app/features/notification/domain/usecases/get_notification_stream_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

@lazySingleton
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final GetNotificationStreamUseCase _getNotificationStreamUseCase;
  StreamSubscription? _notificationSubscription;

  NotificationBloc(
    this._getNotificationsUseCase,
    this._getNotificationStreamUseCase,
  ) : super(NotificationInitial()) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<MarkAsReadEvent>(_onMarkAsRead);
    on<MarkAllAsReadEvent>(_onMarkAllAsRead);
    on<IncomingNotificationEvent>(_onIncomingNotification);
  }

  Future<void> _onLoadNotifications(
    LoadNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      final notifications = await _getNotificationsUseCase();
      emit(NotificationLoaded(notifications: notifications));

      // Cancel previous subscription if any
      await _notificationSubscription?.cancel();
      // Listen to real-time notifications
      _notificationSubscription = _getNotificationStreamUseCase().listen((
        notification,
      ) {
        add(IncomingNotificationEvent(notification));
      });

      add(MarkAllAsReadEvent());
     } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  void _onIncomingNotification(
    IncomingNotificationEvent event,
    Emitter<NotificationState> emit,
  ) {
    if (state is NotificationLoaded) {
      final currentState = state as NotificationLoaded;
      final exists = currentState.notifications.any(
        (n) => n.id == event.notification.id,
      );

      if (exists) {
        // Update existing notification (e.g. marked as read from another device)
        final updatedNotifications = currentState.notifications.map((n) {
          if (n.id == event.notification.id) return event.notification;
          return n;
        }).toList();
        emit(NotificationLoaded(notifications: updatedNotifications));
      } else {
        // Add new notification to the top
        final updatedNotifications = [
          event.notification,
          ...currentState.notifications,
        ];
        emit(NotificationLoaded(notifications: updatedNotifications));
      }
    }
  }

  Future<void> _onMarkAsRead(
    MarkAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      // Optimistic update
      final updatedNotifications = currentState.notifications.map((
        notification,
      ) {
        if (notification.id == event.notificationId) {
          return notification.copyWith(isRead: true);
        }
        return notification;
      }).toList();

      emit(NotificationLoaded(notifications: updatedNotifications));
    }
  }

  Future<void> _onMarkAllAsRead(
    MarkAllAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      // Optimistic update
      final updatedNotifications = currentState.notifications
          .map((notification) => notification.copyWith(isRead: true))
          .toList();

      emit(NotificationLoaded(notifications: updatedNotifications));
    }
  }

  @override
  Future<void> close() {
    _notificationSubscription?.cancel();
    return super.close();
  }
}
