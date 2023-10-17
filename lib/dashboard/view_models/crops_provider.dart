import 'package:flutter/cupertino.dart';
import 'package:vestago_task/dashboard/models/crop_model.dart';

import '../repo/api_status.dart';
import '../repo/dashboard_service.dart';

class CropsProvider with ChangeNotifier{

  bool _loading = false;
  Future<List<CropModel>> _crops = Future.value([]);
  CommonError _error = CommonError(code: 0, message: "No Error");

  CropsProvider(){
    getCrops();
  }

  // Getters
  bool get loading => _loading;
  Future<List<CropModel>> get crops => _crops;
  CommonError get error => _error;

  // Setters
  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setCrops(List<CropModel> crops){
    _crops = Future.value(crops);
  }

  setError(CommonError error){
    _error = error;
  }

  void getCrops() async {
    setLoading(true);

    var response = await DashboardService.getCrops();

    if (response is Success) {
      List<CropModel> list = response.response as List<CropModel>;
      print("Response in the List ${list}");
    } else if (response is Failure) {
      CommonError newError = CommonError(
        code: response.code!,
        message: response.errorResponse,
      );

      setError(newError);
    }
    setLoading(false);
  }
}