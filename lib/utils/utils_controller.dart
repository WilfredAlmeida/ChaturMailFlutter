import 'dart:io';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:wilfredemail/controllers/api_communicator.dart';
import 'package:wilfredemail/utils/api_status.dart';
import 'package:wilfredemail/views/widgets/bottom_navbar_widget.dart';

import 'constants.dart';

class UtilsController extends GetxController {
  var isInternetConnected = false.obs;
  var submittingFeedback = false.obs;

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

  Widget bottomNavBarWidget = BottomNavBarWidget();

  Future<bool> submitFeedback({required String subject,required String message})async{

    submittingFeedback.value=true;

    var response = await postRequest(url: "/misc/submitFeedback",body: {
      "subject":subject,
      "message":message,
    });

    if(response is Success){
      showErrorDialog(title: "Message Submitted", content: "Thank You for Contacting Us!", onConfirm: null);
    }
    else if(response is Failure){
      showErrorDialog(title: "Message Submitted", content: "Thank You for Contacting Us!", onConfirm: null);
    }

    submittingFeedback.value=false;

    return true;
  }

}
