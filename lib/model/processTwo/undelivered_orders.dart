// To parse this JSON data, do
//
//     final undeliveredOrders = undeliveredOrdersFromMap(jsonString);

import 'dart:convert';

UndeliveredOrders undeliveredOrdersFromMap(String str) =>
    UndeliveredOrders.fromMap(json.decode(str));

String undeliveredOrdersToMap(UndeliveredOrders data) =>
    json.encode(data.toMap());

class UndeliveredOrders {
  UndeliveredOrders({
    this.status,
    this.response,
  });

  String? status;
  List<Response>? response;

  factory UndeliveredOrders.fromMap(Map<String, dynamic> json) =>
      UndeliveredOrders(
        status: json["status"],
        response: json["response"] == null
            ? []
            : List<Response>.from(
                json["response"]!.map((x) => Response.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x.toMap())),
      };
}

class Response {
  Response({
    this.id,
    this.sellerCommissionPaid,
    this.shippingAddress,
    this.orderStatusDates,
    this.returned,
    this.returnRequest,
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
    this.customerInfo,
  });

  String? id;
  String? sellerCommissionPaid;
  List<ShippingAddress>? shippingAddress;
  List<OrderStatusDate>? orderStatusDates;
  String? returned;
  String? returnRequest;
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
  List<CustomerInfo>? customerInfo;

  factory Response.fromMap(Map<String, dynamic> json) => Response(
        id: json["_id"],
        sellerCommissionPaid: json["seller_commission_paid"],
        shippingAddress: json["shipping_address"] == null
            ? []
            : List<ShippingAddress>.from(json["shipping_address"]!
                .map((x) => ShippingAddress.fromMap(x))),
        orderStatusDates: json["order_status_dates"] == null
            ? []
            : List<OrderStatusDate>.from(json["order_status_dates"]!
                .map((x) => OrderStatusDate.fromMap(x))),
        returned: json["returned"],
        returnRequest: json["return_request"],
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
        customerInfo: json["customer_info"] == null
            ? []
            : List<CustomerInfo>.from(
                json["customer_info"]!.map((x) => CustomerInfo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "seller_commission_paid": sellerCommissionPaid,
        "shipping_address": shippingAddress == null
            ? []
            : List<dynamic>.from(shippingAddress!.map((x) => x.toMap())),
        "order_status_dates": orderStatusDates == null
            ? []
            : List<dynamic>.from(orderStatusDates!.map((x) => x.toMap())),
        "returned": returned,
        "return_request": returnRequest,
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
        "customer_info": customerInfo == null
            ? []
            : List<dynamic>.from(customerInfo!.map((x) => x.toMap())),
      };
}

class CustomerInfo {
  CustomerInfo({
    this.id,
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

  String? id;
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
  List<ShippingAddress>? ecosharkCustomerData;
  List<dynamic>? employeeRoleButtons;
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

  factory CustomerInfo.fromMap(Map<String, dynamic> json) => CustomerInfo(
        id: json["_id"],
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
            : List<ShippingAddress>.from(json["ecoshark_customer_data"]!
                .map((x) => ShippingAddress.fromMap(x))),
        employeeRoleButtons: json["employee_role_buttons"] == null
            ? []
            : List<dynamic>.from(json["employee_role_buttons"]!.map((x) => x)),
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
        "_id": id,
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

class ShippingAddress {
  ShippingAddress({
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

  factory ShippingAddress.fromMap(Map<String, dynamic> json) => ShippingAddress(
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

class OrderStatusDate {
  OrderStatusDate({
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

  factory OrderStatusDate.fromMap(Map<String, dynamic> json) => OrderStatusDate(
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
