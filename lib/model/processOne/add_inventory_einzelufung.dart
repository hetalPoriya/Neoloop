// To parse this JSON data, do
//
//     final addInventoryEinzelufung = addInventoryEinzelufungFromMap(jsonString);

import 'dart:convert';

AddInventoryEinzelufung? addInventoryEinzelufungFromMap(String str) =>
    AddInventoryEinzelufung.fromMap(json.decode(str));

String addInventoryEinzelufungToMap(AddInventoryEinzelufung? data) =>
    json.encode(data!.toMap());

class AddInventoryEinzelufung {
  AddInventoryEinzelufung({
    this.type,
    this.productId,
    this.questionAnswer,
    this.frontImages,
    this.backImages,
    this.addedBy,
  });

  String? type;
  String? productId;
  List<QuestionAnswer?>? questionAnswer;
  List<ImageList?>? frontImages;
  List<ImageList?>? backImages;
  String? addedBy;

  factory AddInventoryEinzelufung.fromMap(Map<String, dynamic> json) =>
      AddInventoryEinzelufung(
        type: json["type"],
        productId: json["product_id"],
        questionAnswer: json["question_answer"] == null
            ? []
            : json["question_answer"] == null
                ? []
                : List<QuestionAnswer?>.from(json["question_answer"]!
                    .map((x) => QuestionAnswer.fromMap(x))),
        frontImages: json["front_images"] == null
            ? []
            : json["front_images"] == null
                ? []
                : List<ImageList?>.from(
                    json["front_images"]!.map((x) => ImageList.fromMap(x))),
        backImages: json["back_images"] == null
            ? []
            : json["back_images"] == null
                ? []
                : List<ImageList?>.from(
                    json["back_images"]!.map((x) => ImageList.fromMap(x))),
        addedBy: json["added_by"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "product_id": productId,
        "question_answer": questionAnswer == null
            ? []
            : questionAnswer == null
                ? []
                : List<dynamic>.from(questionAnswer!.map((x) => x!.toMap())),
        "front_images": frontImages == null
            ? []
            : frontImages == null
                ? []
                : List<dynamic>.from(frontImages!.map((x) => x!.toMap())),
        "back_images": backImages == null
            ? []
            : backImages == null
                ? []
                : List<dynamic>.from(backImages!.map((x) => x!.toMap())),
        "added_by": addedBy,
      };
}

class ImageList {
  ImageList({
    this.documentUniqueId,
    this.documentTags,
  });

  String? documentUniqueId;
  String? documentTags;

  factory ImageList.fromMap(Map<String, dynamic> json) => ImageList(
        documentUniqueId: json["document_unique_id"],
        documentTags: json["document_tags"],
      );

  Map<String, dynamic> toMap() => {
        "document_unique_id": documentUniqueId,
        "document_tags": documentTags,
      };
}

class QuestionAnswer {
  QuestionAnswer({
    this.question,
    this.answer,
  });

  String? question;
  String? answer;

  factory QuestionAnswer.fromMap(Map<String, dynamic> json) => QuestionAnswer(
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toMap() => {
        "question": question,
        "answer": answer,
      };
}

class AddInventoryEinzelufungResponse {
  AddInventoryEinzelufungResponse({
    this.status,
    this.deviceId,
    this.productId,
    this.inventoryId,
  });

  String? status;
  String? deviceId;
  String? productId;
  String? inventoryId;

  factory AddInventoryEinzelufungResponse.fromMap(Map<String, dynamic> json) =>
      AddInventoryEinzelufungResponse(
        status: json["status"],
        deviceId: json["device_id"],
        productId: json["product_id"],
        inventoryId: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "device_id": deviceId,
        "product_id": productId,
        "inventory_id": inventoryId,
      };
}
