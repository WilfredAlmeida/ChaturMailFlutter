import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../utils/api_status.dart';
import '../controllers/api_communicator.dart';
import '../models/prompts_model.dart';
import 'package:http/http.dart' as http;

class PromptController extends GetxController {
  var promptsList = <PromptModel>[].obs;

  var promptsLoading = false.obs;
  var noPromptsFound = false.obs;

  late Box<dynamic> promptsBox;

  Future<bool> getPrompts() async {
    try {
      promptsLoading.value = true;

      const url = "/prompt/getAllPrompts";

      var result = await postRequest(url: url);

      if (result is Success) {
        final response = result.response as http.Response;
        var body = json.decode(response.body);

        promptsList.clear();
        await promptsBox.clear();

        if (body['status'] == 1) {
          for (var i = 0; i < body['payload'].length; i++) {
            var a = PromptModel.fromJson(body['payload'][i]);
            await promptsBox.put(i, a);
            // promptsList.add(a);
          }

          // promptsList = RxList<PromptModel>([...promptsBox.toMap().values.toList()]);

          promptsLoading.value = false;
        } else {
          // noPromptsFound.value = true;
          promptsLoading.value = false;
        }
      } else if (result is Failure) {
        promptsLoading.value = false;
        // noPromptsFound.value=true;
      }

      promptsList =
          RxList<PromptModel>([...promptsBox.toMap().values.toList()]);

      noPromptsFound.value = promptsList.isEmpty;

      return true;
    } catch (e, s) {
      print("IN PROMPTS_CONTROLLER");
      print(e);
      print(s);
      promptsLoading.value = false;
      // noPromptsFound.value=true;
      return false;
    }
  }

  PromptModel getPromptById(String id) {
    var prs = promptsList.where((e) => e.id == id);
    return prs.first;
  }
}
