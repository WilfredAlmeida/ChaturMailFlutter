import 'dart:io';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wilfredemail/views/widgets/bottom_navbar_widget.dart';

import 'constants.dart';

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

  void showErrorDialog(
      {required title, required content, required Function()? onConfirm}) {
    Get.defaultDialog(
      title: title,
      content: Text(content),
      textConfirm: "Ok",
      buttonColor: mainColor,
      confirmTextColor: greenMainColor2,
      onConfirm: onConfirm ??
          () {
            Get.back();
          },
    );
  }

  Widget bottomNavBarWidget = const BottomNavBarWidget();
}
