import 'package:presensi/Admin/Screens/admin_presence_screen.dart';
import 'package:presensi/Admin/Screens/admin_users_data_screen.dart';
import 'package:presensi/Admin/Widgets/presence_card.dart';
import 'package:presensi/Controller/home_controller.dart';
import 'package:presensi/common/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboardScreen extends GetView<HomeController> {
static String routeName = "/dashboard_admin";

@override
Widget build(BuildContext context) {
  final controller = HomeController();
  return Scaffold(
    extendBody: true,
    body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.done:
              Map<String, dynamic> user = snapshot.data!.data()!;
              return ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
                children: [
                  const SizedBox(height: 16),
                  // Section 1 - Welcome Back
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                            width: 42,
                            height: 42,
                            child: Image.asset(
                              ('assets/images/avatar.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Selamat Datang",
                              style: TextStyle(
                                fontSize: 12,
                                color: secondarySoft,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'poppins',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // section 2 -  card
                  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: controller.streamTodayPresence(),
                      builder: (context, snapshot) {
                        // #TODO: make skeleton
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(child: CircularProgressIndicator());
                          case ConnectionState.active:
                          case ConnectionState.done:
                            var todayPresenceData = snapshot.data?.data();
                            return AdminPresenceCard(
                              userData: user,
                              todayPresenceData: todayPresenceData,
                            );
                          default:
                            return const SizedBox();
                        }
                      }),

                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 24, left: 4),
                  ),

                  // Menu activity
                  _MenuActivityComponent(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );

            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              return const Center(child: Text("Error"));
          }
        }),
  );
}
}

class _MenuComponent extends StatelessWidget {
  final String? titleMenu;
  final String? iconPath;
  final VoidCallback? onTap;

  const _MenuComponent({this.titleMenu, this.iconPath, this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 69, 61),
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: deviceWidth(context) - 1.5 * defaultMargin,
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath!,
                  width: 50,
                  height: 50,
                ),

                Text(
                  titleMenu!,
                  style: boldWhiteFont.copyWith(fontSize: 20),
                ),  
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuActivityComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Menu Aktivitas",
          style: semiBlackFont.copyWith(fontSize: 14),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 24,
          runSpacing: 20,
          children: [
            _MenuComponent(
              titleMenu: "Data Pengguna",
              iconPath: 'assets/images/ic_alfa.png',
              onTap: () {
                Navigator.pushNamed(context, UsersDataScreen.routeName);
                // PresenceController().presence();
              },
            ),
            _MenuComponent(
              titleMenu: "Data Absensi",
              iconPath: 'assets/images/ic_presence.png',
              onTap: () {
                Navigator.pushNamed(context, AdminAllPresenceView.routeName);
              },
            ),
          ],
        ),
      ],
    );
  }
}
