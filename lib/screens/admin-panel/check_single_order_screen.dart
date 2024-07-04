import 'package:ecomerce/models/order_model.dart';
import 'package:ecomerce/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckSingleOrderScreen extends StatelessWidget {
  String docId;
  OrderModel orderModel;
  CheckSingleOrderScreen({
    super.key,
    required this.docId,
    required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Order'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(orderModel.productName),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(orderModel.productTotalPrice.toString()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('x' + orderModel.productQuantity.toString()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(orderModel.productDescription),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (orderModel.productImages.isNotEmpty)
                  CircleAvatar(
                    radius: 50.0,
                    foregroundImage: NetworkImage(orderModel.productImages[0]),
                  ),
                if (orderModel.productImages.length > 1)
                  CircleAvatar(
                    radius: 50.0,
                    foregroundImage: NetworkImage(orderModel.productImages[1]),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(orderModel.customerName),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(orderModel.customerPhone),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(orderModel.customerAddress),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(orderModel.customerId),
            ),
          ],
        ),
      ),
    );
  }
}
