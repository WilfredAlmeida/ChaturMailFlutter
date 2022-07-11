//This file handles past emails. It fetches from API and sends delete request
import 'dart:convert';

import 'package:chaturmail/models/past_emails_model.dart';
import 'package:chaturmail/utils/api_status.dart';
import 'package:chaturmail/utils/utils_controller.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../controllers/api_communicator.dart';

class PastEmailsController extends GetxController {
  var pastEmailsList = <PastEmailsModel>[].obs;

  var pastEmailsLoading = false.obs;
  var noPastEmailsFound = false.obs;

  late Box<dynamic> pastEmailsBox;

  Future<bool> getPastEmails() async {
    pastEmailsLoading.value = true;

    try {
      pastEmailsLoading.value = true;

      const url = "/email/getGeneratedEmails";

      var result = await postRequest(url: url);

      if (result is Success) {
        final response = result.response as http.Response;
        var body = json.decode(response.body);
        print("BODY");
        print(body);

        if (body['status'] == 1) {
          await pastEmailsBox.clear();

          for (var i = 0; i < body['payload'].length; i++) {
            var a = PastEmailsModel.fromJson(body['payload'][i]);
            await pastEmailsBox.put(i, a);
          }

          pastEmailsLoading.value = false;
        } else {
          pastEmailsLoading.value = false;
        }
      } else if (result is Failure) {
        print(result.errorResponse);

        pastEmailsLoading.value = false;
      }

      pastEmailsList.clear();
      pastEmailsList =
          RxList<PastEmailsModel>([...pastEmailsBox.toMap().values.toList()]);

      noPastEmailsFound.value = pastEmailsList.isEmpty;

      return true;
    } catch (e, s) {
      print("IN PAST_EMAILS_CONTROLLER");
      print(e);
      print(s);
      pastEmailsLoading.value = false;
      return false;
    }
  }

  Future<bool> deleteGeneratedEmail({required id}) async {
    const url = "/email/deleteGeneratedEmail";

    final result = await postRequest(url: url, body: {"id": id});

    if (result is Success) {
      final response = result.response as http.Response;
      var body = json.decode(response.body);

      if (body['status'] == 1) {
        pastEmailsList.removeWhere((element) => element.id == id);

        for (var i = 0; i < pastEmailsBox.length; i++) {
          PastEmailsModel a = pastEmailsBox.getAt(i);

          if (a.id == id) {
            pastEmailsBox.deleteAt(i);
            break;
          }
        }

        print("Email Deleted Successfully");
        return true;
      } else if (body['status'] == 0) {
        Get.find<UtilsController>().showErrorDialog(
            title: "Email Not Deleted",
            content: body['message'],
            onConfirm: null);
        return false;
      }
    } else if (result is Failure) {
      Get.find<UtilsController>().showErrorDialog(
          title: "Email Not Deleted",
          content: "Some error Occurred",
          onConfirm: null);
      return false;
    }

    return true;
  }
}
