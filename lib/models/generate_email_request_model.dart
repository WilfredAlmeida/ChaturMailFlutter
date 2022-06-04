// To parse this JSON data, do
//
//     final generateEmailRequestModel = generateEmailRequestModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GenerateEmailRequestModel generateEmailRequestModelFromJson(String str) =>
    GenerateEmailRequestModel.fromJson(json.decode(str));

String generateEmailRequestModelToJson(GenerateEmailRequestModel data) =>
    json.encode(data.toJson());

class GenerateEmailRequestModel {
  GenerateEmailRequestModel({
    required this.subject,
    required this.keywords,
    required this.promptId,
    required this.toEmail,
  });

  String subject;
  String keywords;
  String promptId;
  String toEmail;

  factory GenerateEmailRequestModel.fromJson(Map<String, dynamic> json) =>
      GenerateEmailRequestModel(
        subject: json["subject"],
        keywords: json["keywords"],
        promptId: json["promptId"],
        toEmail: json["toEmail"],
      );

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "keywords": keywords,
        "promptId": promptId,
        "toEmail": toEmail,
      };
}
