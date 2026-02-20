import 'package:injectable/injectable.dart';
import 'package:social_mate_app/features/notification/data/remote/notification_remote_datasource.dart';
import 'package:social_mate_app/features/notification/domain/entities/notification_entity.dart';
import 'package:social_mate_app/features/notification/domain/repos/notification_repo.dart';

@LazySingleton(as: NotificationRepo)
class NotificationRepoImpl implements NotificationRepo {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepoImpl(this._remoteDataSource);

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    return await _remoteDataSource.getNotifications();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _remoteDataSource.markAsRead(notificationId);
  }

  @override
  Future<void> markAllAsRead() async {
    await _remoteDataSource.markAllAsRead();
  }

  @override
  Stream<NotificationEntity> get notificationStream =>
      _remoteDataSource.notificationStream;
}
