// To parse this JSON data, do
//
//     final allOrderDetails = allOrderDetailsFromMap(jsonString);

import 'dart:convert';

AllOrderDetails allOrderDetailsFromMap(String str) =>
    AllOrderDetails.fromMap(json.decode(str));

String allOrderDetailsToMap(ToAllOrderModel data) => json.encode(data.toJson());

class ToAllOrderModel {
  ToAllOrderModel({required this.orderId});
  String orderId;

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
      };
}

class AllOrderDetails {
  AllOrderDetails({
    this.status,
    this.result,
  });

  String? status;
  Result? result;

  factory AllOrderDetails.fromMap(Map<String, dynamic> json) => AllOrderDetails(
        status: json["status"],
        result: json["result"] == null ? null : Result.fromMap(json["result"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "result": result?.toMap(),
      };
}

class Result {
  Result({
    this.orderDetails,
    this.orderItems,
    this.orderItemsDetails,
    this.orderTaxDetails,
    this.orderInvoiceDetails,
    this.customerInfo,
  });

  OrderDetails? orderDetails;
  List<OrderItem>? orderItems;
  List<OrderItemsDetail>? orderItemsDetails;
  List<OrderTaxDetail>? orderTaxDetails;
  List<OrderInvoiceDetail>? orderInvoiceDetails;
  CustomerInfoForAllDetails? customerInfo;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        orderDetails: json["order_details"] == null
            ? null
            : OrderDetails.fromMap(json["order_details"]),
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(
                json["order_items"]!.map((x) => OrderItem.fromMap(x))),
        orderItemsDetails: json["order_items_details"] == null
            ? []
            : List<OrderItemsDetail>.from(json["order_items_details"]!
                .map((x) => OrderItemsDetail.fromMap(x))),
        orderTaxDetails: json["order_tax_details"] == null
            ? []
            : List<OrderTaxDetail>.from(json["order_tax_details"]!
                .map((x) => OrderTaxDetail.fromMap(x))),
        orderInvoiceDetails: json["order_invoice_details"] == null
            ? []
            : List<OrderInvoiceDetail>.from(json["order_invoice_details"]!
                .map((x) => OrderInvoiceDetail.fromMap(x))),
        customerInfo: json["customer_info"] == null
            ? null
            : CustomerInfoForAllDetails.fromMap(json["customer_info"]),
      );

  Map<String, dynamic> toMap() => {
        "order_details": orderDetails?.toMap(),
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toMap())),
        "order_items_details": orderItemsDetails == null
            ? []
            : List<dynamic>.from(orderItemsDetails!.map((x) => x.toMap())),
        "order_tax_details": orderTaxDetails == null
            ? []
            : List<dynamic>.from(orderTaxDetails!.map((x) => x.toMap())),
        "order_invoice_details": orderInvoiceDetails == null
            ? []
            : List<dynamic>.from(orderInvoiceDetails!.map((x) => x.toMap())),
        "customer_info": customerInfo?.toMap(),
      };
}

class CustomerInfoForAllDetails {
  CustomerInfoForAllDetails({
    this.roles,
    this.companies,
    this.oldTicketNum,
    this.deviceType,
    this.onlineStatus,
    this.companiesWithRoles,
    this.brokerbrandarray,
    this.brokerarray,
    this.statusbrandarray,
    this.statusarray,
    this.employeebrandarray,
    this.employeearray,
    this.companycode,
    this.companydata,
    this.contractdata,
    this.companydatacheckup,
    this.vermittlerstatusforbrokermanager,
    this.ceodata,
    this.shareholderdata,
    this.ceodatacheckup,
    this.shareholderdatacheckup,
    this.middledatacheckup,
    this.welcomevideoscreenshotnum,
    this.logincount,
    this.registerationEditable,
    this.ecosharkSellerData,
    this.ecosharkCustomerData,
    this.employeeRoleButtons,
    this.id,
    this.registeredTime,
    this.customerStatus,
    this.customerno,
    this.companycodes,
    this.title,
    this.usertitle,
    this.firstname,
    this.lastname,
    this.email,
    this.companyname,
    this.password,
    this.attempts,
    this.blockedAt,
    this.emailSent,
    this.emailVerify,
    this.mobileVerify,
    this.status,
    this.lastOnline,
    this.strassa,
    this.strno,
    this.plz,
    this.city,
    this.currentCountry,
    this.contactno,
    this.v,
  });

  List<String>? roles;
  List<String>? companies;
  List<dynamic>? oldTicketNum;
  int? deviceType;
  int? onlineStatus;
  List<String>? companiesWithRoles;
  List<dynamic>? brokerbrandarray;
  List<dynamic>? brokerarray;
  List<dynamic>? statusbrandarray;
  List<dynamic>? statusarray;
  List<dynamic>? employeebrandarray;
  List<dynamic>? employeearray;
  List<String>? companycode;
  List<dynamic>? companydata;
  List<dynamic>? contractdata;
  List<dynamic>? companydatacheckup;
  List<dynamic>? vermittlerstatusforbrokermanager;
  List<dynamic>? ceodata;
  List<dynamic>? shareholderdata;
  List<dynamic>? ceodatacheckup;
  List<dynamic>? shareholderdatacheckup;
  List<dynamic>? middledatacheckup;
  int? welcomevideoscreenshotnum;
  String? logincount;
  String? registerationEditable;
  List<dynamic>? ecosharkSellerData;
  List<EcosharkCustomerDatum>? ecosharkCustomerData;
  List<dynamic>? employeeRoleButtons;
  String? id;
  String? registeredTime;
  String? customerStatus;
  String? customerno;
  String? companycodes;
  String? title;
  String? usertitle;
  String? firstname;
  String? lastname;
  String? email;
  String? companyname;
  String? password;
  String? attempts;
  String? blockedAt;
  String? emailSent;
  String? emailVerify;
  String? mobileVerify;
  String? status;
  String? lastOnline;
  String? strassa;
  String? strno;
  String? plz;
  String? city;
  String? currentCountry;
  String? contactno;
  int? v;

  factory CustomerInfoForAllDetails.fromMap(Map<String, dynamic> json) =>
      CustomerInfoForAllDetails(
        roles: json["roles"] == null
            ? []
            : List<String>.from(json["roles"]!.map((x) => x)),
        companies: json["companies"] == null
            ? []
            : List<String>.from(json["companies"]!.map((x) => x)),
        oldTicketNum: json["oldTicketNum"] == null
            ? []
            : List<dynamic>.from(json["oldTicketNum"]!.map((x) => x)),
        deviceType: json["device_type"],
        onlineStatus: json["online_status"],
        companiesWithRoles: json["companies_with_roles"] == null
            ? []
            : List<String>.from(json["companies_with_roles"]!.map((x) => x)),
        brokerbrandarray: json["brokerbrandarray"] == null
            ? []
            : List<dynamic>.from(json["brokerbrandarray"]!.map((x) => x)),
        brokerarray: json["brokerarray"] == null
            ? []
            : List<dynamic>.from(json["brokerarray"]!.map((x) => x)),
        statusbrandarray: json["statusbrandarray"] == null
            ? []
            : List<dynamic>.from(json["statusbrandarray"]!.map((x) => x)),
        statusarray: json["statusarray"] == null
            ? []
            : List<dynamic>.from(json["statusarray"]!.map((x) => x)),
        employeebrandarray: json["employeebrandarray"] == null
            ? []
            : List<dynamic>.from(json["employeebrandarray"]!.map((x) => x)),
        employeearray: json["employeearray"] == null
            ? []
            : List<dynamic>.from(json["employeearray"]!.map((x) => x)),
        companycode: json["companycode"] == null
            ? []
            : List<String>.from(json["companycode"]!.map((x) => x)),
        companydata: json["companydata"] == null
            ? []
            : List<dynamic>.from(json["companydata"]!.map((x) => x)),
        contractdata: json["contractdata"] == null
            ? []
            : List<dynamic>.from(json["contractdata"]!.map((x) => x)),
        companydatacheckup: json["companydatacheckup"] == null
            ? []
            : List<dynamic>.from(json["companydatacheckup"]!.map((x) => x)),
        vermittlerstatusforbrokermanager:
            json["vermittlerstatusforbrokermanager"] == null
                ? []
                : List<dynamic>.from(
                    json["vermittlerstatusforbrokermanager"]!.map((x) => x)),
        ceodata: json["ceodata"] == null
            ? []
            : List<dynamic>.from(json["ceodata"]!.map((x) => x)),
        shareholderdata: json["shareholderdata"] == null
            ? []
            : List<dynamic>.from(json["shareholderdata"]!.map((x) => x)),
        ceodatacheckup: json["ceodatacheckup"] == null
            ? []
            : List<dynamic>.from(json["ceodatacheckup"]!.map((x) => x)),
        shareholderdatacheckup: json["shareholderdatacheckup"] == null
            ? []
            : List<dynamic>.from(json["shareholderdatacheckup"]!.map((x) => x)),
        middledatacheckup: json["middledatacheckup"] == null
            ? []
            : List<dynamic>.from(json["middledatacheckup"]!.map((x) => x)),
        welcomevideoscreenshotnum: json["welcomevideoscreenshotnum"],
        logincount: json["logincount"],
        registerationEditable: json["registeration_editable"],
        ecosharkSellerData: json["ecoshark_seller_data"] == null
            ? []
            : List<dynamic>.from(json["ecoshark_seller_data"]!.map((x) => x)),
        ecosharkCustomerData: json["ecoshark_customer_data"] == null
            ? []
            : List<EcosharkCustomerDatum>.from(json["ecoshark_customer_data"]!
                .map((x) => EcosharkCustomerDatum.fromMap(x))),
        employeeRoleButtons: json["employee_role_buttons"] == null
            ? []
            : List<dynamic>.from(json["employee_role_buttons"]!.map((x) => x)),
        id: json["_id"],
        registeredTime: json["registered_time"],
        customerStatus: json["customer_status"],
        customerno: json["customerno"],
        companycodes: json["companycodes"],
        title: json["title"],
        usertitle: json["usertitle"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        companyname: json["companyname"],
        password: json["password"],
        attempts: json["attempts"],
        blockedAt: json["blocked_at"],
        emailSent: json["email_sent"],
        emailVerify: json["email_verify"],
        mobileVerify: json["mobile_verify"],
        status: json["status"],
        lastOnline: json["last_online"],
        strassa: json["strassa"],
        strno: json["strno"],
        plz: json["plz"],
        city: json["city"],
        currentCountry: json["current_country"],
        contactno: json["contactno"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "companies": companies == null
            ? []
            : List<dynamic>.from(companies!.map((x) => x)),
        "oldTicketNum": oldTicketNum == null
            ? []
            : List<dynamic>.from(oldTicketNum!.map((x) => x)),
        "device_type": deviceType,
        "online_status": onlineStatus,
        "companies_with_roles": companiesWithRoles == null
            ? []
            : List<dynamic>.from(companiesWithRoles!.map((x) => x)),
        "brokerbrandarray": brokerbrandarray == null
            ? []
            : List<dynamic>.from(brokerbrandarray!.map((x) => x)),
        "brokerarray": brokerarray == null
            ? []
            : List<dynamic>.from(brokerarray!.map((x) => x)),
        "statusbrandarray": statusbrandarray == null
            ? []
            : List<dynamic>.from(statusbrandarray!.map((x) => x)),
        "statusarray": statusarray == null
            ? []
            : List<dynamic>.from(statusarray!.map((x) => x)),
        "employeebrandarray": employeebrandarray == null
            ? []
            : List<dynamic>.from(employeebrandarray!.map((x) => x)),
        "employeearray": employeearray == null
            ? []
            : List<dynamic>.from(employeearray!.map((x) => x)),
        "companycode": companycode == null
            ? []
            : List<dynamic>.from(companycode!.map((x) => x)),
        "companydata": companydata == null
            ? []
            : List<dynamic>.from(companydata!.map((x) => x)),
        "contractdata": contractdata == null
            ? []
            : List<dynamic>.from(contractdata!.map((x) => x)),
        "companydatacheckup": companydatacheckup == null
            ? []
            : List<dynamic>.from(companydatacheckup!.map((x) => x)),
        "vermittlerstatusforbrokermanager":
            vermittlerstatusforbrokermanager == null
                ? []
                : List<dynamic>.from(
                    vermittlerstatusforbrokermanager!.map((x) => x)),
        "ceodata":
            ceodata == null ? [] : List<dynamic>.from(ceodata!.map((x) => x)),
        "shareholderdata": shareholderdata == null
            ? []
            : List<dynamic>.from(shareholderdata!.map((x) => x)),
        "ceodatacheckup": ceodatacheckup == null
            ? []
            : List<dynamic>.from(ceodatacheckup!.map((x) => x)),
        "shareholderdatacheckup": shareholderdatacheckup == null
            ? []
            : List<dynamic>.from(shareholderdatacheckup!.map((x) => x)),
        "middledatacheckup": middledatacheckup == null
            ? []
            : List<dynamic>.from(middledatacheckup!.map((x) => x)),
        "welcomevideoscreenshotnum": welcomevideoscreenshotnum,
        "logincount": logincount,
        "registeration_editable": registerationEditable,
        "ecoshark_seller_data": ecosharkSellerData == null
            ? []
            : List<dynamic>.from(ecosharkSellerData!.map((x) => x)),
        "ecoshark_customer_data": ecosharkCustomerData == null
            ? []
            : List<dynamic>.from(ecosharkCustomerData!.map((x) => x.toMap())),
        "employee_role_buttons": employeeRoleButtons == null
            ? []
            : List<dynamic>.from(employeeRoleButtons!.map((x) => x)),
        "_id": id,
        "registered_time": registeredTime,
        "customer_status": customerStatus,
        "customerno": customerno,
        "companycodes": companycodes,
        "title": title,
        "usertitle": usertitle,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "companyname": companyname,
        "password": password,
        "attempts": attempts,
        "blocked_at": blockedAt,
        "email_sent": emailSent,
        "email_verify": emailVerify,
        "mobile_verify": mobileVerify,
        "status": status,
        "last_online": lastOnline,
        "strassa": strassa,
        "strno": strno,
        "plz": plz,
        "city": city,
        "current_country": currentCountry,
        "contactno": contactno,
        "__v": v,
      };
}

class EcosharkCustomerDatum {
  EcosharkCustomerDatum({
    this.taxNo,
    this.street,
    this.streetNumber,
    this.zipCode,
    this.city,
    this.country,
  });

  String? taxNo;
  String? street;
  String? streetNumber;
  String? zipCode;
  String? city;
  String? country;

  factory EcosharkCustomerDatum.fromMap(Map<String, dynamic> json) =>
      EcosharkCustomerDatum(
        taxNo: json["tax_no"],
        street: json["street"],
        streetNumber: json["street_number"],
        zipCode: json["zip_code"],
        city: json["city"],
        country: json["country"],
      );

  Map<String, dynamic> toMap() => {
        "tax_no": taxNo,
        "street": street,
        "street_number": streetNumber,
        "zip_code": zipCode,
        "city": city,
        "country": country,
      };
}

class OrderDetails {
  OrderDetails({
    this.sellerCommissionPaid,
    this.shippingAddress,
    this.orderStatusDates,
    this.returned,
    this.returnRequest,
    this.id,
    this.customerId,
    this.customerType,
    this.sellerApplied,
    this.sellerId,
    this.sellerCode,
    this.sellerDiscountPercentage,
    this.sellerDiscount,
    this.taxNo,
    this.taxNoValid,
    this.taxNoDesc,
    this.taxPercentage,
    this.taxAmount,
    this.taxCountry,
    this.discount,
    this.totalDiscount,
    this.netAmount,
    this.totalAmount,
    this.orderStatus,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.orderNo,
    this.invoiceFile,
  });

  String? sellerCommissionPaid;
  List<EcosharkCustomerDatum>? shippingAddress;
  List<OrderStatusDateAllOrder>? orderStatusDates;
  String? returned;
  String? returnRequest;
  String? id;
  String? customerId;
  String? customerType;
  String? sellerApplied;
  String? sellerId;
  String? sellerCode;
  String? sellerDiscountPercentage;
  String? sellerDiscount;
  String? taxNo;
  String? taxNoValid;
  String? taxNoDesc;
  String? taxPercentage;
  String? taxAmount;
  String? taxCountry;
  String? discount;
  String? totalDiscount;
  String? netAmount;
  String? totalAmount;
  String? orderStatus;
  String? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? orderNo;
  String? invoiceFile;

  factory OrderDetails.fromMap(Map<String, dynamic> json) => OrderDetails(
        sellerCommissionPaid: json["seller_commission_paid"],
        shippingAddress: json["shipping_address"] == null
            ? []
            : List<EcosharkCustomerDatum>.from(json["shipping_address"]!
                .map((x) => EcosharkCustomerDatum.fromMap(x))),
        orderStatusDates: json["order_status_dates"] == null
            ? []
            : List<OrderStatusDateAllOrder>.from(json["order_status_dates"]!
                .map((x) => OrderStatusDateAllOrder.fromMap(x))),
        returned: json["returned"],
        returnRequest: json["return_request"],
        id: json["_id"],
        customerId: json["customer_id"],
        customerType: json["customer_type"],
        sellerApplied: json["seller_applied"],
        sellerId: json["seller_id"],
        sellerCode: json["seller_code"],
        sellerDiscountPercentage: json["seller_discount_percentage"],
        sellerDiscount: json["seller_discount"],
        taxNo: json["tax_no"],
        taxNoValid: json["tax_no_valid"],
        taxNoDesc: json["tax_no_desc"],
        taxPercentage: json["tax_percentage"],
        taxAmount: json["tax_amount"],
        taxCountry: json["tax_country"],
        discount: json["discount"],
        totalDiscount: json["total_discount"],
        netAmount: json["net_amount"],
        totalAmount: json["total_amount"],
        orderStatus: json["order_status"],
        paymentStatus: json["payment_status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        orderNo: json["order_no"],
        invoiceFile: json["invoice_file"],
      );

  Map<String, dynamic> toMap() => {
        "seller_commission_paid": sellerCommissionPaid,
        "shipping_address": shippingAddress == null
            ? []
            : List<dynamic>.from(shippingAddress!.map((x) => x.toMap())),
        "order_status_dates": orderStatusDates == null
            ? []
            : List<dynamic>.from(orderStatusDates!.map((x) => x.toMap())),
        "returned": returned,
        "return_request": returnRequest,
        "_id": id,
        "customer_id": customerId,
        "customer_type": customerType,
        "seller_applied": sellerApplied,
        "seller_id": sellerId,
        "seller_code": sellerCode,
        "seller_discount_percentage": sellerDiscountPercentage,
        "seller_discount": sellerDiscount,
        "tax_no": taxNo,
        "tax_no_valid": taxNoValid,
        "tax_no_desc": taxNoDesc,
        "tax_percentage": taxPercentage,
        "tax_amount": taxAmount,
        "tax_country": taxCountry,
        "discount": discount,
        "total_discount": totalDiscount,
        "net_amount": netAmount,
        "total_amount": totalAmount,
        "order_status": orderStatus,
        "payment_status": paymentStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "order_no": orderNo,
        "invoice_file": invoiceFile,
      };
}

class OrderStatusDateAllOrder {
  OrderStatusDateAllOrder({
    this.placed,
    this.process,
    this.dispatched,
    this.delivered,
    this.returnRequest,
    this.returned,
  });

  DateTime? placed;
  String? process;
  String? dispatched;
  String? delivered;
  String? returnRequest;
  String? returned;

  factory OrderStatusDateAllOrder.fromMap(Map<String, dynamic> json) =>
      OrderStatusDateAllOrder(
        placed: json["placed"] == null ? null : DateTime.parse(json["placed"]),
        process: json["process"],
        dispatched: json["dispatched"],
        delivered: json["delivered"],
        returnRequest: json["return_request"],
        returned: json["returned"],
      );

  Map<String, dynamic> toMap() => {
        "placed": placed?.toIso8601String(),
        "process": process,
        "dispatched": dispatched,
        "delivered": delivered,
        "return_request": returnRequest,
        "returned": returned,
      };
}

class OrderInvoiceDetail {
  OrderInvoiceDetail({
    this.readyToSendEmail,
    this.verified,
    this.tags,
    this.manualTags,
    this.sendEmailToInsurance,
    this.id,
    this.documentType,
    this.documentSubType,
    this.productPartner,
    this.user,
    this.companycode,
    this.brand,
    this.uploadBy,
    this.ticketNo,
    this.documentName,
    this.billType,
    this.ecosharkInvoiceNo,
    this.createdBy,
    this.tax,
    this.pricewithtax,
    this.pricewithouttax,
    this.year,
    this.documentUniqueId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? readyToSendEmail;
  String? verified;
  List<String>? tags;
  List<String>? manualTags;
  String? sendEmailToInsurance;
  String? id;
  String? documentType;
  String? documentSubType;
  String? productPartner;
  String? user;
  String? companycode;
  String? brand;
  String? uploadBy;
  String? ticketNo;
  String? documentName;
  String? billType;
  String? ecosharkInvoiceNo;
  String? createdBy;
  String? tax;
  String? pricewithtax;
  String? pricewithouttax;
  String? year;
  String? documentUniqueId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory OrderInvoiceDetail.fromMap(Map<String, dynamic> json) =>
      OrderInvoiceDetail(
        readyToSendEmail: json["ready_to_send_email"],
        verified: json["verified"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        manualTags: json["manual_tags"] == null
            ? []
            : List<String>.from(json["manual_tags"]!.map((x) => x)),
        sendEmailToInsurance: json["send_email_to_insurance"],
        id: json["_id"],
        documentType: json["document_type"],
        documentSubType: json["document_sub_type"],
        productPartner: json["product_partner"],
        user: json["user"],
        companycode: json["companycode"],
        brand: json["brand"],
        uploadBy: json["upload_by"],
        ticketNo: json["ticket_no"],
        documentName: json["document_name"],
        billType: json["bill_type"],
        ecosharkInvoiceNo: json["ecoshark_invoice_no"],
        createdBy: json["created_by"],
        tax: json["tax"],
        pricewithtax: json["pricewithtax"],
        pricewithouttax: json["pricewithouttax"],
        year: json["year"],
        documentUniqueId: json["document_unique_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "ready_to_send_email": readyToSendEmail,
        "verified": verified,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "manual_tags": manualTags == null
            ? []
            : List<dynamic>.from(manualTags!.map((x) => x)),
        "send_email_to_insurance": sendEmailToInsurance,
        "_id": id,
        "document_type": documentType,
        "document_sub_type": documentSubType,
        "product_partner": productPartner,
        "user": user,
        "companycode": companycode,
        "brand": brand,
        "upload_by": uploadBy,
        "ticket_no": ticketNo,
        "document_name": documentName,
        "bill_type": billType,
        "ecoshark_invoice_no": ecosharkInvoiceNo,
        "created_by": createdBy,
        "tax": tax,
        "pricewithtax": pricewithtax,
        "pricewithouttax": pricewithouttax,
        "year": year,
        "document_unique_id": documentUniqueId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class OrderItem {
  OrderItem(
      {this.productId,
      this.ecosharkInventoryId,
      this.returnRequest,
      this.returned,
      this.paymentRefunded,
      this.pickedQuantity,
      this.allPickedup,
      this.id,
      this.orderId,
      this.itemType,
      this.itemId,
      this.itemName,
      this.quantity,
      this.discountPercentage,
      this.discount,
      this.sellerDiscount,
      this.totalDiscount,
      this.tax,
      this.totalNetAmount,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.grossprice});

  List<dynamic>? productId;
  List<dynamic>? ecosharkInventoryId;
  String? returnRequest;
  String? returned;
  String? paymentRefunded;
  List<PickedQuantity>? pickedQuantity;
  bool? allPickedup;
  String? id;
  String? orderId;
  String? itemType;
  String? itemId;
  String? itemName;
  String? quantity;
  String? discountPercentage;
  String? discount;
  String? sellerDiscount;
  String? totalDiscount;
  String? tax;
  String? totalNetAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? grossprice;

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        productId: json["product_id"] == null
            ? []
            : List<dynamic>.from(json["product_id"]!.map((x) => x)),
        ecosharkInventoryId: json["ecoshark_inventory_id"] == null
            ? []
            : List<dynamic>.from(json["ecoshark_inventory_id"]!.map((x) => x)),
        returnRequest: json["return_request"],
        returned: json["returned"],
        paymentRefunded: json["payment_refunded"],
        pickedQuantity: json["picked_quantity"] == null
            ? []
            : List<PickedQuantity>.from(json["picked_quantity"]!
                .map((x) => PickedQuantity.fromJson(x))),
        allPickedup: json["all_pickedup"],
        id: json["_id"],
        orderId: json["order_id"],
        itemType: json["item_type"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        quantity: json["quantity"],
        discountPercentage: json["discount_percentage"],
        discount: json["discount"],
        sellerDiscount: json["seller_discount"],
        totalDiscount: json["total_discount"],
        tax: json["tax"],
        totalNetAmount: json["total_net_amount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        grossprice: json["grossprice"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId == null
            ? []
            : List<dynamic>.from(productId!.map((x) => x)),
        "ecoshark_inventory_id": ecosharkInventoryId == null
            ? []
            : List<dynamic>.from(ecosharkInventoryId!.map((x) => x)),
        "return_request": returnRequest,
        "returned": returned,
        "payment_refunded": paymentRefunded,
        "picked_quantity": pickedQuantity == null
            ? []
            : List<dynamic>.from(pickedQuantity!.map((x) => x.toJson())),
        "all_pickedup": allPickedup,
        "_id": id,
        "order_id": orderId,
        "item_type": itemType,
        "item_id": itemId,
        "item_name": itemName,
        "quantity": quantity,
        "discount_percentage": discountPercentage,
        "discount": discount,
        "seller_discount": sellerDiscount,
        "total_discount": totalDiscount,
        "tax": tax,
        "total_net_amount": totalNetAmount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "grossprice": grossprice,
      };
}

class PickedQuantity {
  PickedQuantity({
    this.productId,
    this.quantity,
  });

  String? productId;
  int? quantity;

  factory PickedQuantity.fromJson(Map<String, dynamic> json) => PickedQuantity(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
      };
}

class OrderItemsDetail {
  OrderItemsDetail({
    this.image,
    this.price,
    this.ecosharkSerialNo,
    this.power,
    this.length,
    this.width,
    this.height,
    this.weight,
    this.onlineShopDescription,
    this.color,
    this.undamagedStorage,
    this.damagedStorage,
    this.producttypeInfo,
  });

  String? image;
  String? price;
  String? ecosharkSerialNo;
  String? power;
  String? length;
  String? width;
  String? height;
  String? weight;
  String? onlineShopDescription;
  String? color;
  String? undamagedStorage;
  String? damagedStorage;
  ProducttypeInfo? producttypeInfo;

  factory OrderItemsDetail.fromMap(Map<String, dynamic> json) =>
      OrderItemsDetail(
        image: json["image"],
        price: json["price"],
        ecosharkSerialNo: json["ecoshark_serial_no"],
        power: json["power"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        weight: json["weight"],
        onlineShopDescription: json["online_shop_description"],
        color: json["color"],
        undamagedStorage: json["undamaged_storage"],
        damagedStorage: json["damaged_storage"],
        producttypeInfo: json["producttype_info"] == null
            ? null
            : ProducttypeInfo.fromMap(json["producttype_info"]),
      );

  Map<String, dynamic> toMap() => {
        "image": image,
        "price": price,
        "ecoshark_serial_no": ecosharkSerialNo,
        "power": power,
        "length": length,
        "width": width,
        "height": height,
        "weight": weight,
        "online_shop_description": onlineShopDescription,
        "color": color,
        "undamaged_storage": undamagedStorage,
        "damaged_storage": damagedStorage,
        "producttype_info": producttypeInfo?.toMap(),
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

class OrderTaxDetail {
  OrderTaxDetail({
    this.privateCustomerTax,
    this.companyCustomerTax,
    this.id,
    this.country,
    this.v,
  });

  List<PrivateCustomerTax>? privateCustomerTax;
  List<CompanyCustomerTax>? companyCustomerTax;
  String? id;
  String? country;
  int? v;

  factory OrderTaxDetail.fromMap(Map<String, dynamic> json) => OrderTaxDetail(
        privateCustomerTax: json["private_customer_tax"] == null
            ? []
            : List<PrivateCustomerTax>.from(json["private_customer_tax"]!
                .map((x) => PrivateCustomerTax.fromMap(x))),
        companyCustomerTax: json["company_customer_tax"] == null
            ? []
            : List<CompanyCustomerTax>.from(json["company_customer_tax"]!
                .map((x) => CompanyCustomerTax.fromMap(x))),
        id: json["_id"],
        country: json["country"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "private_customer_tax": privateCustomerTax == null
            ? []
            : List<dynamic>.from(privateCustomerTax!.map((x) => x.toMap())),
        "company_customer_tax": companyCustomerTax == null
            ? []
            : List<dynamic>.from(companyCustomerTax!.map((x) => x.toMap())),
        "_id": id,
        "country": country,
        "__v": v,
      };
}

class CompanyCustomerTax {
  CompanyCustomerTax({
    this.taxRequired,
    this.taxName,
    this.taxPrefix,
    this.taxOnWrongLength,
    this.taxOnCorrectLength,
    this.taxLength,
    this.wrongLengthErrorMessage,
    this.correctLengthMessage,
  });

  bool? taxRequired;
  String? taxName;
  String? taxPrefix;
  String? taxOnWrongLength;
  String? taxOnCorrectLength;
  String? taxLength;
  String? wrongLengthErrorMessage;
  String? correctLengthMessage;

  factory CompanyCustomerTax.fromMap(Map<String, dynamic> json) =>
      CompanyCustomerTax(
        taxRequired: json["tax_required"],
        taxName: json["tax_name"],
        taxPrefix: json["tax_prefix"],
        taxOnWrongLength: json["tax_on_wrong_length"],
        taxOnCorrectLength: json["tax_on_correct_length"],
        taxLength: json["tax_length"],
        wrongLengthErrorMessage: json["wrong_length_error_message"],
        correctLengthMessage: json["correct_length_message"],
      );

  Map<String, dynamic> toMap() => {
        "tax_required": taxRequired,
        "tax_name": taxName,
        "tax_prefix": taxPrefix,
        "tax_on_wrong_length": taxOnWrongLength,
        "tax_on_correct_length": taxOnCorrectLength,
        "tax_length": taxLength,
        "wrong_length_error_message": wrongLengthErrorMessage,
        "correct_length_message": correctLengthMessage,
      };
}

class PrivateCustomerTax {
  PrivateCustomerTax({
    this.taxRequired,
    this.taxName,
    this.tax,
    this.description,
  });

  bool? taxRequired;
  String? taxName;
  String? tax;
  String? description;

  factory PrivateCustomerTax.fromMap(Map<String, dynamic> json) =>
      PrivateCustomerTax(
        taxRequired: json["tax_required"],
        taxName: json["tax_name"],
        tax: json["tax"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "tax_required": taxRequired,
        "tax_name": taxName,
        "tax": tax,
        "description": description,
      };
}
