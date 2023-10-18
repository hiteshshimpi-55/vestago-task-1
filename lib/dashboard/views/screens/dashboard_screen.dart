import 'package:flutter/material.dart';
import 'package:vestago_task/core/utils/constants.dart';
import 'package:vestago_task/dashboard/views/widgets/buyer_card.dart';
import 'package:vestago_task/dashboard/views/widgets/buyer_container.dart';
import 'package:vestago_task/dashboard/views/widgets/crop_container.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "What is your Crop?",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(height: 10),
                CropContainer(),
                SizedBox(height: 20),
                Text(
                  "Buyers",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(height: 10),
                BuyerContainer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
