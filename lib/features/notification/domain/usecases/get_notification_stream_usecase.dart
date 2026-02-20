import 'package:injectable/injectable.dart';
import 'package:social_mate_app/features/notification/domain/entities/notification_entity.dart';
import 'package:social_mate_app/features/notification/domain/repos/notification_repo.dart';

@lazySingleton
class GetNotificationStreamUseCase {
  final NotificationRepo _notificationRepo;

  GetNotificationStreamUseCase(this._notificationRepo);

  Stream<NotificationEntity> call() {
    return _notificationRepo.notificationStream;
  }
}
