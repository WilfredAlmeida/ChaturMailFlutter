//This file has utility functions like internet connection check, showing error dialog,sending feedback, providing bottom navigation bar object

import 'dart:io';

import 'package:chaturmail/controllers/api_communicator.dart';
import 'package:chaturmail/utils/api_status.dart';
import 'package:chaturmail/views/widgets/bottom_navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class UtilsController extends GetxController {
  var isInternetConnected = false.obs;
  var submittingFeedback = false.obs;

  Rx<int> bottomNavBarIndex = 0.obs;

  Future<void> initializeUtils() async {
    isInternetConnected.value = await hasNetwork();
  }

  //Checks Internet
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  //Shows Error Dialog
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

  //Bottom Navigation Bar Object. Done here cuz should be initialized only once. In screens, each screens initializes it multiple times
  Widget bottomNavBarWidget = BottomNavBarWidget();

  //Calls API ans submits user feedback
  Future<bool> submitFeedback(
      {required String subject, required String message}) async {
    submittingFeedback.value = true;

    var response = await postRequest(url: "/misc/submitFeedback", body: {
      "subject": subject,
      "message": message,
    });

    if (response is Success) {
      showErrorDialog(
          title: "Message Submitted",
          content: "Thank You for Contacting Us!",
          onConfirm: null);
    } else if (response is Failure) {
      showErrorDialog(
          title: "Message Submitted",
          content: "Thank You for Contacting Us!",
          onConfirm: null);
    }

    submittingFeedback.value = false;

    return true;
  }
}
