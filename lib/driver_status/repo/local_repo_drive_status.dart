import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/driver_status/entity/drive_status_entity.dart';
import 'package:logistics/driver_status/repo/drive_status_repo.dart';

final localDriverStatusRepositry =
    StateProvider((ref) => LocalDriverStatusRepositry());

class LocalDriverStatusRepositry implements DriverStatusRepositry {
  @override
  DriverStatusEntity getDriverStatus() {
    return DriverStatusEntity(status: 2);
  }
}
