import 'package:logistics/constants/dio.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:logistics/driver_status/entity/drive_status_entity.dart';
import 'package:logistics/driver_status/repo/drive_status_repo.dart';

class RemoteDriverStatusRepository implements DriverStatusRepository {
  @override
  Future<DriverStatusEntity> getDriverStatus() async {
    try {
      // Assuming ApiService is already set up for making HTTP requests
      var responseData =
          await ApiService().getData(Endpoints.getStatue.toString());

      // Parse the JSON response and extract 'is_active'
      DriverStatusEntity driverStatusEntity =
          DriverStatusEntity.fromJson(responseData);

      // Log or handle the retrieved data
      print("Driver is_active status: ${driverStatusEntity.isActive}");

      return driverStatusEntity;
    } catch (e) {
      // Handle any errors that occur during the API call
      throw Exception('Failed to load driver status: $e');
    }
  }
}
