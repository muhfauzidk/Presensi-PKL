// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:presensi/utils/route_utils.dart';
import 'package:presensi/common/common.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('id_ID', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        child: GetMaterialApp(
          title: "Presensi",
          home: const SplashScreen(),
          theme: appTheme,
          routes: routes,
          initialRoute: "/",
          debugShowCheckedModeBanner: false,
        ),
      );
  }
}