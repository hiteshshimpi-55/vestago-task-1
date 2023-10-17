import 'package:vestago_task/dashboard/models/price_model.dart';

import 'crop_model.dart';
import 'location_model.dart';

class BuyerModel {
  final int id;
  final String name;
  final String imageUrl;
  final CropModel cropModel;
  final LocationModel locationModel;
  final List<PriceItem> prices;

  BuyerModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.cropModel,
    required this.locationModel,
    required this.prices,
  });

  factory BuyerModel.fromJson(Map<String, dynamic> json) {
    return BuyerModel(
        id: json["id"],
        name: json["buyerName"],
        imageUrl: json["photo"],
        cropModel: CropModel.fromJson(json["cropInfo"]),
        locationModel: LocationModel.fromJson(json["location"]),
        prices: (json["prices"] as List)
            .map((x) => PriceItem.fromJson(x))
            .toList());
  }
}
