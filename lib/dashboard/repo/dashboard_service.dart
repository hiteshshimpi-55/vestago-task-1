import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vestago_task/core/utils/constants.dart';

import 'api_status.dart';

class DashboardService {
  static Future<Object> getCrops() async {
    try {
      var url = Uri.parse(GET_CROPS);
      var response = await http.get(url);

      if (response.statusCode == OK) {
        print("Response from the server : ${response.body}");
        return Success(code: OK, response: jsonDecode(response.body));
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (err) {
      return Failure(
          code: UNKNOWN_ERROR, errorResponse: 'Unknown Error ${err}');
    }
  }


  static Future<Object> getBuyers() async {
    try {
      var url = Uri.parse(GET_BUYERS);
      var response = await http.get(url);

      if (response.statusCode == OK) {
        print("Response from the server : ${response.body}");
        return Success(code: OK, response: jsonDecode(response.body));
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (err) {
      return Failure(
          code: UNKNOWN_ERROR, errorResponse: 'Unknown Error ${err}');
    }
  }
}
