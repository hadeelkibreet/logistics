import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/auth/entity/login_entity.dart';
import 'package:logistics/auth/repository/login_repositry.dart';

final remoteLoginRepository = StateProvider((ref) => RemoteLoginRepository());

class RemoteLoginRepository implements LoginRepositry {
  @override
  LoginEntity setLogin() {
    throw UnimplementedError();
  }
}
