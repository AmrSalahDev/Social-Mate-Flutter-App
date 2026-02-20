import 'package:social_mate_app/features/notification/domain/entities/notification_entity.dart';

abstract class NotificationRepo {
  Future<List<NotificationEntity>> getNotifications();
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead();
  Stream<NotificationEntity> get notificationStream;
}
