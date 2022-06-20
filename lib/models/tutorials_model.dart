import 'dart:convert';

import 'package:hive/hive.dart';

part 'tutorials_model.g.dart';

TutorialsModel tutorialsModelFromJson(String str) => TutorialsModel.fromJson(json.decode(str));

String tutorialsModelToJson(TutorialsModel data) => json.encode(data.toJson());

@HiveType(typeId: 3)
class TutorialsModel {
  TutorialsModel({
    required this.title,
    required this.htmlContent,
    required this.updatedOn,
  });

  @HiveField(0)
  String title;

  @HiveField(2)
  String htmlContent;

  @HiveField(3)
  int updatedOn;

  factory TutorialsModel.fromJson(Map<String, dynamic> json) => TutorialsModel(
    title: json["title"],
    htmlContent: json["htmlContent"],
    updatedOn: json["updatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "htmlContent": htmlContent,
    "updatedOn": updatedOn,
  };
}
