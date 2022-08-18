import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/common/common.dart';

class CustomErrorAlertDialog {
  static showPresenceAlert({
    required String title,
    required String message,
    required void Function() onConfirm,
    required void Function() onCancel,
  }) {
    Get.defaultDialog(
      title: "",
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      radius: 8,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 32, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w600,
                    color: maroonColor
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: const TextStyle(
                    color: darkColor,
                    height: 150 / 100,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: onCancel,
                    child: const Text(
                      "Tutup",
                      style: TextStyle(color: maroonColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      primary: primaryExtraSoft,
                      elevation: 0,
                      onPrimary: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}