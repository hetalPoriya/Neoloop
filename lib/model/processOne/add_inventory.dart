// To parse this JSON data, do
//
//     final addInventory = addInventoryFromMap(jsonString);

import 'dart:convert';

AddInventory? addInventoryFromMap(String str) =>
    AddInventory.fromMap(json.decode(str));

String addInventoryToMapTypeMassenErfassung(
        ToAddInventoryTypeMassenErfassung? data) =>
    json.encode(data);

String addInventoryToMapTypeEinzelprufung(
        ToAddInventoryTypeMassenErfassung? data) =>
    json.encode(data);

class ToAddInventoryTypeMassenErfassung {
  String type;
  String productId;
  int stock;
  int damagedStock;

  ToAddInventoryTypeMassenErfassung(
      {required this.type,
      required this.productId,
      required this.stock,
      required this.damagedStock});

  Map<String, dynamic> toJson() => {
        'type': type,
        'product_id': productId,
        'stock': stock,
        'damaged_stock': damagedStock
      };
}

class AddInventory {
  AddInventory({
    this.status,
    this.msg,
  });

  String? status;
  String? msg;

  factory AddInventory.fromMap(Map<String, dynamic> json) => AddInventory(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "msg": msg,
      };
}
