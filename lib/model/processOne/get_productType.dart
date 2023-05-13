// To parse this JSON data, do
//
//     final getProductTypes = getProductTypesFromMap(jsonString);

import 'dart:convert';

List<GetProductTypes?>? getProductTypesFromMap(String str) =>
    json.decode(str) == null
        ? []
        : List<GetProductTypes?>.from(
            json.decode(str)!.map((x) => GetProductTypes.fromMap(x)));

String getProductTypesToMap(List<GetProductTypes?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toMap())));

class GetProductTypes {
  GetProductTypes({
    this.id,
    this.name,
    this.type,
    this.v,
    this.assignCurrentDeviceId,
  });

  String? id;
  String? name;
  String? type;
  int? v;
  String? assignCurrentDeviceId;

  factory GetProductTypes.fromMap(Map<String, dynamic> json) => GetProductTypes(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        v: json["__v"],
        assignCurrentDeviceId: json["assign_current_device_id"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "type": type,
        "__v": v,
        "assign_current_device_id": assignCurrentDeviceId,
      };
}
