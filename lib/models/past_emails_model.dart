// To parse this JSON data, do
//
//     final pastEmailsModel = pastEmailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PastEmailsModel pastEmailsModelFromJson(String str) => PastEmailsModel.fromJson(json.decode(str));

String pastEmailsModelToJson(PastEmailsModel data) => json.encode(data.toJson());

class PastEmailsModel {
  PastEmailsModel({
    required this.id,
    required this.userId,
    required this.promptId,
    required this.subject,
    required this.keywords,
    required this.generatedEmail,
    required this.toEmailId,
    required this.tokens,
    required this.createdOn,
    required this.v,
  });

  String id;
  String userId;
  String promptId;
  String subject;
  String keywords;
  String generatedEmail;
  String toEmailId;
  int tokens;
  int createdOn;
  int v;

  factory PastEmailsModel.fromJson(Map<String, dynamic> json) => PastEmailsModel(
    id: json["_id"],
    userId: json["userId"],
    promptId: json["promptId"],
    subject: json["subject"],
    keywords: json["keywords"],
    generatedEmail: json["generatedEmail"],
    toEmailId: json["toEmailId"],
    tokens: json["tokens"],
    createdOn: json["createdOn"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "promptId": promptId,
    "subject": subject,
    "keywords": keywords,
    "generatedEmail": generatedEmail,
    "toEmailId": toEmailId,
    "tokens": tokens,
    "createdOn": createdOn,
    "__v": v,
  };
}
