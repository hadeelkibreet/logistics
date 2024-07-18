import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/driver_status/entity/drive_status_entity.dart';
import 'package:logistics/driver_status/repo/drive_status_repo.dart';

final remoteDriverStatusRepository =
    StateProvider((ref) => RemoteDriverStatusRepository());

class RemoteDriverStatusRepository implements DriverStatusRepositry {
  @override
  DriverStatusEntity getDriverStatus() {
    throw UnimplementedError();
  }
}
