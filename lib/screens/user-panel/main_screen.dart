// ignore_for_file: prefer_const_constructors

import 'package:ecomerce/screens/user-panel/cart_screen.dart';
import 'package:ecomerce/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_drawer_widget.dart';
import '../auth-ui/sign_in_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appMainName),
        centerTitle: true,
        
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart,
                ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.offAll(() => SignInScreen()),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
    );
  }
}
