// To parse this JSON data, do
//
//     final pastEmailsModel = pastEmailsModelFromJson(jsonString);

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

part 'past_emails_model.g.dart';

PastEmailsModel pastEmailsModelFromJson(String str) => PastEmailsModel.fromJson(json.decode(str));

String pastEmailsModelToJson(PastEmailsModel data) => json.encode(data.toJson());

@HiveType(typeId: 2)
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

  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  String promptId;

  @HiveField(3)
  String subject;

  @HiveField(4)
  String keywords;

  @HiveField(5)
  String generatedEmail;

  @HiveField(6)
  String toEmailId;

  @HiveField(7)
  int tokens;

  @HiveField(8)
  int createdOn;

  @HiveField(9)
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
