// To parse this JSON data, do
//
//     final assignInventoryToOrderItem = assignInventoryToOrderItemFromJson(jsonString);

import 'dart:convert';

AssignInventoryToOrderItem assignInventoryToOrderItemFromJson(String str) =>
    AssignInventoryToOrderItem.fromJson(json.decode(str));

String assignInventoryToOrderItemToJson(ToAssignInventoryToOrderItem data) =>
    json.encode(data.toJson());

class ToAssignInventoryToOrderItem {
  ToAssignInventoryToOrderItem(
      {this.orderItemId,
      this.customerId,
      this.inventoryId,
      this.orderNo,
      this.soldBy,
      this.pickedQuantity,
      this.orderItemProductId});

  String? orderItemId;
  String? customerId;
  String? orderNo;
  String? inventoryId;
  String? soldBy;
  String? pickedQuantity;
  String? orderItemProductId;

  Map<String, dynamic> toJson() => {
        "order_item_id": orderItemId,
        "customer_id": customerId,
        "order_no": orderNo,
        "inventory_id": inventoryId,
        "sold_by": soldBy,
        "picked_quantity": pickedQuantity,
        "order_item_product_id": orderItemProductId,
      };
}

// class ToAssignInventoryToOrderItemForProductMassenErfassung {
//   ToAssignInventoryToOrderItemForProductMassenErfassung({
//     this.orderItemId,
//     this.customerId,
//     this.orderNo,
//     this.pickedQuantity,
//   });
//
//   String? orderItemId;
//   String? customerId;
//   String? orderNo;
//   String? pickedQuantity;
//
//   Map<String, dynamic> toJson() => {
//         "order_item_id": orderItemId,
//         "customer_id": customerId,
//         "order_no": orderNo,
//         "picked_quantity": pickedQuantity,
//       };
// }
//
// class ToAssignInventoryToOrderItemForPackageEinzelprufung {
//   ToAssignInventoryToOrderItemForPackageEinzelprufung(
//       {this.orderItemId,
//       this.customerId,
//       this.inventoryId,
//       this.orderNo,
//       this.soldBy,
//       this.orderItemProductId});
//
//   String? orderItemId;
//   String? customerId;
//   String? orderNo;
//   String? inventoryId;
//   String? soldBy;
//   String? orderItemProductId;
//
//   Map<String, dynamic> toJson() => {
//         "order_item_id": orderItemId,
//         "customer_id": customerId,
//         "order_no": orderNo,
//         "inventory_id": inventoryId,
//         "sold_by": soldBy,
//         "order_item_product_id ": orderItemProductId,
//       };
// }
//
// class ToAssignInventoryToOrderItemForPackageMassenErfassung {
//   ToAssignInventoryToOrderItemForPackageMassenErfassung(
//       {this.orderItemId,
//       this.customerId,
//       this.orderNo,
//       this.pickedQuantity,
//       this.orderItemProductId});
//
//   String? orderItemId;
//   String? customerId;
//   String? orderNo;
//   String? pickedQuantity;
//   String? orderItemProductId;
//
//   Map<String, dynamic> toJson() => {
//         "order_item_id": orderItemId,
//         "customer_id": customerId,
//         "order_no": orderNo,
//         "picked_quantity": pickedQuantity,
//         "order_item_product_id": orderItemProductId,
//       };
// }

class AssignInventoryToOrderItem {
  AssignInventoryToOrderItem({
    this.status,
    this.msg,
    this.data,
    this.orderStatusDates,
  });

  String? status;
  String? msg;
  Data? data;
  List<OrderStatusDate>? orderStatusDates;

  factory AssignInventoryToOrderItem.fromJson(Map<String, dynamic> json) =>
      AssignInventoryToOrderItem(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        orderStatusDates: json["order_status_dates"] == null
            ? []
            : List<OrderStatusDate>.from(json["order_status_dates"]!
                .map((x) => OrderStatusDate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
        "order_status_dates": orderStatusDates == null
            ? []
            : List<dynamic>.from(orderStatusDates!.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.n,
    this.electionId,
    this.opTime,
    this.nModified,
    this.ok,
    this.clusterTime,
    this.operationTime,
  });

  int? n;
  String? electionId;
  OpTime? opTime;
  int? nModified;
  int? ok;
  ClusterTime? clusterTime;
  String? operationTime;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        n: json["n"],
        electionId: json["electionId"],
        opTime: json["opTime"] == null ? null : OpTime.fromJson(json["opTime"]),
        nModified: json["nModified"],
        ok: json["ok"],
        clusterTime: json["\u0024clusterTime"] == null
            ? null
            : ClusterTime.fromJson(json["\u0024clusterTime"]),
        operationTime: json["operationTime"],
      );

  Map<String, dynamic> toJson() => {
        "n": n,
        "electionId": electionId,
        "opTime": opTime?.toJson(),
        "nModified": nModified,
        "ok": ok,
        "\u0024clusterTime": clusterTime?.toJson(),
        "operationTime": operationTime,
      };
}

class ClusterTime {
  ClusterTime({
    this.clusterTime,
    this.signature,
  });

  String? clusterTime;
  Signature? signature;

  factory ClusterTime.fromJson(Map<String, dynamic> json) => ClusterTime(
        clusterTime: json["clusterTime"],
        signature: json["signature"] == null
            ? null
            : Signature.fromJson(json["signature"]),
      );

  Map<String, dynamic> toJson() => {
        "clusterTime": clusterTime,
        "signature": signature?.toJson(),
      };
}

class Signature {
  Signature({
    this.hash,
    this.keyId,
  });

  String? hash;
  String? keyId;

  factory Signature.fromJson(Map<String, dynamic> json) => Signature(
        hash: json["hash"],
        keyId: json["keyId"],
      );

  Map<String, dynamic> toJson() => {
        "hash": hash,
        "keyId": keyId,
      };
}

class OpTime {
  OpTime({
    this.ts,
    this.t,
  });

  String? ts;
  int? t;

  factory OpTime.fromJson(Map<String, dynamic> json) => OpTime(
        ts: json["ts"],
        t: json["t"],
      );

  Map<String, dynamic> toJson() => {
        "ts": ts,
        "t": t,
      };
}

class OrderStatusDate {
  OrderStatusDate({
    this.placed,
    this.process,
    this.readyToDispatch,
    this.dispatched,
    this.delivered,
    this.returnRequest,
    this.returned,
  });

  DateTime? placed;
  DateTime? process;
  String? readyToDispatch;
  String? dispatched;
  String? delivered;
  String? returnRequest;
  String? returned;

  factory OrderStatusDate.fromJson(Map<String, dynamic> json) =>
      OrderStatusDate(
        placed: json["placed"] == null ? null : DateTime.parse(json["placed"]),
        process:
            json["process"] == null ? null : DateTime.parse(json["process"]),
        readyToDispatch: json["ready_to_dispatch"],
        dispatched: json["dispatched"],
        delivered: json["delivered"],
        returnRequest: json["return_request"],
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "placed": placed?.toIso8601String(),
        "process": process?.toIso8601String(),
        "ready_to_dispatch": readyToDispatch,
        "dispatched": dispatched,
        "delivered": delivered,
        "return_request": returnRequest,
        "returned": returned,
      };
}
