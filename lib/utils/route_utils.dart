import 'package:presensi/Admin/Screens/admin_main_screen.dart';
import 'package:presensi/Admin/Screens/admin_presence_screen.dart';
import 'package:presensi/Admin/Screens/admin_users_data_screen.dart';
import 'package:presensi/Screens/forgot_password_view.dart';
import 'package:presensi/Screens/form_register_screen.dart';
import 'package:presensi/Screens/login_screen.dart';
import 'package:presensi/Screens/main_screen.dart';
import 'package:presensi/Screens/splash_screen.dart';
import 'package:presensi/Screens/update_profile_view.dart';
import 'package:presensi/Screens/detail_presence_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  AdminAllPresenceView.routeName: (context) => AdminAllPresenceView(),
  UsersDataScreen.routeName: (context) => UsersDataScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  DetailPresenceScreen.routeName: (context) => DetailPresenceScreen(),
  FormRegister.routeName: (context) => const FormRegister(),
  UpdateProfileScreen.routeName: (context) => const UpdateProfileScreen(),
  MainScreen.routeName: (context) => const MainScreen(),
  AdminMainScreen.routeName: (context) => const AdminMainScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
};