class LocationModel {
  String latitude;
  String longitude;

  LocationModel({required this.latitude, required this.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(longitude: json["lng"], latitude: json["lat"]);
  }
}
