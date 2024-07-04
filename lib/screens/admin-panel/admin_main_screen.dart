// ignore_for_file: use_super_parameters, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controllers/chart_order_controller.dart';
import '../../models/chart_model.dart';
import '../../utils/app_constant.dart';
import '../../widgets/drawer_widget.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getAllOrdersChartController = Get.put(GetAllOrdersChart());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text("Home"),
      ),
      drawer: DrawerWidget(),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                final monthlyData =
                    getAllOrdersChartController.monthlyOrderData;
                if (monthlyData.isEmpty) {
                  return Container(
                    height: Get.height / 2,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: Get.height / 2,
                        child: SfCartesianChart(
                          tooltipBehavior: TooltipBehavior(enable: true),
                          primaryXAxis: CategoryAxis(arrangeByIndex: true),
                          series: <LineSeries<ChartData, String>>[
                            LineSeries<ChartData, String>(
                              dataSource: monthlyData,
                              width: 2.5,
                              color: AppConstant.appMainColor,
                              xValueMapper: (ChartData data, _) => data.month,
                              yValueMapper: (ChartData data, _) => data.value,
                              name: "Monthly Orders chart",
                              markerSettings: MarkerSettings(isVisible: true),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                          height: 20), // Spacer between chart and text
                      const Text(
                        "Monthly Orders chart",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
