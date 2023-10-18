import 'package:flutter/material.dart';
import 'package:vestago_task/dashboard/models/buyer_model.dart';
import 'package:vestago_task/dashboard/models/crop_model.dart';
import 'package:vestago_task/dashboard/models/price_model.dart';

class BuyerCard extends StatelessWidget {
  final BuyerModel model;
  const BuyerCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 70,
              width: 70,
              child: Image(
                image: NetworkImage(model.imageUrl),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _cropCard(model.cropModel),
                const SizedBox(height:5),
                Text(
                    model.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:20,
                    color: Colors.black
                  ),
                ),
                const SizedBox(height:5),
                _priceCard(model.prices)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _cropCard(BuyerCropModel model){
    return Row(
      children: <Widget>[
        SizedBox(
          height: 10,
          width: 10,
          child: Image(
            image: NetworkImage(model.imageUrl),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          model.name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        )
      ],
    );
  }

  Widget _priceCard(List<PriceItem> prices){
    List<Widget> priceWidgets = [];

    for (var price in prices) {
      priceWidgets.add(
        Row(
          children: [
            _priceItem(price.date, price.price.toString(), price.sku),
            const SizedBox(width: 10)
          ],
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: priceWidgets,
    );
  }

  Widget _priceItem(String label,String value,String sku){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black26
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "₹$value",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sku,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 8,
              )
            )
          ],
        ),
      ],
    );
  }
}
