part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

final class LoadNotificationsEvent extends NotificationEvent {}

final class MarkAsReadEvent extends NotificationEvent {
  final String notificationId;

  const MarkAsReadEvent(this.notificationId);

  @override
  List<Object> get props => [notificationId];
}

final class MarkAllAsReadEvent extends NotificationEvent {}

final class IncomingNotificationEvent extends NotificationEvent {
  final NotificationEntity notification;

  const IncomingNotificationEvent(this.notification);

  @override
  List<Object> get props => [notification];
}
