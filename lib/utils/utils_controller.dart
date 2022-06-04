import 'dart:io';

import 'package:get/get.dart';

class UtilsController extends GetxController {
  var isInternetConnected = false.obs;

  Future<void> initializeUtils() async {
    isInternetConnected.value = await hasNetwork();
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
