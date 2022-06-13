// // To parse this JSON data, do
// //
// //     final generatedEmailResponseModel = generatedEmailResponseModelFromJson(jsonString);
//
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// GeneratedEmailResponseModel generatedEmailResponseModelFromJson(String str) => GeneratedEmailResponseModel.fromJson(json.decode(str));
//
// String generatedEmailResponseModelToJson(GeneratedEmailResponseModel data) => json.encode(data.toJson());
//
// class GeneratedEmailResponseModel {
//   GeneratedEmailResponseModel({
//     required this.id,
//     required this.userId,
//     required this.promptId,
//     required this.subject,
//     required this.keywords,
//     required this.generatedEmail,
//     required this.toEmailId,
//     required this.createdOn,
//   });
//
//   String id;
//   int userId;
//   int promptId;
//   String subject;
//   String keywords;
//   String generatedEmail;
//   String toEmailId;
//   int createdOn;
//
//   factory GeneratedEmailResponseModel.fromJson(Map<String, dynamic> json) => GeneratedEmailResponseModel(
//     id: json["id"],
//     userId: json["userId"],
//     promptId: json["promptId"],
//     subject: json["subject"],
//     keywords: json["keywords"],
//     generatedEmail: json["generatedEmail"],
//     toEmailId: json["toEmailId"],
//     createdOn: json["createdOn"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "userId": userId,
//     "promptId": promptId,
//     "subject": subject,
//     "keywords": keywords,
//     "generatedEmail": generatedEmail,
//     "toEmailId": toEmailId,
//     "createdOn": createdOn,
//   };
// }



// To parse this JSON data, do
//
//     final generatedEmailResponseModel = generatedEmailResponseModelFromJson(jsonString);

import 'dart:convert';

GeneratedEmailResponseModel generatedEmailResponseModelFromJson(String str) =>
    GeneratedEmailResponseModel.fromJson(json.decode(str));

String generatedEmailResponseModelToJson(GeneratedEmailResponseModel data) =>
    json.encode(data.toJson());

class GeneratedEmailResponseModel {
  GeneratedEmailResponseModel({
    required this.status,
    required this.message,
    required this.payload,
  });

  int status;
  String message;
  List<Payload> payload;

  factory GeneratedEmailResponseModel.fromJson(Map<String, dynamic> json) =>
      GeneratedEmailResponseModel(
        status: json["status"],
        message: json["message"],
        payload:
            List<Payload>.from(json["payload"].map((x) => Payload.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
      };
}

class Payload {
  Payload({
    required this.id,
    required this.userId,
    required this.promptId,
    required this.subject,
    required this.keywords,
    required this.generatedEmail,
    required this.toEmailId,
    required this.createdOn,
  });

  String id;
  String userId;
  String promptId;
  String subject;
  String keywords;
  String generatedEmail;
  String toEmailId;
  int createdOn;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        userId: json["userId"],
        promptId: json["promptId"],
        subject: json["subject"],
        keywords: json["keywords"],
        generatedEmail: json["generatedEmail"],
        toEmailId: json["toEmailId"],
        createdOn: json["createdOn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "promptId": promptId,
        "subject": subject,
        "keywords": keywords,
        "generatedEmail": generatedEmail,
        "toEmailId": toEmailId,
        "createdOn": createdOn,
      };
}
