import 'package:presensi/Controller/login_controller.dart';
import 'package:presensi/Screens/forgot_password_view.dart';
import 'package:presensi/Screens/signup_screen.dart';
import 'package:presensi/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put<LoginController>(LoginController());

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: controller.emailC,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Masukkan Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Masukkan Email yang valid");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Email",
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: controller.passC,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Masukkan Password");
          }
          if (!regex.hasMatch(value)) {
            return ("Masukkan Password yang valid");
          }
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //login button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            controller.login();
          },
          child: const Text(
            "Masuk",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    //sign up button
    final signUpButton = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            child: InkWell(
              child: Text(
                "Belum punya akun?",
                style: semiGreyFont.copyWith(
                  fontSize: 15,
                  color: darkColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Material(
            child: InkWell(
              splashColor: Colors.black.withOpacity(0.3),
              child: Text(
                "Daftar",
                style: semiGreyFont.copyWith(
                  fontSize: 15,
                  color: primaryColor,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
            ),
          ),
        ]
      );

      //reset password button
      final resetPasswordButton = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            child: InkWell(
              splashColor: Colors.black.withOpacity(0.3),
              child: Text(
                "Lupa Password",
                style: semiGreyFont.copyWith(
                  fontSize: 15,
                  color: maroonColor,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                );
              },
            ),
          ),
        ]
      );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Masuk",
                      style: TextStyle(
                        fontSize: 44.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 44),
                    emailField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 44),
                    loginButton,
                    const SizedBox(height: 30),
                    signUpButton,
                    const SizedBox(height: 15),
                    resetPasswordButton,
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}