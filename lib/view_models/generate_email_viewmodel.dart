import 'dart:convert';

import 'package:get/get.dart';
import 'package:chaturmail/controllers/api_communicator.dart';
import 'package:chaturmail/models/generated_email_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:chaturmail/utils/utils_controller.dart';
import '../models/generate_email_request_model.dart';
import '../utils/api_status.dart';

class GenerateEmailController extends GetxController {
  // static GenerateEmailController get to => Get.find();

  var generateEmailRequest = Object().obs;

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
