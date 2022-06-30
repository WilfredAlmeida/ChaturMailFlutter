import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wilfredemail/controllers/api_communicator.dart';
import 'package:wilfredemail/models/tutorials_model.dart';
import 'package:http/http.dart' as http;

import '../utils/api_status.dart';

class TutorialsController extends GetxController {
  var tutorialsList = <TutorialsModel>[].obs;

  var tutorialsLoading = false.obs;
  var noTutorialsFound = false.obs;

  late Box<dynamic> tutorialsBox;

  Future<bool> getTutorials() async {
    try {
      tutorialsLoading.value = true;

      const url = "/tutorials/getAllTutorials";

      var result = await postRequest(url: url);

      if (result is Success) {
        final response = result.response as http.Response;
        var body = json.decode(response.body);

        if (body['status'] == 1) {
          await tutorialsBox.clear();

          for (var i = 0; i < body['payload'].length; i++) {
            var a = TutorialsModel.fromJson(body['payload'][i]);
            print(body['payload'][i]);
            await tutorialsBox.put(i, a);
          }

          tutorialsLoading.value = false;
        } else {
          tutorialsLoading.value = false;
        }
      } else if (result is Failure) {
        print(result.errorResponse);
        tutorialsLoading.value = false;
      }

      tutorialsList.clear();
      tutorialsList =
          RxList<TutorialsModel>([...tutorialsBox.toMap().values.toList()]);

      noTutorialsFound.value = tutorialsList.isEmpty;

      return true;
    } catch (e, s) {
      print("IN TUTORIALS_CONTROLLER");
      print(e);
      print(s);

      tutorialsLoading.value = false;

      return false;
    }
  }
}
