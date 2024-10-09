import 'package:logistics/driver_status/entity/drive_status_entity.dart';

abstract class DriverStatusRepository {
  Future<DriverStatusEntity> getDriverStatus(ref);
}
