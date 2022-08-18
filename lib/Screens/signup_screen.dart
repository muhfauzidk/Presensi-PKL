import 'package:presensi/Model/auth.dart';
import 'package:presensi/Model/route_argument.dart';
import 'package:presensi/Model/user_model.dart';
import 'package:presensi/Screens/form_register_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
    final _auth = FirebaseAuth.instance;

    // string for displaying the error Message
    String? errorMessage;

    // our form key
    final _formKey = GlobalKey<FormState>();
    // editing Controller
    final firstNameEditingController = TextEditingController();
    final secondNameEditingController = TextEditingController();
    final emailEditingController = TextEditingController();
    final passwordEditingController = TextEditingController();
    final confirmPasswordEditingController = TextEditingController();

    @override
    Widget build(BuildContext context) {
      //email field
      final emailField = TextFormField(
          autofocus: false,
          controller: emailEditingController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Masukkan email");
            }
            // reg expression for email validation
            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                .hasMatch(value)) {
              return ("Masukkan email yang valid (user123@gmail.com)");
            }
            return null;
          },
          onSaved: (value) {
            firstNameEditingController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.mail),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            labelText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

      //password field
      final passwordField = TextFormField(
          autofocus: false,
          controller: passwordEditingController,
          obscureText: true,
          validator: (value) {
            RegExp regex = RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Masukkan Password");
            }
            if (!regex.hasMatch(value)) {
              return ("Masukkan Password yang valid(Min. 6 Character)");
            }
          },
          onSaved: (value) {
            firstNameEditingController.text = value!;
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

      //confirm password field
      final confirmPasswordField = TextFormField(
          autofocus: false,
          controller: confirmPasswordEditingController,
          obscureText: true,
          validator: (value) {
            if (confirmPasswordEditingController.text !=
                passwordEditingController.text) {
              return "Password tidak sesuai";
            }
            return null;
          },
          onSaved: (value) {
            confirmPasswordEditingController.text = value!;
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Konfirmasi Password",
            labelText: "Konfirmasi Password",
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
              signUp(emailEditingController.text, passwordEditingController.text);
            },
            child: const Text(
              "Daftar",
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
              // passing this to our root
              Navigator.of(context).pop();
            },
          ),
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
                        "Daftar Akun",
                        style: TextStyle(
                          fontSize: 44.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 44),
                      emailField,
                      const SizedBox(height: 20),
                      passwordField,
                      const SizedBox(height: 20),
                      confirmPasswordField,
                      const SizedBox(height: 44),
                      signUpButton,
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
  
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
              Fluttertoast.showToast(msg: e!.message);
            });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Email yang anda masukkan salah";
            break;
          case "wrong-password":
            errorMessage = "Password yang anda masukkan salah";
            break;
          case "user-not-found":
            errorMessage = "User tidak ditemukan";
            break;
          case "user-disabled":
            errorMessage = "User telah dinonaktifkan";
            break;
          case "too-many-requests":
            errorMessage = "Terlalu banyak permintaan";
            break;
          case "operation-not-allowed":
            errorMessage = "Login dengan email dan password tidak diaktifkan";
            break;
          default:
            errorMessage = "Terjadi error yang tidak diketahui";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Akun berhasil dibuat ");

    Navigator.pushNamed(context, FormRegister.routeName,
      arguments: RouteArgument(
        auth: Auth(
          email: emailEditingController.text,
          password: passwordEditingController.text,
        ),
      ),
    );

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const FormRegister()),
        (route) => false);
  }
}