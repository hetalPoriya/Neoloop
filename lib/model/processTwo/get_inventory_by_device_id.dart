// To parse this JSON data, do
//
//     final getInventoryByDeviceId = getInventoryByDeviceIdFromJson(jsonString);

import 'dart:convert';

GetInventoryByDeviceId getInventoryByDeviceIdFromJson(String str) =>
    GetInventoryByDeviceId.fromJson(json.decode(str));

String getInventoryByDeviceIdToJson(ToGetInventoryByDeviceId data) =>
    json.encode(data.toJson());

class ToGetInventoryByDeviceId {
  ToGetInventoryByDeviceId({
    this.deviceId,
  });

  String? deviceId;

  Map<String, dynamic> toJson() => {
        "device_id": deviceId,
      };
}

class GetInventoryByDeviceId {
  GetInventoryByDeviceId({
    this.status,
    this.msg,
    this.inventoryDetails,
  });

  String? status;
  String? msg;
  InventoryDetails? inventoryDetails;

  factory GetInventoryByDeviceId.fromJson(Map<String, dynamic> json) =>
      GetInventoryByDeviceId(
        status: json["status"],
        msg: json["msg"],
        inventoryDetails: json["inventory_details"] == null
            ? null
            : InventoryDetails.fromJson(json["inventory_details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "inventory_details": inventoryDetails?.toJson(),
      };
}

class InventoryDetails {
  InventoryDetails({
    this.id,
    this.questionAnswer,
    this.sold,
    this.frontSideImages,
    this.backSideImages,
    this.productId,
    this.addedBy,
    this.damaged,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.deviceId,
    this.objectProductId,
    this.productInfo,
  });

  String? id;
  List<QuestionAnswer>? questionAnswer;
  String? sold;
  List<SideImage>? frontSideImages;
  List<SideImage>? backSideImages;
  String? productId;
  String? addedBy;
  String? damaged;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? deviceId;
  String? objectProductId;
  List<ProductInfo>? productInfo;

  factory InventoryDetails.fromJson(Map<String, dynamic> json) =>
      InventoryDetails(
        id: json["_id"],
        questionAnswer: json["question_answer"] == null
            ? []
            : List<QuestionAnswer>.from(json["question_answer"]!
                .map((x) => QuestionAnswer.fromJson(x))),
        sold: json["sold"],
        frontSideImages: json["front_side_images"] == null
            ? []
            : List<SideImage>.from(
                json["front_side_images"]!.map((x) => SideImage.fromJson(x))),
        backSideImages: json["back_side_images"] == null
            ? []
            : List<SideImage>.from(
                json["back_side_images"]!.map((x) => SideImage.fromJson(x))),
        productId: json["product_id"],
        addedBy: json["added_by"],
        damaged: json["damaged"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        deviceId: json["device_id"],
        objectProductId: json["object_product_id"],
        productInfo: json["product_info"] == null
            ? []
            : List<ProductInfo>.from(
                json["product_info"]!.map((x) => ProductInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "question_answer": questionAnswer == null
            ? []
            : List<dynamic>.from(questionAnswer!.map((x) => x.toJson())),
        "sold": sold,
        "front_side_images": frontSideImages == null
            ? []
            : List<dynamic>.from(frontSideImages!.map((x) => x.toJson())),
        "back_side_images": backSideImages == null
            ? []
            : List<dynamic>.from(backSideImages!.map((x) => x.toJson())),
        "product_id": productId,
        "added_by": addedBy,
        "damaged": damaged,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "device_id": deviceId,
        "object_product_id": objectProductId,
        "product_info": productInfo == null
            ? []
            : List<dynamic>.from(productInfo!.map((x) => x.toJson())),
      };
}

class SideImage {
  SideImage({
    this.documentUniqueId,
    this.documentTags,
  });

  String? documentUniqueId;
  String? documentTags;

  factory SideImage.fromJson(Map<String, dynamic> json) => SideImage(
        documentUniqueId: json["document_unique_id"],
        documentTags: json["document_tags"],
      );

  Map<String, dynamic> toJson() => {
        "document_unique_id": documentUniqueId,
        "document_tags": documentTags,
      };
}

class ProductInfo {
  ProductInfo({
    this.id,
    this.documentUniqueId,
    this.price,
    this.published,
    this.onlineShop,
    this.discount,
    this.stock,
    this.soldPieces,
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
    this.varientProducts,
    this.relatedProducts,
    this.locationId,
    this.damagedStock,
    this.soldStock,
    this.highlights,
    this.showInApps,
    this.smartDevice,
    this.productImageUrl,
  });

  String? id;
  List<String>? documentUniqueId;
  String? price;
  String? published;
  String? onlineShop;
  String? discount;
  int? stock;
  int? soldPieces;
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
  List<String>? varientProducts;
  List<String>? relatedProducts;
  String? locationId;
  int? damagedStock;
  int? soldStock;
  List<String>? highlights;
  List<String>? showInApps;
  bool? smartDevice;
  String? productImageUrl;

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        id: json["_id"],
        documentUniqueId: json["document_unique_id"] == null
            ? []
            : List<String>.from(json["document_unique_id"]!.map((x) => x)),
        price: json["price"],
        published: json["published"],
        onlineShop: json["online_shop"],
        discount: json["discount"],
        stock: json["stock"],
        soldPieces: json["sold_pieces"],
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
        varientProducts: json["varient_products"] == null
            ? []
            : List<String>.from(json["varient_products"]!.map((x) => x)),
        relatedProducts: json["related_products"] == null
            ? []
            : List<String>.from(json["related_products"]!.map((x) => x)),
        locationId: json["location_id"],
        damagedStock: json["damaged_stock"],
        soldStock: json["sold_stock"],
        highlights: json["highlights"] == null
            ? []
            : List<String>.from(json["highlights"]!.map((x) => x)),
        showInApps: json["show_in_apps"] == null
            ? []
            : List<String>.from(json["show_in_apps"]!.map((x) => x)),
        smartDevice: json["smart_device"],
        productImageUrl: json["product_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "document_unique_id": documentUniqueId == null
            ? []
            : List<dynamic>.from(documentUniqueId!.map((x) => x)),
        "price": price,
        "published": published,
        "online_shop": onlineShop,
        "discount": discount,
        "stock": stock,
        "sold_pieces": soldPieces,
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
        "varient_products": varientProducts == null
            ? []
            : List<dynamic>.from(varientProducts!.map((x) => x)),
        "related_products": relatedProducts == null
            ? []
            : List<dynamic>.from(relatedProducts!.map((x) => x)),
        "location_id": locationId,
        "damaged_stock": damagedStock,
        "sold_stock": soldStock,
        "highlights": highlights == null
            ? []
            : List<dynamic>.from(highlights!.map((x) => x)),
        "show_in_apps": showInApps == null
            ? []
            : List<dynamic>.from(showInApps!.map((x) => x)),
        "smart_device": smartDevice,
        "product_image_url": productImageUrl,
      };
}

class QuestionAnswer {
  QuestionAnswer({
    this.question,
    this.answer,
  });

  String? question;
  String? answer;

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}
