import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/screens/home/settings.dart';
import 'package:sizer/sizer.dart';

import '../../utils/utils.dart';
import '../background_screen.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //home controller
    HomeController homeController = Get.put(HomeController());

    return BackgroundScreen(
        onBackButtonPressed: () {
          homeController.isProcessSelected.value = false;
          homeController.bottomIndex.value = 0;
          homeController.update();
        },
        listViewWidget: Container(
          height: 70.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // shrinkWrap: true,
            children: [
              Text('Coming soon..', style: AppStyle.mediumTextStyle),
            ],
          ),
        ));
  }
}
