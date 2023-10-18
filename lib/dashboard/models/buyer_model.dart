import 'package:vestago_task/dashboard/models/price_model.dart';

import 'crop_model.dart';
import 'location_model.dart';

class BuyerModel {
  final int id;
  final String name;
  final String imageUrl;
  final BuyerCropModel cropModel;
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
        id: int.parse(json["id"]),
        name: json["buyerName"],
        imageUrl: json["photo"],
        cropModel: BuyerCropModel.fromJson(json["cropInfo"]),
        locationModel: LocationModel.fromJson(json["location"]),
        prices:(json["price"] as List<dynamic>).map((e) => PriceItem.fromJson(e)).toList(),
    );
  }
}

class BuyerCropModel{
  String name;
  String imageUrl;

  BuyerCropModel({
    required this.name,
    required this.imageUrl,
  });

  factory BuyerCropModel.fromJson(Map<String, dynamic> json){
    return BuyerCropModel(
        name: json["crop"],
        imageUrl: json["photo"]
    );
  }
}