import 'dart:convert';

import 'package:get/get.dart';
import 'package:wilfredemail/controllers/google_login.dart';

import 'storage_controller.dart';

class UserController extends GetxController {
  final sharedPreferencesController = Get.find<SharedPreferencesController>();

  dynamic getLoggedInUser() {
    var prefs = sharedPreferencesController.sharedPreferences.value;

    var user = prefs.getString("user");

    return jsonDecode(user!);
  }
}
