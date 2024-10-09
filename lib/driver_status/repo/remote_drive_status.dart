import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/constants/dio.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:logistics/driver_status/entity/drive_status_entity.dart';
import 'package:logistics/driver_status/repo/drive_status_repo.dart';

// Provider for accessing the remote driver status repository
final remoteDriverStatusRepositoryProvider = Provider<DriverStatusRepository>(
  (ref) => RemoteDriverStatusRepository(),
);

class RemoteDriverStatusRepository implements DriverStatusRepository {
  @override
  Future<DriverStatusEntity> getDriverStatus(ref) async {
    try {
      // Assuming ApiService is already set up for making HTTP requests
      var responseData =
          await ApiService().getData(Endpoints.getStatue.toString(), ref);

      // Parse the JSON response and extract 'is_active'
      DriverStatusEntity driverStatusEntity =
          DriverStatusEntity.fromJson(responseData);

      print("Driver is_active status: ${driverStatusEntity.isActive}");

      return driverStatusEntity;
    } catch (e) {
      throw Exception('Failed to load driver status: $e');
    }
  }
}
