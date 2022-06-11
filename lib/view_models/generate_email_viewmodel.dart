import 'dart:convert';

import 'package:get/get.dart';
import 'package:wilfredemail/controllers/api_communicator.dart';
import 'package:wilfredemail/models/generated_email_response_model.dart';
import '../models/generate_email_request_model.dart';

class GenerateEmailController extends GetxController {
  // static GenerateEmailController get to => Get.find();

  var generateEmailRequest = Object().obs;

  var generatedEmailResponse = Object().obs;

  Future<bool> generateEmail() async {
    final response = await postRequest(
      url: "/email/generateEmail",
      body: generateEmailRequest.toJson(),
    );

    print("GENERATED EMAILS");
    print(response.body);

    generatedEmailResponse.value = GeneratedEmailResponseModel.fromJson(
      jsonDecode(response.body),
    );

    return true;
  }
}
