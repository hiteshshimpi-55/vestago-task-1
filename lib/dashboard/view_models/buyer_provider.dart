import 'package:flutter/cupertino.dart';
import 'package:vestago_task/dashboard/repo/api_status.dart';

import '../models/buyer_model.dart';
import '../repo/dashboard_service.dart';

class BuyerProvider with ChangeNotifier {
  bool _loading = false;
  Future<List<BuyerModel>> _buyers = Future.value([]);
  CommonError _error = CommonError(code: 0, message: "No Error");

  // Constructor
  BuyerProvider() {
    getBuyers();
  }

  // Getters
  bool get loading => loading;
  Future<List<BuyerModel>> get buyers => _buyers;
  CommonError get error => _error;

  // Setters
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setBuyers(List<BuyerModel> list) {
    _buyers = Future.value(list);
  }

  setError(CommonError error) {
    _error = error;
  }

  void getBuyers() async {
    setLoading(true);

    var response = await DashboardService.getCrops();

    if (response is Success) {
      List<BuyerModel> list = response.response as List<BuyerModel>;
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
