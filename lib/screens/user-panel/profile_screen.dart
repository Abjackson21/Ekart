// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, file_names, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecomerce/controllers/get_user_data_controller.dart';
import 'package:ecomerce/controllers/update_user_controller.dart';
import 'package:ecomerce/utils/app_constant.dart';
import 'package:ecomerce/models/user_models.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  final UpdateUserController updateUserController =
      Get.put(UpdateUserController());
  final userEmailController = TextEditingController();
  final usernameController = TextEditingController();
  final userPhoneController = TextEditingController();
  final userCityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var userData = await getUserDataController.getUserData(userId);
    if (userData.isNotEmpty) {
      UserModel user =
          UserModel.fromMap(userData[0].data() as Map<String, dynamic>);
      setState(() {
        userEmailController.text = user.email;
        usernameController.text = user.username;
        userPhoneController.text = user.phone;
        userCityController.text = user.city;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: userEmailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                enabled: false,
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: userPhoneController,
                decoration: InputDecoration(
                  labelText: "Phone",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: userCityController,
                decoration: InputDecoration(
                  labelText: "City",
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  String userId = FirebaseAuth.instance.currentUser!.uid;
                  String username = usernameController.text.trim();
                  String phone = userPhoneController.text.trim();
                  String city = userCityController.text.trim();

                  if (username.isNotEmpty &&
                      phone.isNotEmpty &&
                      city.isNotEmpty) {
                    UserModel updatedUser = UserModel(
                      uId: userId,
                      username: username,
                      email: userEmailController.text.trim(),
                      phone: phone,
                      userImg: '', // Add the user image URL if you have one
                      userDeviceToken: '', // Add the device token if needed
                      country: '', // Add the country if needed
                      userAddress: '', // Add the address if needed
                      street: '', // Add the street if needed
                      isAdmin: false, // Set this according to your needs
                      isActive: true, // Set this according to your needs
                      createdOn: DateTime.now(),
                      city: city,
                    );

                    await updateUserController.updateUserData(updatedUser);
                    Get.snackbar(
                      "Success",
                      "Profile updated successfully",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppConstant.appSecondaryColor,
                      colorText: AppConstant.appTextColor,
                    );
                  } else {
                    Get.snackbar(
                      "Error",
                      "Please fill in all fields",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppConstant.appSecondaryColor,
                      colorText: AppConstant.appTextColor,
                    );
                  }
                },
                child: Text("Update Profile"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstant.appSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
