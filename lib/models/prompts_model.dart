// To parse this JSON data, do
//
//     final promptModel = promptModelFromJson(jsonString);

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

part '../generated/prompts_model.g.dart';

PromptModel promptModelFromJson(String str) => PromptModel.fromJson(json.decode(str));

String promptModelToJson(PromptModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class PromptModel {
  PromptModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.maxTokens,
    required this.shortDescription,
    required this.iconUrl,
    required this.description,
    required this.updatedOn,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String slug;

  @HiveField(3)
  int maxTokens;

  @HiveField(4)
  String shortDescription;

  @HiveField(5)
  String iconUrl;

  @HiveField(6)
  String description;

  @HiveField(7)
  int updatedOn;

  factory PromptModel.fromJson(Map<String, dynamic> json) => PromptModel(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    maxTokens: json["maxTokens"],
    shortDescription: json["shortDescription"],
    iconUrl: json["iconUrl"],
    description: json["description"],
    updatedOn: json["updatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "maxTokens": maxTokens,
    "shortDescription": shortDescription,
    "iconUrl": iconUrl,
    "description": description,
    "updatedOn": updatedOn,
  };
}
