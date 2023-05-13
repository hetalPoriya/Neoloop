// To parse this JSON data, do
//
//     final searchProducts = searchProductsFromMap(jsonString);

import 'dart:convert';

List<SearchProducts?>? searchProductsFromMap(
        String str) =>
    json.decode(str) == null
        ? []
        : List<SearchProducts?>.from(
            json.decode(str)!.map((x) => SearchProducts.fromMap(x)));

String searchProductsToMap(ToSearchProduct data) => json.encode(data.toJson());

class ToSearchProduct {
  String producttypeId;
  String searchKeyword;

  Map<String, dynamic> toJson() => {
        'producttype_id': producttypeId,
        'search_keyword': searchKeyword,
      };

  ToSearchProduct({required this.producttypeId, required this.searchKeyword});
}

class SearchProducts {
  SearchProducts({
    this.id,
    this.color,
    this.ecosharkSerialNo,
    this.producttypeId,
    this.producttypeInfo,
    this.productName,
    this.undamagedStorage,
    this.damagedStorage,
    this.productImageUrl,
  });

  String? id;
  String? color;
  String? ecosharkSerialNo;
  String? producttypeId;
  List<ProducttypeInfo?>? producttypeInfo;
  String? productName;
  String? undamagedStorage;
  String? damagedStorage;
  String? productImageUrl;

  factory SearchProducts.fromMap(Map<String, dynamic> json) => SearchProducts(
        id: json["_id"],
        color: json["color"],
        ecosharkSerialNo: json["ecoshark_serial_no"],
        producttypeId: json["producttype_id"],
        producttypeInfo: json["producttype_info"] == null
            ? []
            : json["producttype_info"] == null
                ? []
                : List<ProducttypeInfo?>.from(json["producttype_info"]!
                    .map((x) => ProducttypeInfo.fromMap(x))),
        productName: json["product_name"],
        undamagedStorage: json["undamaged_storage"],
        damagedStorage: json["damaged_storage"],
        productImageUrl: json["product_image_url"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "color": color,
        "ecoshark_serial_no": ecosharkSerialNo,
        "producttype_id": producttypeId,
        "producttype_info": producttypeInfo == null
            ? []
            : producttypeInfo == null
                ? []
                : List<dynamic>.from(producttypeInfo!.map((x) => x!.toMap())),
        "product_name": productName,
        "undamaged_storage": undamagedStorage,
        "damaged_storage": damagedStorage,
        "product_image_url": productImageUrl,
      };
}

class ProducttypeInfo {
  ProducttypeInfo({
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

  factory ProducttypeInfo.fromMap(Map<String, dynamic> json) => ProducttypeInfo(
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
