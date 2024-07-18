import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/driver_status/repo/local_repo_drive_status.dart';

final DriverStatusProvider = StateProvider(
    (ref) => ref.read(localDriverStatusRepositry).getDriverStatus());
