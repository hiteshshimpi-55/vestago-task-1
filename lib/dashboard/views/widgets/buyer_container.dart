import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:vestago_task/dashboard/models/crop_model.dart';
import 'package:vestago_task/dashboard/view_models/crops_provider.dart';

import '../../models/buyer_model.dart';
import '../../view_models/buyer_provider.dart';
import 'buyer_card.dart';

class BuyerContainer extends StatelessWidget {
  const BuyerContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 130,
      child: Consumer<BuyerProvider>(
        builder: (context, buyerProvider, child) =>
            _futureWidget(context, buyerProvider, size),
      ),
    );
  }

  Widget _futureWidget(
      BuildContext context, BuyerProvider provider, Size size) {
    if (provider.loading) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    } else if (provider.error.code != 0) {
      return Center(
        child: Text(
          "Error: ${provider.error.message} with code ${provider.error.code}",
          style: const TextStyle(
              color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return FutureBuilder<List<BuyerModel>>(
        future: provider.buyers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData) {
            print("Data provided ${snapshot.data}");
            return _ui(context, provider, size, snapshot.data!);
          } else {
            return Center(
              child: Text("An error occurred ${snapshot.error}"),
            );
          }
        },
      );
    }
  }

  Widget _ui(BuildContext context, BuyerProvider provider, Size size,
      List<BuyerModel> list) {
    print("List: ${list}");
    return ListView.builder(
      itemCount: list.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return BuyerCard(model: list[index]);
      },
    );
  }
}
