// ignore_for_file: file_names, must_be_immutable, avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, unused_import

import 'dart:io';
import 'package:ecomerce/controllers/edit_product_controller.dart';
import 'package:ecomerce/models/product_model.dart';
import 'package:ecomerce/utils/app_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EditProductScreen extends StatefulWidget {
  ProductModel productModel;
  EditProductScreen({super.key, required this.productModel});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController fullPriceController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productNameController.text = widget.productModel.productName;
    fullPriceController.text = widget.productModel.fullPrice;
    deliveryTimeController.text = widget.productModel.deliveryTime;
    productDescriptionController.text = widget.productModel.productDescription;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProductController>(
      init: EditProductController(productModel: widget.productModel),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appMainColor,
            title: Text("Edit Product ${widget.productModel.productName}"),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: Get.height / 4.0,
                      child: GridView.builder(
                        itemCount: controller.images.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: controller.images[index],
                                fit: BoxFit.contain,
                                height: Get.height / 5.5,
                                width: Get.width / 2,
                                placeholder: (context, url) =>
                                    Center(child: CupertinoActivityIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Positioned(
                                right: 10,
                                top: 0,
                                child: InkWell(
                                  onTap: () async {
                                    EasyLoading.show();
                                    await controller.deleteImagesFromStorage(
                                        controller.images[index].toString());
                                    await controller.deleteImageFromFireStore(
                                        controller.images[index].toString(),
                                        widget.productModel.productId);
                                    EasyLoading.dismiss();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        AppConstant.appSecondaryColor,
                                    child: Icon(
                                      Icons.close,
                                      color: AppConstant.appTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  //form
                  SizedBox(height: 10.0),
                  Container(
                    height: 65,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      cursorColor: AppConstant.appMainColor,
                      textInputAction: TextInputAction.next,
                      controller: productNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        hintText: "Product Name",
                        hintStyle: TextStyle(fontSize: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.0),
                  Container(
                    height: 65,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      cursorColor: AppConstant.appMainColor,
                      textInputAction: TextInputAction.next,
                      controller: fullPriceController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        hintText: "Full Price",
                        hintStyle: TextStyle(fontSize: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.0),
                  Container(
                    height: 65,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      cursorColor: AppConstant.appMainColor,
                      textInputAction: TextInputAction.next,
                      controller: deliveryTimeController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        hintText: "Delivery Time",
                        hintStyle: TextStyle(fontSize: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.0),
                  Container(
                    height: 65,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      cursorColor: AppConstant.appMainColor,
                      textInputAction: TextInputAction.next,
                      controller: productDescriptionController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        hintText: "Product Desc",
                        hintStyle: TextStyle(fontSize: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      //product Model

                      EasyLoading.show();
                      ProductModel newProductModel = ProductModel(
                        productId: widget.productModel.productId,
                        productName: productNameController.text.trim(),
                        fullPrice: fullPriceController.text.trim(),
                        productImages: widget.productModel.productImages,
                        deliveryTime: deliveryTimeController.text.trim(),
                        productDescription:
                            productDescriptionController.text.trim(),
                        createdAt: widget.productModel.createdAt,
                        updatedAt: DateTime.now(),
                      );

                      await FirebaseFirestore.instance
                          .collection('products')
                          .doc(widget.productModel.productId)
                          .update(newProductModel.toMap());

                      EasyLoading.dismiss();
                    },
                    child: Text("Update"),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
