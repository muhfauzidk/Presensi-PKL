import 'package:presensi/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  static String routeName = "/forgot-password";
  final forgorPasswordController = Get.put<ForgotPasswordController>(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: primaryColor,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 65 / 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 36, bottom: 84),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Link untuk reset password akan dikirimkan \nmelalui email yang anda masukkan dibawah",
                        style: TextStyle(
                          color: secondarySoft,
                          height: 150 / 100,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: secondaryExtraSoft),
                  ),
                  child: TextField(
                    style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
                    maxLines: 1,
                    controller: controller.emailC,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                      hintText: "Masukkan email",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: secondarySoft,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.sendEmail();
                        }
                      },
                      child: Text(
                        (controller.isLoading.isFalse) ? 'Kirim ke email' : 'Loading...',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('ForgotPasswordView'),
    //     centerTitle: true,
    //   ),
    //   body: ListView(
    //     shrinkWrap: true,
    //     padding: EdgeInsets.all(16),
    //     children: [
    //       TextField(
    //         controller: controller.emailC,
    //         autocorrect: false,
    //         decoration: InputDecoration(
    //           border: OutlineInputBorder(),
    //           labelText: 'Email',
    //         ),
    //       ),
    //       Obx(
    //         () => ElevatedButton(
    //           onPressed: () async {
    //             if (controller.isLoading.isFalse) {
    //               await controller.sendEmail();
    //             }
    //           },
    //           child: Text(controller.isLoading.isFalse ? 'Send Reset Password Link' : "Loading..."),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
