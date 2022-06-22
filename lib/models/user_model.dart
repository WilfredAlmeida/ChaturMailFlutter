// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:hive/hive.dart';
import 'dart:convert';

part 'user_model.g.dart';


UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@HiveType(typeId: 4)
class UserModel {
  UserModel({
    required this.generatedEmailCount,
    required this.id,
    required this.usedTokens,
    required this.availableTokens,
    required this.name,
    required this.picture,
    required this.userId,
    required this.email,
    required this.uid,
  });

  @HiveField(0)
  int generatedEmailCount;

  @HiveField(1)
  String id;

  @HiveField(2)
  int usedTokens;

  @HiveField(3)
  int availableTokens;

  @HiveField(4)
  String name;

  @HiveField(5)
  String picture;

  @HiveField(6)
  String userId;

  @HiveField(7)
  String email;

  @HiveField(8)
  String uid;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    generatedEmailCount: json["generatedEmailCount"],
    id: json["_id"],
    usedTokens: json["usedTokens"],
    availableTokens: json["availableTokens"],
    name: json["name"],
    picture: json["picture"],
    userId: json["userId"],
    email: json["email"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "generatedEmailCount": generatedEmailCount,
    "id": id,
    "usedTokens": usedTokens,
    "availableTokens": availableTokens,
    "name": name,
    "picture": picture,
    "userId": userId,
    "email": email,
    "uid": uid,
  };
}
