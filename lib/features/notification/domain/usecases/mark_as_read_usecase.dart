import 'package:injectable/injectable.dart';
import 'package:social_mate_app/features/notification/domain/repos/notification_repo.dart';

@lazySingleton
class MarkAsReadUseCase {
  final NotificationRepo _repo;

  MarkAsReadUseCase(this._repo);

  Future<void> call(String notificationId) async {
    await _repo.markAsRead(notificationId);
  }
}
