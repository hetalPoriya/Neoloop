import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../utils/utils.dart';
import '../background_screen.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //home controller
    HomeController homeController = Get.put(HomeController());
    return SafeArea(
        child: Scaffold(
            body: BackgroundScreen(
                backButtonVisibility: true,
                onBackButtonPressed: () {
                  Get.back();
                  homeController.isSettingPage.value = false;
                  homeController.update();
                },
                listViewWidget: Container(
                  child: Padding(
                    padding: paddingSymmetric(horizontal: 6.w, vertical: 2.w),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      // shrinkWrap: true,
                      children: [
                        AppWidget.buttonStyleSmallText(
                            text: 'Open app settings',
                            onTap: () {
                              openAppSettings()
                                  .then((value) => log(value.toString()));
                            })
                      ],
                    ),
                  ),
                ))));
  }
}
