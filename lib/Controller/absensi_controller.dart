// @dart=2.9
import 'package:presensi/Widgets/custom_alert_dialog1.dart';
import 'package:presensi/Widgets/custom_alert_dialog2.dart';
import 'package:presensi/utils/time_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presensi/company_data.dart';


class PresenceController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  

  presence() async {
    isLoading.value = true;
    Map<String, dynamic> determinePosition = await _determinePosition();
    DocumentSnapshot<Map<String, dynamic>> user = await getUser();
    
    if (!determinePosition["error"]) {
      Position position = determinePosition["position"];
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      String address = "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}";
      double distance = Geolocator.distanceBetween(CompanyData.office['latitude'], CompanyData.office['longitude'], position.latitude, position.longitude);

      // update position ( store to database )
      await updatePosition(position, address);
      // presence ( store to database )
      await processPresence(position, user["name"], address, distance);
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar("Terjadi kesalahan", determinePosition["message"]);
      print(determinePosition["error"]);
    }
  }

  firstPresence(
    CollectionReference<Map<String, dynamic>> presenceCollection,
    String todayDocId,
    Position position,
    String address,
    String name,
    double distance,
    bool in_area,
  ) async {
    CustomAlertDialog.showPresenceAlert(
      title: "Absen masuk?",
      message: "konfirmasi jika ingin absen masuk sekarang",
      onCancel: () => Get.back(),
      onConfirm: () async {
        bool isWorkTime = await isCheckInTime();
        if (!isWorkTime) {
          CustomErrorAlertDialog.showPresenceAlert(
            title: "Diluar Waktu Kerja",
            message: "Lakukan absen masuk pada waktu yang ditentukan",
            onCancel: () => Get.back()
          );
        } else {
        await presenceCollection.doc(todayDocId).set(
          {
            "date": DateTime.now().toIso8601String(),
            "masuk": {
              "date": DateTime.now().toIso8601String(),
              "name": name,
              "latitude": position.latitude,
              "longitude": position.longitude,
              "address": address,
              "in_area": in_area,
              "distance": distance,
            }
          },
        );
        Get.back();
        Fluttertoast.showToast(msg:"Absen masuk berhasil");
        }
      }
    );
  }

  checkinPresence(
    CollectionReference<Map<String, dynamic>> presenceCollection,
    String todayDocId,
    Position position,
    String address,
    String name,
    double distance,
    bool in_area,
  ) async {
    CustomAlertDialog.showPresenceAlert(
      title: "Absen masuk?",
      message: "konfirmasi jika ingin absen masuk sekarang",
      onCancel: () => Get.back(),
      onConfirm: () async {
        bool isWorkTime = await isCheckInTime();
        if (!isWorkTime) {
          CustomErrorAlertDialog.showPresenceAlert(
            title: "Diluar Waktu Kerja",
            message: "Lakukan absen masuk pada waktu yang ditentukan",
            onCancel: () => Get.back()
          );
        } else {
        await presenceCollection.doc(todayDocId).set(
          {
            "date": DateTime.now().toIso8601String(),
            "masuk": {
              "date": DateTime.now().toIso8601String(),
              "name": name,
              "latitude": position.latitude,
              "longitude": position.longitude,
              "address": address,
              "in_area": in_area,
              "distance": distance,
            }
          },
        );
        Get.back();
        Fluttertoast.showToast(msg:"Absen masuk berhasil");
        }
      }
    );
  }

  checkoutPresence(
    CollectionReference<Map<String, dynamic>> presenceCollection,
    String todayDocId,
    Position position,
    String address,
    String name,
    double distance,
    bool in_area,
  ) async {
    CustomAlertDialog.showPresenceAlert(
      title: "Absen pulang?",
      message: "konfirmasi jika ingin absen pulang sekarang",
      onCancel: () => Get.back(),
      onConfirm: () async {
        bool isWorkTime = await isCheckOutTime();
        if (!isWorkTime) {
          CustomErrorAlertDialog.showPresenceAlert(
            title: "Diluar Waktu Kerja",
            message: "Lakukan absen pulang pada waktu yang ditentukan",
            onCancel: () => Get.back()
          );
        } else {
        await presenceCollection.doc(todayDocId).update(
          {
            "keluar": {
              "date": DateTime.now().toIso8601String(),
              "name": name,
              "latitude": position.latitude,
              "longitude": position.longitude,
              "address": address,
              "in_area": in_area,
              "distance": distance,
            }
          },
        );
        Get.back();
        Fluttertoast.showToast(msg:"Absen pulang berhasil");
        }
      }
    );
  }

  Future<void> processPresence(Position position, String name, String address, double distance) async {
    String uid = auth.currentUser.uid;
    String todayDocId = DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");

    CollectionReference<Map<String, dynamic>> presenceCollection = firestore.collection("users").doc(uid).collection("presence");
    QuerySnapshot<Map<String, dynamic>> snapshotPreference = await presenceCollection.get();

    bool in_area = false;
    if (distance <= 200) {
      in_area = true;

      if (snapshotPreference.docs.isEmpty) {
      //case :  never presence -> set check in presence
      firstPresence(presenceCollection, todayDocId, position, name, address, distance, in_area);
      } else {
        DocumentSnapshot<Map<String, dynamic>> todayDoc = await presenceCollection.doc(todayDocId).get();
        // already presence before ( another day ) -> have been check in today or check out?
        if (todayDoc.exists == true) {
          Map<String, dynamic> dataPresenceToday = todayDoc.data();
          // case : already check in
          if (dataPresenceToday["keluar"] != null) {
            // case : already check in and check out
            Fluttertoast.showToast(msg:"Sudah absen");
          } else {
            // case : already check in and not yet check out ( check out )
            checkoutPresence(presenceCollection, todayDocId, position, address, name, distance, in_area);
          }
        } else {
          // case : not yet check in today
          checkinPresence(presenceCollection, todayDocId, position, address, name, distance, in_area);
        }
      }
    } else {
      CustomErrorAlertDialog.showPresenceAlert(
        title: "Diluar Jangkauan",
        message: "Lakukan absen di area kantor",
        onCancel: () => Get.back()
      );
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = auth.currentUser.uid;
    await firestore.collection("users").doc(uid).update({
      "position": {
        "latitude": position.latitude,
        "longitude": position.longitude,
      },
      "address": address,
    });
  }

    Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    String uid = auth.currentUser.uid;
      DocumentSnapshot<Map<String, dynamic>> query = await firestore
          .collection("users")
          .doc(uid)
          .get();
      return query;
    }

  Future<Map<String, dynamic>> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {
          "message": "Tidak dapat mengakses karena anda menolak permintaan lokasi",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message": "Izin lokasi ditolak secara permanen, kami tidak dapat meminta izin",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    return {
      "position": position,
      "message": "Berhasil mendapatkan posisi device",
      "error": false,
    };
  }
}
