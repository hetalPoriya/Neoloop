// To parse this JSON data, do
//
//     final uploadDocumentInfo = uploadDocumentInfoFromMap(jsonString);

import 'dart:convert';

List<UploadDocumentInfo?>? uploadDocumentInfoFromMap(String str) =>
    json.decode(str) == null
        ? []
        : List<UploadDocumentInfo?>.from(
            json.decode(str)!.map((x) => UploadDocumentInfo.fromMap(x)));

String uploadDocumentInfoToMap(List<UploadDocumentInfo?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toMap())));

// class UploadImageClass {
//   List<UploadDocumentInfo> uploadImageInfo;
//
//   UploadImageClass({required this.uploadImageInfo});
// }

class UploadDocumentInfo {
  UploadDocumentInfo(
      {this.documentUniqueId, this.documentTags, this.imagePath});

  String? documentUniqueId;
  String? documentTags;
  String? imagePath;

  factory UploadDocumentInfo.fromMap(Map<String, dynamic> json) =>
      UploadDocumentInfo(
        documentUniqueId: json["document_unique_id"],
        documentTags: json["document_tags"],
        imagePath: json["imagePath"],
      );

  Map<String, dynamic> toMap() => {
        "document_unique_id": documentUniqueId,
        "document_tags": documentTags,
        "imagePath": imagePath,
      };
}
