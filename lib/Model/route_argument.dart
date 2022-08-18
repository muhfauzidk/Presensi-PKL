// @dart=2.9

import 'package:presensi/Model/auth.dart';
import 'package:presensi/Model/user_model.dart';

class RouteArgument {
  final Auth auth;
  final UserModel user;

  RouteArgument({
    this.auth,
    this.user,
  });
}