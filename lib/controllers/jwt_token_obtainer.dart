import 'dart:convert';

import 'package:chaturmail/controllers/user_controller.dart';
import 'package:chaturmail/utils/utils_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/api_status.dart';
import 'api_communicator.dart';

class JWTController extends GetxController {
  var jwtToken = "".obs;

  Future<bool> refreshToken() async {
    return true;
  }

  Future<bool> getJWTToken({required String loginMethod}) async {
    const url = "/auth/getJWTToken";

    final user = FirebaseAuth.instance.currentUser;

    var result = await postRequest(url: url, body: {
      "email": user?.email,
      "idToken": await user?.getIdToken(true),
      "loginMethod": loginMethod,
      "fcmToken": await FirebaseMessaging.instance.getToken(),
    });

    if (result is Success) {
      final response = result.response as http.Response;
      var body = json.decode(response.body);

      if (body['status'] == 1) {
        jwtToken.value = body['payload'][0]['token'];
        print("JWT Token");
        print(jwtToken.value);

        // await Get.find<SharedPreferencesController>()
        //     .sharedPreferences
        //     .value
        //     .setString("jwtToken", jwtToken.value);

        await Get.find<UserController>()
            .userBox
            .put("jwtToken", jwtToken.value);

        return true;
      } else {
        Get.find<UtilsController>().showErrorDialog(
          title: "Cannot Obtain Token",
          content: body['message'],
          onConfirm: null,
        );
        return false;
      }
    } else if (result is Failure) {
      print(result.errorResponse);

      Get.find<UtilsController>().showErrorDialog(
        title: "Cannot Obtain Token",
        content: result.errorResponse,
        onConfirm: null,
      );
      return false;
    }

    return true;
  }
}
