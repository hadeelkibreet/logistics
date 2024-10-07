import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/driver_status/entity/drive_status_entity.dart';
import 'package:logistics/driver_status/repo/remote_drive_status.dart';

// FutureProvider for getting the driver status asynchronously
final driverStatusProvider = FutureProvider<DriverStatusEntity>((ref) async {
  final repository = ref.read(remoteDriverStatusRepositoryProvider);
  return await repository.getDriverStatus();
});
