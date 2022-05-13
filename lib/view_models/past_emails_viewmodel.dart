import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wilfredemail/models/past_emails_model.dart';
import 'package:wilfredemail/utils/api_status.dart';

import '../controllers/api_communicator.dart';
import '../utils/constants.dart';

class PastEmailsController extends GetxController{

  var pastEmailsList = [].obs;

  var pastEmailsLoading=false.obs;
  var noPastEmailsFound=false.obs;

  Future<bool> getPastEmails() async{

    pastEmailsLoading.value=true;

    try {
      pastEmailsLoading.value = true;

      const url = "/email/getGeneratedEmails";

      var result = await postRequest(url: url);
      // print(result.response.body);

      if (result is Success) {
        final response=result.response as http.Response;
        var body = json.decode(response.body);

        if (body['status'] == 1) {

          pastEmailsList.clear();

          for (var i = 0; i < body['payload'].length; i++) {
            var a = PastEmailsModel.fromJson(body['payload'][i]);
            pastEmailsList.add(a);
          }

          pastEmailsLoading.value = false;
        }
        else {
          noPastEmailsFound.value = true;
          pastEmailsLoading.value = false;
        }
      }
      else if(result is Failure){
        pastEmailsLoading.value = false;
        noPastEmailsFound.value=true;
      }

      return true;
    } catch(e){
      print("IN PAST_EMAILS_CONTROLLER");
      print(e);
      pastEmailsLoading.value = false;
      noPastEmailsFound.value=true;
      return true;
    }

  }


}