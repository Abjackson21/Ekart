// ignore_for_file: file_names, prefer_const_constructors

import 'package:ecomerce/utils/app_constant.dart';
import 'package:ecomerce/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text("Admin Panel"),
      ),
      drawer: DrawerWidget(),
    );
  }
}
