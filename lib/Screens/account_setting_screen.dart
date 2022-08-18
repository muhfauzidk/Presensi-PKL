// @dart=2.9

import 'package:presensi/Controller/change_password_controller.dart';
import 'package:presensi/Model/user_model.dart';
import 'package:presensi/common/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettingScreen extends StatelessWidget {
  static String routeName = "/account_setting_screen";
  final controller = Get.put<ChangePasswordController>(ChangePasswordController());
 
    var selectedDate = DateTime.now();
    User user = FirebaseAuth.instance.currentUser;
    UserModel loggedInUser = UserModel();

    // string for displaying the error Message
    String errorMessage;

    // our form key
    final _formKey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
      //old password field
      final oldPasswordField = TextFormField(
          autofocus: false,
          obscureText: true,
          controller: controller.currentPassC,
          validator: (value) {
            if (value.isEmpty) {
              return ("Masukkan Password Lama");
            }
            return null;
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            label: const Text(
              "Password Lama",
              style: TextStyle(
                color: secondarySoft,
                fontSize: 14,
              ),
            ),
            prefixIcon: const Icon(Icons.lock),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password Lama",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

      //new password field
      final passwordField = TextFormField(
          autofocus: false,
          obscureText: true,
          controller: controller.newPassC,
          validator: (value) {
            if (value.isEmpty) {
              return ("Masukkan Password Baru");
            }
            return null;
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password Baru",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

        //confirm new password field
      final confirmPasswordField = TextFormField(
          autofocus: false,
          obscureText: true,
          controller: controller.confirmNewPassC,
          validator: (value) {
            if (value.isEmpty) {
              return ("Masukkan Konfirmasi Password Baru");
            }
            return null;
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Konfirmasi Password Baru",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

      //signup button
      final signUpButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.green,
        child: MaterialButton(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              controller.updatePassword();
            },
            child: const Text(
              "Ganti Password",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            )),
      );

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.green),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Ganti Password Akun",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 44),
                      oldPasswordField,
                      const SizedBox(height: 20),
                      passwordField,
                      const SizedBox(height: 20),
                      confirmPasswordField,
                      const SizedBox(height: 20),
                      signUpButton,
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}