// To parse this JSON data, do
//
//     final uploadDocument = uploadDocumentFromMap(jsonString);

import 'dart:convert';
import 'dart:io';

UploadDocument? uploadDocumentFromMap(String str) =>
    UploadDocument.fromMap(json.decode(str));

String uploadDocumentToMap(UploadDocument? data) => json.encode(data?.toMap());

class UploadDocument {
  UploadDocument({
    this.documentUniqueId,
    this.image1,
  });

  String? documentUniqueId;
  String? image1;

  factory UploadDocument.fromMap(Map<String, dynamic> json) => UploadDocument(
        documentUniqueId: json["document_unique_id"],
        image1: json["image1"],
      );

  Map<String, dynamic> toMap() => {
        "document_unique_id": documentUniqueId,
        "image1": image1,
      };
}
