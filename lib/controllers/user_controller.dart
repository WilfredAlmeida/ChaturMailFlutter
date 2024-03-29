//This file manages user data

import 'dart:convert';

import 'package:chaturmail/utils/utils_controller.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../utils/api_status.dart';
import 'api_communicator.dart';
import 'google_login.dart';

class UserController extends GetxController {
  // final sharedPreferencesController = Get.find<SharedPreferencesController>();

  //User Object
  var user = Rx<UserModel?>(null);

  var userLoading = false.obs;
  var noUserFound = false.obs;

  //User Hive Box, initialized in main.dart. Provided by state management
  late Box<dynamic> userBox;

  //Banner Image. Comes in as base64
  var bannerBase64 = ''.obs;

  var deletingUser = false.obs;

  Future<bool> getUserData() async {
    try {
      userLoading.value = true;

      const url = "/user/getUserData";

      var result = await postRequest(url: url);

      //Get value from API and store in Hive
      if (result is Success) {
        final response = result.response as http.Response;
        var body = json.decode(response.body);

        if (body['status'] == 1) {
          await userBox.delete("user");

          for (var i = 0; i < body['payload'].length; i++) {
            var a = UserModel.fromJson(body['payload'][i]);
            await userBox.put("user", a);
          }

          userLoading.value = false;
        } else {
          userLoading.value = false;
        }
      } else if (result is Failure) {
        userLoading.value = false;
      }

      //Read data only from hive, if not found assign null
      user.value = (userBox.get("user") == null
          ? null
          : (userBox.get("user") as UserModel));

      noUserFound.value = user.value is! UserModel;

      return true;
    } catch (e, s) {
      print("IN USER_CONTROLLER");
      print(e);
      print(s);
      userLoading.value = false;
      return false;
    }
  }

  //Get banner image
  Future<bool> getBannerUrl() async {
    try {
      userLoading.value = true;

      const url = "/misc/getBannerImage";

      var result = await postRequest(url: url);

      if (result is Success) {
        final response = result.response as http.Response;
        var body = json.decode(response.body);

        if (body['status'] == 1) {
          await userBox.delete("bannerBase64");

          for (var i = 0; i < body['payload'].length; i++) {
            var a = body['payload'][i]['imageData'];
            await userBox.put("bannerBase64", a);
          }

          bannerBase64.value = 'NULL';
        } else {
          bannerBase64.value = 'NULL';
        }
      } else if (result is Failure) {
        bannerBase64.value = 'NULL';
        await userBox.put("bannerBase64", 'NULL');
      }

      bannerBase64.value = userBox.get("bannerBase64");

      bannerBase64.value =
          bannerBase64.value == "NULL" ? '' : bannerBase64.value;

      return true;
    } catch (e, s) {
      print("IN USER_CONTROLLER");
      print(e);
      print(s);
      return false;
    }

    return true;
  }

  //Logs out and deleted user
  Future<bool> deleteUser() async {
    deletingUser.value = true;

    var response = postRequest(url: "/user/deleteUser");

    if (response is Success) {
      await Get.find<GoogleLoginController>().googleLogout();

      deletingUser.value = true;
    } else if (response is Failure) {
      Get.find<UtilsController>().showErrorDialog(
          title: "Deleting Failed",
          content: "Please Try Again Later",
          onConfirm: null);
      deletingUser.value = false;
    }

    return true;
  }
}
