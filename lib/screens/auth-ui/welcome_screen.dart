// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:ecomerce/screens/auth-ui/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../utils/app_constant.dart';
import 'sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConstant.appSecondaryColor,
        title: Text(
          "Welcome to my app",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Lottie.asset('assets/images/splash_icon.json'),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "Happy Shopping",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 12,
            ),
            Material(
              child: Container(
                width: Get.width / 1.3,
                height: Get.height / 1.2,
                decoration: BoxDecoration(
                  color: AppConstant.appMainColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton(
                  child: Text(
                    "Sign in",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  onPressed: () {
                    Get.to(() => SignInScreen());
                  },
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 50,
            ),
            Material(
              child: Container(
                width: Get.width / 1.4,
                height: Get.height / 1.2,
                decoration: BoxDecoration(
                  color: AppConstant.appMainColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton(
                  child: Text(
                    "Sign up",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  onPressed: () {
                    Get.to(() => SignUpScreen());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
