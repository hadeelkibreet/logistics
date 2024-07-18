import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/auth/entity/login_entity.dart';
import 'package:logistics/auth/repository/login_repositry.dart';

final localLoginRepositry = StateProvider((ref) => LocalLoginRepositry());

class LocalLoginRepositry implements LoginRepositry {
  @override
  LoginEntity setLogin() {
    return LoginEntity(phoneNumber: '0503792580', passWord: '123');
  }
}
