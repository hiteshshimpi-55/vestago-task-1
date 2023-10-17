import 'package:flutter/material.dart';
import 'package:vestago_task/dashboard/views/widgets/crop_container.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            CropContainer(),
          ],
        ),
      ),
    );
  }
}
