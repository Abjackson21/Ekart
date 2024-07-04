// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'package:ecomerce/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'specific_customer_orders_screen.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Orders"),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('orders')
            .orderBy('createdAt', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Container(
              child: Center(
                child: Text('Error occurred while fetching orders!'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Container(
              child: Center(
                child: Text('No orders found!'),
              ),
            );
          }

          if (snapshot.data != null) {
            print('Data retrieved: ${snapshot.data!.docs.length} orders found');
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                print('Order data: $data');

                if (data.containsKey('uId') &&
                    data.containsKey('customerName') &&
                    data.containsKey('customerPhone')) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () => Get.to(
                        () => SpecificCustomerOrderScreen(
                          docId: data['uId'],
                          customerName: data['customerName'],
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appSecondaryColor,
                        child: Text(data['customerName'][0]),
                      ),
                      title: Text(data['customerName']),
                      subtitle: Text(data['customerPhone']),
                      trailing: Icon(Icons.edit),
                    ),
                  );
                } else {
                  print('Missing required fields in order data');
                  return Container(
                    child: Center(
                      child: Text('Order data is incomplete.'),
                    ),
                  );
                }
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
