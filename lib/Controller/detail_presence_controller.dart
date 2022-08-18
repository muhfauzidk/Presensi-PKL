import 'package:get/get.dart';

class DetailPresenceController extends GetxController {
  final count = 0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
