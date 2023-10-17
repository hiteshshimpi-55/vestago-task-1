import 'package:flutter/cupertino.dart';
import 'package:vestago_task/dashboard/models/crop_model.dart';

import '../repo/api_status.dart';
import '../repo/dashboard_service.dart';

class CropsProvider with ChangeNotifier {
  bool _loading = false;
  Future<List<CropModel>> _crops = Future.value([]);
  CommonError _error = CommonError(code: 0, message: "No Error");
  List<CropModel> _filteredList = [];
  TextEditingController textEditingController = TextEditingController();

  CropsProvider() {
    getCrops();
  }

  // Getters
  bool get loading => _loading;
  Future<List<CropModel>> get crops => _crops;
  List<CropModel> get filteredList => _filteredList;
  CommonError get error => _error;
  // Setters
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setCrops(List<CropModel> crops) {
    _crops = Future.value(crops);
  }

  setError(CommonError error) {
    _error = error;
  }

  setFilterList(List<CropModel> list) {
    _filteredList = list;
  }

  void getCrops() async {
    setLoading(true);

    var response = await DashboardService.getCrops();

    if (response is Success) {
      List<CropModel> list = (response.response as List).map((e) => CropModel.fromJson(e)).toList();
      print("Response in the List ${list}");
      setCrops(list);
      setFilterList(list);
    } else if (response is Failure) {
      CommonError newError = CommonError(
        code: response.code!,
        message: response.errorResponse,
      );

      setError(newError);
    }
    setLoading(false);
  }

  void filterItems(String query) async {
    print("Query comming from " + query);
    if (query.isEmpty) {
      _filteredList = await _crops;
    } else {
      final fullCrops = await _crops;
      setFilterList(fullCrops.where((crop) {
        return crop.name.toLowerCase().contains(query.toLowerCase());
      }).toList());
    }
    notifyListeners();
  }
}
