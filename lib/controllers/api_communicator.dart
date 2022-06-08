import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import '../utils/api_status.dart';
import '../utils/constants.dart';

// var url = Uri.parse(API_URL+"/prompt/getAllPrompts");

Future<dynamic> postRequest({required String url, Object body = ""}) async {
  // print(body);

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
      },
    );

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

  // final receivePort = ReceivePort();
  //
  //
  //   await Isolate.spawn(_postRequest, [
  //     receivePort.sendPort,
  //     uri,
  //     body,
  //   ]);
  //
  //   return receivePort.first;
}

void _postRequest(List<Object?> arguments) async {
  var body;

  if (arguments[2] == "") {
    body = jsonEncode({});
  } else {
    body = jsonEncode(arguments[2]);
  }

  print(body);

  var response = await http.post(
    arguments[1] as Uri,
    body: body,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  SendPort sendPort = arguments[0] as SendPort;

  sendPort.send(response);
}
