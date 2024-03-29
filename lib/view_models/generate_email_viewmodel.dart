//This file is handles getting email generation
import 'dart:convert';

import 'package:chaturmail/controllers/api_communicator.dart';
import 'package:chaturmail/models/generated_email_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/api_status.dart';

class GenerateEmailController extends GetxController {
  // static GenerateEmailController get to => Get.find();

  //The request object is set via state management. Just use it's value
  var generateEmailRequest = Object().obs;

  //Response is provided via state management. Nothing is saved
  late Rx<GeneratedEmailResponseModel> generatedEmailResponse;

  var generatingEmail = false.obs;
  var generatingEmailFailed = false.obs;

  Future<bool> generateEmail() async {
    generatingEmail.value = true;

    final result = await postRequest(
      url: "/email/generateEmail",
      body: generateEmailRequest.toJson(),
    );

    if (result is Success) {
      final response = result.response as http.Response;
      var body = json.decode(response.body);

      print("GENERATED EMAILS");
      print(body);

      generatingEmail.value = false;

      var a = GeneratedEmailResponseModel.fromJson(
        body,
      );
      generatedEmailResponse = a.obs;
      generatingEmail.value = false;

      return true;
    } else if (result is Failure) {
      generatingEmail.value = false;
      generatingEmailFailed.value = true;
      return false;
    }

    return true;
  }
}
