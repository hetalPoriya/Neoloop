// To parse this JSON data, do
//
//     final getPackageOrderItemInventory = getPackageOrderItemInventoryFromMap(jsonString);

import 'dart:convert';

GetPackageOrderItemInventory getPackageOrderItemInventoryFromMap(String str) =>
    GetPackageOrderItemInventory.fromJson(json.decode(str));

String getPackageOrderItemInventoryToMap(TOGetPackageOrderItemInventory data) =>
    json.encode(data.toJson());

class TOGetPackageOrderItemInventory {
  TOGetPackageOrderItemInventory({required this.orderItemId});
  String orderItemId;

  Map<String, dynamic> toJson() => {
        "order_item_id": orderItemId,
      };
}

class GetPackageOrderItemInventory {
  GetPackageOrderItemInventory({
    this.status,
    this.packageName,
    this.data,
  });

  String? status;
  String? packageName;
  List<GetPackageOrderItemInventoryList>? data;

  factory GetPackageOrderItemInventory.fromJson(Map<String, dynamic> json) =>
      GetPackageOrderItemInventory(
        status: json["status"],
        packageName: json["package_name"],
        data: json["data"] == null
            ? []
            : List<GetPackageOrderItemInventoryList>.from(json["data"]!
                .map((x) => GetPackageOrderItemInventoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "package_name": packageName,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetPackageOrderItemInventoryList {
  GetPackageOrderItemInventoryList({
    this.productInfo,
    this.requiredQuantity,
    this.filledQuantity,
  });

  ProductInfo? productInfo;
  int? requiredQuantity;
  int? filledQuantity;

  factory GetPackageOrderItemInventoryList.fromJson(
          Map<String, dynamic> json) =>
      GetPackageOrderItemInventoryList(
        productInfo: json["product_info"] == null
            ? null
            : ProductInfo.fromJson(json["product_info"]),
        requiredQuantity: json["required_quantity"],
        filledQuantity: json["filled_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_info": productInfo?.toJson(),
        "required_quantity": requiredQuantity,
        "filled_quantity": filledQuantity,
      };
}

class ProductInfo {
  ProductInfo({
    this.id,
    this.documentUniqueId,
    this.price,
    this.tax,
    this.grossprice,
    this.published,
    this.onlineShop,
    this.discount,
    this.producttypeId,
    this.productName,
    this.undamagedStorage,
    this.damagedStorage,
    this.ecosharkSerialNo,
    this.manufacturerSerialNo,
    this.power,
    this.length,
    this.width,
    this.height,
    this.weight,
    this.color,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.onlineShopDescription,
    this.shipping,
    this.relatedProducts,
    this.varientProducts,
    this.damagedStock,
    this.stock,
    this.soldStock,
    this.locationId,
    this.highlights,
    this.producttypeInfo,
  });

  String? id;
  List<String>? documentUniqueId;
  String? price;
  String? tax;
  String? grossprice;
  String? published;
  String? onlineShop;
  String? discount;
  String? producttypeId;
  String? productName;
  String? undamagedStorage;
  String? damagedStorage;
  String? ecosharkSerialNo;
  String? manufacturerSerialNo;
  String? power;
  String? length;
  String? width;
  String? height;
  String? weight;
  String? color;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? onlineShopDescription;
  String? shipping;
  List<dynamic>? relatedProducts;
  List<dynamic>? varientProducts;
  int? damagedStock;
  int? stock;
  int? soldStock;
  String? locationId;
  List<String>? highlights;
  List<ProducttypeInfo>? producttypeInfo;

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        id: json["_id"],
        documentUniqueId: json["document_unique_id"] == null
            ? []
            : List<String>.from(json["document_unique_id"]!.map((x) => x)),
        price: json["price"],
        tax: json["tax"],
        grossprice: json["grossprice"],
        published: json["published"],
        onlineShop: json["online_shop"],
        discount: json["discount"],
        producttypeId: json["producttype_id"],
        productName: json["product_name"],
        undamagedStorage: json["undamaged_storage"],
        damagedStorage: json["damaged_storage"],
        ecosharkSerialNo: json["ecoshark_serial_no"],
        manufacturerSerialNo: json["manufacturer_serial_no"],
        power: json["power"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        weight: json["weight"],
        color: json["color"],
        description: json["description"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        onlineShopDescription: json["online_shop_description"],
        shipping: json["shipping"],
        relatedProducts: json["related_products"] == null
            ? []
            : List<dynamic>.from(json["related_products"]!.map((x) => x)),
        varientProducts: json["varient_products"] == null
            ? []
            : List<dynamic>.from(json["varient_products"]!.map((x) => x)),
        damagedStock: json["damaged_stock"],
        stock: json["stock"],
        soldStock: json["sold_stock"],
        locationId: json["location_id"],
        highlights: json["highlights"] == null
            ? []
            : List<String>.from(json["highlights"]!.map((x) => x)),
        producttypeInfo: json["producttype_info"] == null
            ? []
            : List<ProducttypeInfo>.from(json["producttype_info"]!
                .map((x) => ProducttypeInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "document_unique_id": documentUniqueId == null
            ? []
            : List<dynamic>.from(documentUniqueId!.map((x) => x)),
        "price": price,
        "tax": tax,
        "grossprice": grossprice,
        "published": published,
        "online_shop": onlineShop,
        "discount": discount,
        "producttype_id": producttypeId,
        "product_name": productName,
        "undamaged_storage": undamagedStorage,
        "damaged_storage": damagedStorage,
        "ecoshark_serial_no": ecosharkSerialNo,
        "manufacturer_serial_no": manufacturerSerialNo,
        "power": power,
        "length": length,
        "width": width,
        "height": height,
        "weight": weight,
        "color": color,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "online_shop_description": onlineShopDescription,
        "shipping": shipping,
        "related_products": relatedProducts == null
            ? []
            : List<dynamic>.from(relatedProducts!.map((x) => x)),
        "varient_products": varientProducts == null
            ? []
            : List<dynamic>.from(varientProducts!.map((x) => x)),
        "damaged_stock": damagedStock,
        "stock": stock,
        "sold_stock": soldStock,
        "location_id": locationId,
        "highlights": highlights == null
            ? []
            : List<dynamic>.from(highlights!.map((x) => x)),
        "producttype_info": producttypeInfo == null
            ? []
            : List<dynamic>.from(producttypeInfo!.map((x) => x.toJson())),
      };
}

class ProducttypeInfo {
  ProducttypeInfo({
    this.id,
    this.name,
    this.type,
    this.v,
  });

  String? id;
  String? name;
  String? type;
  int? v;

  factory ProducttypeInfo.fromJson(Map<String, dynamic> json) =>
      ProducttypeInfo(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": type,
        "__v": v,
      };
}
