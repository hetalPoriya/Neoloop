// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(ToLoginModel data) => json.encode(data.toJson());

class ToLoginModel {
  ToLoginModel(
      {required this.email, required this.password, required this.neoloop});
  String email;
  String password;
  String neoloop;

  Map<String, dynamic> toJson() =>
      {"email": email, "password": password, "neoloop": neoloop};
}

class LoginModel {
  LoginModel({
    required this.msg,
    required this.user,
    required this.token,
    required this.success,
  });

  String msg;
  User user;
  String token;
  int success;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        msg: json["msg"] == null ? null : json["msg"],
        user: User.fromJson(json["user"]),
        token: json["token"] == null ? null : json["token"],
        success: json["success"] == null ? null : json["success"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "user": user == null ? null : user.toJson(),
        "token": token == null ? null : token,
        "success": success == null ? null : success,
      };
}

class User {
  User({
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
    this.employeeRoleButtons,
    this.id,
    this.title,
    this.companyname,
    this.firstname,
    this.lastname,
    this.email,
    this.dateofbirth,
    this.birthPlace,
    this.nationality,
    this.strassa,
    this.strno,
    this.additionalReference,
    this.plz,
    this.city,
    this.currentCountry,
    this.password,
    this.contactno,
    this.customerno,
    this.status,
    this.registeredTime,
    this.customerStatus,
    this.employeetype,
    this.companycodes,
    this.attempts,
    this.blockedAt,
    this.emailSent,
    this.emailVerify,
    this.mobileVerify,
    this.lastOnline,
    this.deviceModel,
    this.osVersion,
    this.appVersion,
    this.v,
  });

  List<String>? roles;
  List<String>? companies;
  List<dynamic>? oldTicketNum;
  int? deviceType;
  int? onlineStatus;
  List<String>? companiesWithRoles;
  List<String>? brokerbrandarray;
  List<String>? brokerarray;
  List<String>? statusbrandarray;
  List<String>? statusarray;
  List<String>? employeebrandarray;
  List<String>? employeearray;
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
  List<dynamic>? employeeRoleButtons;
  String? id;
  String? title;
  String? companyname;
  String? firstname;
  String? lastname;
  String? email;
  DateTime? dateofbirth;
  String? birthPlace;
  String? nationality;
  String? strassa;
  String? strno;
  String? additionalReference;
  String? plz;
  String? city;
  String? currentCountry;
  String? password;
  String? contactno;
  String? customerno;
  String? status;
  String? registeredTime;
  String? customerStatus;
  String? employeetype;
  String? companycodes;
  String? attempts;
  String? blockedAt;
  String? emailSent;
  String? emailVerify;
  String? mobileVerify;
  String? lastOnline;
  String? deviceModel;
  String? osVersion;
  String? appVersion;
  int? v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        roles: json["roles"] == null
            ? null
            : List<String>.from(json["roles"].map((x) => x)),
        companies: json["companies"] == null
            ? null
            : List<String>.from(json["companies"].map((x) => x)),
        oldTicketNum: json["oldTicketNum"] == null
            ? null
            : List<dynamic>.from(json["oldTicketNum"].map((x) => x)),
        deviceType: json["device_type"] == null ? null : json["device_type"],
        onlineStatus:
            json["online_status"] == null ? null : json["online_status"],
        companiesWithRoles: json["companies_with_roles"] == null
            ? null
            : List<String>.from(json["companies_with_roles"].map((x) => x)),
        brokerbrandarray: json["brokerbrandarray"] == null
            ? null
            : List<String>.from(json["brokerbrandarray"].map((x) => x)),
        brokerarray: json["brokerarray"] == null
            ? null
            : List<String>.from(json["brokerarray"].map((x) => x)),
        statusbrandarray: json["statusbrandarray"] == null
            ? null
            : List<String>.from(json["statusbrandarray"].map((x) => x)),
        statusarray: json["statusarray"] == null
            ? null
            : List<String>.from(json["statusarray"].map((x) => x)),
        employeebrandarray: json["employeebrandarray"] == null
            ? null
            : List<String>.from(json["employeebrandarray"].map((x) => x)),
        employeearray: json["employeearray"] == null
            ? null
            : List<String>.from(json["employeearray"].map((x) => x)),
        companycode: json["companycode"] == null
            ? null
            : List<String>.from(json["companycode"].map((x) => x)),
        companydata: json["companydata"] == null
            ? null
            : List<dynamic>.from(json["companydata"].map((x) => x)),
        contractdata: json["contractdata"] == null
            ? null
            : List<dynamic>.from(json["contractdata"].map((x) => x)),
        companydatacheckup: json["companydatacheckup"] == null
            ? null
            : List<dynamic>.from(json["companydatacheckup"].map((x) => x)),
        vermittlerstatusforbrokermanager:
            json["vermittlerstatusforbrokermanager"] == null
                ? null
                : List<dynamic>.from(
                    json["vermittlerstatusforbrokermanager"].map((x) => x)),
        ceodata: json["ceodata"] == null
            ? null
            : List<dynamic>.from(json["ceodata"].map((x) => x)),
        shareholderdata: json["shareholderdata"] == null
            ? null
            : List<dynamic>.from(json["shareholderdata"].map((x) => x)),
        ceodatacheckup: json["ceodatacheckup"] == null
            ? null
            : List<dynamic>.from(json["ceodatacheckup"].map((x) => x)),
        shareholderdatacheckup: json["shareholderdatacheckup"] == null
            ? null
            : List<dynamic>.from(json["shareholderdatacheckup"].map((x) => x)),
        middledatacheckup: json["middledatacheckup"] == null
            ? null
            : List<dynamic>.from(json["middledatacheckup"].map((x) => x)),
        welcomevideoscreenshotnum: json["welcomevideoscreenshotnum"] == null
            ? null
            : json["welcomevideoscreenshotnum"],
        logincount: json["logincount"] == null ? null : json["logincount"],
        registerationEditable: json["registeration_editable"] == null
            ? null
            : json["registeration_editable"],
        ecosharkSellerData: json["ecoshark_seller_data"] == null
            ? null
            : List<dynamic>.from(json["ecoshark_seller_data"].map((x) => x)),
        employeeRoleButtons: json["employee_role_buttons"] == null
            ? null
            : List<dynamic>.from(json["employee_role_buttons"].map((x) => x)),
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        companyname: json["companyname"] == null ? null : json["companyname"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"] == null ? null : json["email"],
        dateofbirth: json["dateofbirth"] == null
            ? null
            : DateTime.parse(json["dateofbirth"]),
        birthPlace: json["birth_place"] == null ? null : json["birth_place"],
        nationality: json["nationality"] == null ? null : json["nationality"],
        strassa: json["strassa"] == null ? null : json["strassa"],
        strno: json["strno"] == null ? null : json["strno"],
        additionalReference: json["additionalReference"] == null
            ? null
            : json["additionalReference"],
        plz: json["plz"] == null ? null : json["plz"],
        city: json["city"] == null ? null : json["city"],
        currentCountry:
            json["current_country"] == null ? null : json["current_country"],
        password: json["password"] == null ? null : json["password"],
        contactno: json["contactno"] == null ? null : json["contactno"],
        customerno: json["customerno"] == null ? null : json["customerno"],
        status: json["status"] == null ? null : json["status"],
        registeredTime:
            json["registered_time"] == null ? null : json["registered_time"],
        customerStatus:
            json["customer_status"] == null ? null : json["customer_status"],
        employeetype:
            json["employeetype"] == null ? null : json["employeetype"],
        companycodes:
            json["companycodes"] == null ? null : json["companycodes"],
        attempts: json["attempts"] == null ? null : json["attempts"],
        blockedAt: json["blocked_at"] == null ? null : json["blocked_at"],
        emailSent: json["email_sent"] == null ? null : json["email_sent"],
        emailVerify: json["email_verify"] == null ? null : json["email_verify"],
        mobileVerify:
            json["mobile_verify"] == null ? null : json["mobile_verify"],
        lastOnline: json["last_online"] == null ? null : json["last_online"],
        deviceModel: json["deviceModel"] == null ? null : json["deviceModel"],
        osVersion: json["OSVersion"] == null ? null : json["OSVersion"],
        appVersion: json["appVersion"] == null ? null : json["appVersion"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "roles":
            roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
        "companies": companies == null
            ? null
            : List<dynamic>.from(companies!.map((x) => x)),
        "oldTicketNum": oldTicketNum == null
            ? null
            : List<dynamic>.from(oldTicketNum!.map((x) => x)),
        "device_type": deviceType == null ? null : deviceType,
        "online_status": onlineStatus == null ? null : onlineStatus,
        "companies_with_roles": companiesWithRoles == null
            ? null
            : List<dynamic>.from(companiesWithRoles!.map((x) => x)),
        "brokerbrandarray": brokerbrandarray == null
            ? null
            : List<dynamic>.from(brokerbrandarray!.map((x) => x)),
        "brokerarray": brokerarray == null
            ? null
            : List<dynamic>.from(brokerarray!.map((x) => x)),
        "statusbrandarray": statusbrandarray == null
            ? null
            : List<dynamic>.from(statusbrandarray!.map((x) => x)),
        "statusarray": statusarray == null
            ? null
            : List<dynamic>.from(statusarray!.map((x) => x)),
        "employeebrandarray": employeebrandarray == null
            ? null
            : List<dynamic>.from(employeebrandarray!.map((x) => x)),
        "employeearray": employeearray == null
            ? null
            : List<dynamic>.from(employeearray!.map((x) => x)),
        "companycode": companycode == null
            ? null
            : List<dynamic>.from(companycode!.map((x) => x)),
        "companydata": companydata == null
            ? null
            : List<dynamic>.from(companydata!.map((x) => x)),
        "contractdata": contractdata == null
            ? null
            : List<dynamic>.from(contractdata!.map((x) => x)),
        "companydatacheckup": companydatacheckup == null
            ? null
            : List<dynamic>.from(companydatacheckup!.map((x) => x)),
        "vermittlerstatusforbrokermanager":
            vermittlerstatusforbrokermanager == null
                ? null
                : List<dynamic>.from(
                    vermittlerstatusforbrokermanager!.map((x) => x)),
        "ceodata":
            ceodata == null ? null : List<dynamic>.from(ceodata!.map((x) => x)),
        "shareholderdata": shareholderdata == null
            ? null
            : List<dynamic>.from(shareholderdata!.map((x) => x)),
        "ceodatacheckup": ceodatacheckup == null
            ? null
            : List<dynamic>.from(ceodatacheckup!.map((x) => x)),
        "shareholderdatacheckup": shareholderdatacheckup == null
            ? null
            : List<dynamic>.from(shareholderdatacheckup!.map((x) => x)),
        "middledatacheckup": middledatacheckup == null
            ? null
            : List<dynamic>.from(middledatacheckup!.map((x) => x)),
        "welcomevideoscreenshotnum": welcomevideoscreenshotnum == null
            ? null
            : welcomevideoscreenshotnum,
        "logincount": logincount == null ? null : logincount,
        "registeration_editable":
            registerationEditable == null ? null : registerationEditable,
        "ecoshark_seller_data": ecosharkSellerData == null
            ? null
            : List<dynamic>.from(ecosharkSellerData!.map((x) => x)),
        "employee_role_buttons": employeeRoleButtons == null
            ? null
            : List<dynamic>.from(employeeRoleButtons!.map((x) => x)),
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "companyname": companyname == null ? null : companyname,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "email": email == null ? null : email,
        "dateofbirth":
            dateofbirth == null ? null : dateofbirth?.toIso8601String(),
        "birth_place": birthPlace == null ? null : birthPlace,
        "nationality": nationality == null ? null : nationality,
        "strassa": strassa == null ? null : strassa,
        "strno": strno == null ? null : strno,
        "additionalReference":
            additionalReference == null ? null : additionalReference,
        "plz": plz == null ? null : plz,
        "city": city == null ? null : city,
        "current_country": currentCountry == null ? null : currentCountry,
        "password": password == null ? null : password,
        "contactno": contactno == null ? null : contactno,
        "customerno": customerno == null ? null : customerno,
        "status": status == null ? null : status,
        "registered_time": registeredTime == null ? null : registeredTime,
        "customer_status": customerStatus == null ? null : customerStatus,
        "employeetype": employeetype == null ? null : employeetype,
        "companycodes": companycodes == null ? null : companycodes,
        "attempts": attempts == null ? null : attempts,
        "blocked_at": blockedAt == null ? null : blockedAt,
        "email_sent": emailSent == null ? null : emailSent,
        "email_verify": emailVerify == null ? null : emailVerify,
        "mobile_verify": mobileVerify == null ? null : mobileVerify,
        "last_online": lastOnline == null ? null : lastOnline,
        "deviceModel": deviceModel == null ? null : deviceModel,
        "OSVersion": osVersion == null ? null : osVersion,
        "appVersion": appVersion == null ? null : appVersion,
        "__v": v == null ? null : v,
      };
}
