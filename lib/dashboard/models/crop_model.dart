class CropModel {
  final int id;
  final String name;
  final String imageUrl;

  CropModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory CropModel.fromJson(Map<String, dynamic> json){
    return CropModel(
      id: int.parse(json["id"]) ?? 0,
      name: json["commodityName"],
      imageUrl: json["photo"]
    );
  }
}
