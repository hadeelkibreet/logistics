import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/auth/repository/local_login_repositry.dart';

final LoginProvider = FutureProvider(
  (ref) => ref.read(localLoginRepositry).setLogin(),
);
