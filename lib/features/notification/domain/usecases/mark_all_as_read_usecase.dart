import 'package:injectable/injectable.dart';
import 'package:social_mate_app/features/notification/domain/repos/notification_repo.dart';

@lazySingleton
class MarkAllAsReadUsecase {
  final NotificationRepo _repo;

  MarkAllAsReadUsecase(this._repo);

  Future<void> call() async {
    await _repo.markAllAsRead();
  }
}