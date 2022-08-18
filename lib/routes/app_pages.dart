import 'package:presensi/Admin/Screens/admin_main_screen.dart';
import 'package:presensi/Admin/Screens/admin_presence_screen.dart';
import 'package:presensi/Admin/Screens/admin_users_data_screen.dart';
import 'package:presensi/Screens/account_setting_screen.dart';
import 'package:presensi/Screens/detail_presence_screen.dart';
import 'package:presensi/Screens/forgot_password_view.dart';
import 'package:presensi/Screens/login_screen.dart';
import 'package:presensi/Screens/main_screen.dart';
import 'package:presensi/Screens/presence_screen.dart';
import 'package:presensi/Screens/profile_screen.dart';
import 'package:presensi/Screens/update_profile_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => const AdminMainScreen(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: _Paths.ADMIN_PRESENCE,
      page: () => AdminAllPresenceView(),
    ),
    GetPage(
      name: _Paths.USERS_DATA,
      page: () => UsersDataScreen(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_POFILE,
      page: () => const UpdateProfileScreen(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRESENCE,
      page: () => DetailPresenceScreen(),
    ),   
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => AccountSettingScreen(),
    ),
    GetPage(
      name: _Paths.ALL_PRESENCE,
      page: () => AllPresenceScreen(),
    ),
  ];
}
