import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/screens/home/home.dart';
import 'package:neoloop/screens/home/product/product_main_page.dart';
import 'package:neoloop/utils/utils.dart';

import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  //home controller
  HomeController homeController = Get.put(HomeController());

  List<Widget> listOfWidget = [
    ProductMainPage(),
    ChatMainPage(),
    NotificationPage(),
    MePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
                elevation: 4.w,
                currentIndex: homeController.bottomIndex.value,
                unselectedLabelStyle: AppStyle.extraSmallTextStyle,
                selectedLabelStyle: AppStyle.extraSmallTextStyle
                    .copyWith(color: AppColor.darkPink),
                selectedItemColor: AppColor.darkPink,
                unselectedItemColor: AppColor.lightGrey,
                selectedIconTheme: IconThemeData(color: AppColor.darkPink),
                unselectedIconTheme: IconThemeData(color: AppColor.lightGrey),
                onTap: ((value) {
                  homeController.isProcessSelected.value = false;
                  homeController.processOneIndex.value = 0;
                  homeController.processTwoIndex.value = 0;
                  homeController.processThreeIndex.value = 0;
                  homeController.bottomIndex.value = value;

                  homeController.update();
                  print(homeController.bottomIndex.value);
                }),
                items: [
                  _bottomItem(icon: Icons.home_outlined, label: 'Home'),
                  _bottomItem(icon: Icons.people_outline, label: 'Chat'),
                  _bottomItem(
                      icon: Icons.notification_important,
                      label: 'Notification'),
                  _bottomItem(icon: Icons.people_outline, label: 'Me'),
                ]),
          ),
          body: Obx(
            () => listOfWidget.elementAt(homeController.bottomIndex.value),
          )),
    );
  }

  _bottomItem({required IconData icon, required String label}) =>
      BottomNavigationBarItem(
        icon: Icon(icon, size: 7.w),
        label: label,
      );
}
