import 'package:flutter/material.dart';

import '../../models/crop_model.dart';

class CropCard extends StatelessWidget {
  final CropModel model;
  const CropCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20,
              height: 20,
              child: Image(
                image: NetworkImage(
                  model.imageUrl
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              model.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black
              ),
            )
          ],
        ),
      ),
    );
  }
}
