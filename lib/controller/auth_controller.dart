import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:neoloop/helper/route_helper.dart';
import 'package:neoloop/model/auth/login_model.dart';
import 'package:neoloop/utils/app_strings.dart';
import 'package:neoloop/utils/network_handler.dart';
import 'package:neoloop/utils/sharedPref.dart';
import 'package:neoloop/utils/sharedPref_string.dart';

class AuthController extends GetxController {
  //for login
  RxBool isPasswordVisible = true.obs;

  var token = ''.obs;
  var isLoading = false.obs;
  var deviceId = ''.obs;
  Rx<User> userData = User().obs;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> firstnameController = TextEditingController().obs;
  Rx<TextEditingController> lastnameController = TextEditingController().obs;
  Rx<TextEditingController> eMailController = TextEditingController().obs;
  Rx<TextEditingController> strassaController = TextEditingController().obs;
  Rx<TextEditingController> strnoController = TextEditingController().obs;
  Rx<TextEditingController> plzController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> currentCountryController =
      TextEditingController().obs;
  Rx<TextEditingController> contactNoController = TextEditingController().obs;
  Rx<TextEditingController> customerNoontroller = TextEditingController().obs;

  Future loginUserApiCall() async {
    try {
      isLoading(true);
      print("Inside Login Controller");
      ToLoginModel toLoginModel = ToLoginModel(
          email: loginEmailController.text,
          password: passwordController.text,
          neoloop: '1');
      var response = await NetworkHandler.post(
          loginModelToJson(toLoginModel), AppStrings.loginApi);
      var data = json.decode(response);
      //
      // log('data ${data}');
      // log('data ${data['message']}');
      // log('data ${data['msg']}');

      if (data['msg'] == 'User successfully Logged In') {
        var user = loginModelFromJson(response);
        userData(user.user);
        // titleController.value.text = user.user.title.toString();
        // firstnameController.value.text = user.user.firstname.toString();
        // lastnameController.value.text = user.user.lastname.toString();
        // eMailController.value.text = user.user.email.toString();
        // strassaController.value.text = user.user.strassa.toString();
        // strnoController.value.text = user.user.strno.toString();
        // plzController.value.text = user.user.plz.toString();
        // cityController.value.text = user.user.city.toString();
        // currentCountryController.value.text =
        //     user.user.currentCountry.toString();
        // contactNoController.value.text = user.user.contactno.toString();
        // customerNoontroller.value.text = user.user.customerno.toString();

        SharedPrefClass.setBool(SharedPrefStrings.isLogin, true);
        SharedPrefClass.setString(
            SharedPrefStrings.userEmail, loginEmailController.text);
        SharedPrefClass.setString(
            SharedPrefStrings.customerNo, user.user.customerno.toString());

        SharedPrefClass.setString(
            SharedPrefStrings.userNeoloopPass, passwordController.text);
        SharedPrefClass.setString(SharedPrefStrings.userToken, user.token);
        log('ID ${user.user.id.toString()}');
        SharedPrefClass.setString(
            SharedPrefStrings.loginId, user.user.id.toString());
        SharedPrefClass.setString(
            SharedPrefStrings.userNeoloopId, user.user.id.toString());
        SharedPrefClass.setString(
            SharedPrefStrings.userModel, json.encode(response));

        token = RxString(user.token);
        Fluttertoast.showToast(msg: user.msg);
        Get.offNamedUntil(RouteHelper.homeScreen, (route) => false);
      } else {
        Fluttertoast.showToast(msg: data['message']);
      }

      print('Login Response $data');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    print('ONINIT');
    loginEmailController.text =
        SharedPrefClass.getString(SharedPrefStrings.userEmail);
    passwordController.text =
        SharedPrefClass.getString(SharedPrefStrings.userNeoloopPass);
    super.onInit();
  }
}
