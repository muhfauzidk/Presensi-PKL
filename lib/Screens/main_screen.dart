import 'package:presensi/Screens/home_screen.dart';
import 'package:presensi/Screens/presence_screen.dart';
import 'package:presensi/Screens/profile_screen.dart';
import 'package:presensi/common/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presensi/Model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/main";
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late int bottomNavBarIndex;
  late PageController pageController;
   
  @override
  void initState() {
    super.initState();
    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex);

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: primaryColor,
          ),
          SafeArea(
            child: Stack(
              children: [
                Container(
                  color: screenColor,
                ),
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      bottomNavBarIndex = index;
                    });
                  },
                  children: [
                    HomeScreen(),
                    AllPresenceScreen(),
                    const ProfileScreen(),
                  ],
                ),
                bottomNavBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          unselectedItemColor: darkColor,
          currentIndex: bottomNavBarIndex,
          onTap: (index) {
              setState(() {
                bottomNavBarIndex = index;
                pageController.jumpToPage(index);
              });
            },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Riwayat Absensi',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      )
    );
  }
  
}