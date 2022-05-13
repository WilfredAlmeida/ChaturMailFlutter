import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wilfredemail/utils/api_status.dart';
import '../controllers/api_communicator.dart';
import '../models/prompts_model.dart';
import 'package:http/http.dart' as http;

class PromptController extends GetxController{
  var promptsList = <PromptModel>[].obs;

  var promptsLoading=false.obs;
  var noPromptsFound=false.obs;

  Future<bool> getPrompts() async{

    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    var promptsBox = await Hive.openBox("promptsBox");

    try {
      promptsLoading.value = true;

      promptsList = RxList<PromptModel>([...promptsBox.toMap().values.toList()]);

      const url = "/prompt/getAllPrompts";

      var result = await postRequest(url: url);

      if (result is Success) {
        final response=result.response as http.Response;
        var body = json.decode(response.body);

        if (body['status'] == 1) {

          // promptsList.clear();

          for (var i = 0; i < body['payload'].length; i++) {
            var a = PromptModel.fromJson(body['payload'][i]);
            await promptsBox.put(i,a);
            // promptsList.add(a);
          }

          promptsList = RxList<PromptModel>([...promptsBox.toMap().values.toList()]);

          promptsLoading.value = false;
        }
        else {
          noPromptsFound.value = true;
          promptsLoading.value = false;
        }
      }
      else if(result is Failure){
        promptsLoading.value = false;
        noPromptsFound.value=true;
      }

      return true;
    } catch(e){
      print("IN PROMPTS_CONTROLLER");
      print(e);
      promptsLoading.value = false;
      // noPromptsFound.value=true;
      return false;
    }
  }

  PromptModel getPromptById(String id){
    var prs = promptsList.where((e) => e.id==id);
    return prs.first;
  }

}