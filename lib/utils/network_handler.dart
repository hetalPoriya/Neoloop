import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';

import 'package:http/http.dart' as http;
import 'package:neoloop/helper/route_helper.dart';
import 'package:neoloop/model/processOne/upload_document.dart';
import 'package:neoloop/model/processOne/upload_document_info.dart';
import 'package:neoloop/utils/sharedPref.dart';
import 'package:neoloop/utils/sharedPref_string.dart';

class NetworkHandler {
  static final client = http.Client();

  static Future<String> getApi(String endpoint) async {
    var token = SharedPrefClass.getString(SharedPrefStrings.userToken);
    print(endpoint);
    print("Bearer ${token}");
    try {
      var response = await client.get(buildUrl(endpoint), headers: {
        "content-Type": "application/json",
        "Authorization": token
      });
      print(response.statusCode);
      print('Body ${response.body}');
      return response.body;
    } catch (e) {
      var response = await client.get(buildUrl(endpoint), headers: {
        "content-Type": "application/json",
        "Authorization": token
      });
      print(response.statusCode);
      print(response.body);
      return response.body;
    }
  }

  static Future<String> post(var body, String endpoint) async {
    var token = SharedPrefClass.getString(SharedPrefStrings.userToken);
    print(endpoint);
    print(body);
    print(buildUrl(endpoint));
    print("Token ${token}");
    try {
      var response = await client.post(buildUrl(endpoint),
          body: body,
          headers: {
            "content-Type": "application/json",
            "Authorization": token
          });
      print(response.statusCode);
      print('Body ${response.body}');
      print('Body ${response.body.contains('msg')}');

      var data = json.decode(response.body);

      if (response.body.contains('msg') == true &&
          data['msg'] == 'Not Authorized') {
        Fluttertoast.showToast(msg: data['msg']);
        Get.offNamedUntil(RouteHelper.loginScreen, (route) => false);
      }
      // if (response.body.contains('msg') == true &&
      //     data['msg'].toString() == 'Device found') {
      //   //for get device if fro process two after scanned
      //   Fluttertoast.showToast(msg: data['msg']);
      // } else if (response.body.contains('msg') == true) {
      //   //this "msg" display when unauthorized otherwise display "message" that's why set this condition
      //   Fluttertoast.showToast(msg: data['msg']);
      //   Get.offNamedUntil(RouteHelper.loginScreen, (route) => false);
      // }
      print('DATA $data');
      return response.body;
    } catch (e) {
      var response = await client.post(buildUrl(endpoint),
          body: body, headers: {"Authorization": token});
      print(response.statusCode);
      print(response.body);
      return response.body;
    }
  }

  static Uri buildUrl(String endpoint) {
    String host = "https://fiorettosystems.com/api/";
    final apiPath = host + endpoint;
    return Uri.parse(apiPath);
  }

  static String buildImageUrl(String endpoint) {
    String host = "https://fiorettosystems.com/api/";
    final apiPath = host + endpoint;
    return apiPath;
  }

  Future<bool> checkConnectivity() async {
    try {
      bool isConnected;
      var _connectivity = await (Connectivity().checkConnectivity());
      if (_connectivity == ConnectivityResult.mobile) {
        isConnected = true;
      } else if (_connectivity == ConnectivityResult.wifi) {
        isConnected = true;
      } else {
        isConnected = false;
      }

      if (isConnected) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            isConnected = true;
          }
        } on SocketException catch (_) {
          isConnected = false;
        }
      }

      return isConnected;
    } catch (e) {
      print('Exception - NetworkHandler.dart - checkConnectivity(): ' +
          e.toString());
    }
    return false;
  }
}
