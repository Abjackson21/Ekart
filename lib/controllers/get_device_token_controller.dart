// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../utils/app_constant.dart';

class GetDeviceTokenController extends GetxController {
  String? deviceToken;

  @override
  void onInit() {
    super.onInit();
    getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        deviceToken = token;
        print("Device Token: $deviceToken");
        update();
      } else {
        print("Failed to get device token.");
      }
    } catch (e) {
      print("Error fetching device token: $e");
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondaryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }

  Future<String?> fetchDeviceToken() async {
    if (deviceToken == null) {
      await getDeviceToken();
    }
    return deviceToken;
  }
}
