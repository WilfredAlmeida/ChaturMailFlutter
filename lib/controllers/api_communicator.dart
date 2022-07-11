/*
This file has code to communicate with API's. All communication is done via POST requests.

Initially was done with dart:Isolates, however due to Flutter web not supporting it, was replaced with async calls.

*/

import 'dart:convert';
import 'dart:io';

import 'package:chaturmail/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/api_status.dart';
import '../utils/constants.dart';

Future<dynamic> postRequest({required String url, Object body = ""}) async {
  //JWT Token
  final token = Get.find<UserController>().userBox.get("jwtToken");

  print("TOKEN");
  print(token);

  print("API_URL");
  print(API_URL);

  final uri = Uri.parse(API_URL + url);

  print(url);

  if (body == "") {
    body = jsonEncode({});
  } else {
    body = jsonEncode(body);
  }

  print(body);

  try {
    var response = await http.post(
      uri,
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    //API Responses are sent out as objects of Success, Failure

    if (response.statusCode == SUCCESS) {
      return Success(response: response, code: SUCCESS);
    }
    return Failure(
        code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
  } on HttpException {
    return Failure(code: NO_INTERNET, errorResponse: 'No Internet Connection');
  } on SocketException {
    return Failure(code: API_NOT_REACHABLE, errorResponse: 'API Not Reachable');
  } on FormatException {
    return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
  } catch (e) {
    return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
  }
}
