import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:wilfredemail/models/past_emails_model.dart';
import 'package:wilfredemail/utils/api_status.dart';

import '../controllers/api_communicator.dart';
import '../utils/constants.dart';

class PastEmailsController extends GetxController {
  var pastEmailsList = [].obs;

  var pastEmailsLoading = false.obs;
  var noPastEmailsFound = false.obs;

  late Box<dynamic> pastEmailsBox;

  Future<bool> getPastEmails() async {
    pastEmailsLoading.value = true;

    try {
      pastEmailsLoading.value = true;

      const url = "/email/getGeneratedEmails";

      var result = await postRequest(url: url);
      // print(result.response.body);

      if (result is Success) {
        final response = result.response as http.Response;
        var body = json.decode(response.body);

        if (body['status'] == 1) {
          // pastEmailsList.clear();

          for (var i = 0; i < body['payload'].length; i++) {
            var a = PastEmailsModel.fromJson(body['payload'][i]);
            await pastEmailsBox.put(i, a);
            // pastEmailsList.add(a);

          }

          // pastEmailsList = RxList<PastEmailsModel>([...pastEmailsBox.toMap().values.toList()]);

          pastEmailsLoading.value = false;
        } else {
          // noPastEmailsFound.value = true;
          pastEmailsLoading.value = false;
        }
      } else if (result is Failure) {
        print(result.errorResponse);

        pastEmailsLoading.value = false;
        // noPastEmailsFound.value=true;
      }

      pastEmailsList =
          RxList<PastEmailsModel>([...pastEmailsBox.toMap().values.toList()]);

      noPastEmailsFound.value = pastEmailsList.isEmpty;

      return true;
    } catch (e, s) {
      print("IN PAST_EMAILS_CONTROLLER");
      print(e);
      print(s);
      pastEmailsLoading.value = false;
      // noPastEmailsFound.value=true;
      return false;
    }
  }
}
