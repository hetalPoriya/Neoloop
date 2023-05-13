import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoloop/helper/route_helper.dart';
import 'package:neoloop/utils/app_images.dart';
import 'package:neoloop/utils/sharedPref.dart';
import 'package:neoloop/utils/sharedPref_string.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      if (SharedPrefClass.getBool(SharedPrefStrings.isLogin, false) == true) {
        Get.offNamed(RouteHelper.homeScreen);
      } else {
        Get.offNamed(RouteHelper.loginScreen);
      }
    });
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(AppImage.neoLoop, height: 20.h, width: 70.w),
        ]),
      ),
    ));
  }
}
