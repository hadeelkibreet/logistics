import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/driver_status/entity/drive_status_entity.dart';
import 'package:logistics/driver_status/repo/drive_status_repo.dart';
import 'package:logistics/driver_status/repo/remote_drive_status.dart';

// final DriverStatusProvider = StateProvider(
//     (ref) => ref.read(remoteDriverStatusRepository).getDriverStatus());

// Provider for accessing the remote driver status repository
final remoteDriverStatusRepositoryProvider =
    Provider<DriverStatusRepository>((ref) => RemoteDriverStatusRepository());

// FutureProvider for getting the driver status asynchronously
final driverStatusProvider = FutureProvider<DriverStatusEntity>((ref) async {
  final repository = ref.read(remoteDriverStatusRepositoryProvider);
  return await repository.getDriverStatus();
});
