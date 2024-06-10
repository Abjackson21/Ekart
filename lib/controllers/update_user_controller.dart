import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/models/user_models.dart';
import 'package:get/get.dart';

import 'package:ecomerce/utils/app_constant.dart';

class UpdateUserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUserData(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uId).update(user.toMap());
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update profile: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondaryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }
}
