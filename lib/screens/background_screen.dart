import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../utils/utils.dart';
import 'widget.dart';

class BackgroundScreen extends StatelessWidget {
  final Widget listViewWidget;
  final VoidCallback? onBackButtonPressed;
  final bool? backButtonVisibility;

  const BackgroundScreen(
      {Key? key,
      required this.listViewWidget,
      this.onBackButtonPressed,
      this.backButtonVisibility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewPadding.top,
      child: ListView(
        children: [
          Stack(alignment: Alignment.topCenter, children: [
            Container(
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 25.h
                  : 30.h,
              padding: EdgeInsets.only(
                  top:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 8.h
                          : 5.h),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    AppImage.ecosharkLogo,
                    height: 20.h,
                    width: 45.w,
                    fit: BoxFit.fill,
                  )),
            ),
            AppWidget.appBarWidget(
                onTap: onBackButtonPressed ?? () => Get.back(),
                backButtonVisibility: backButtonVisibility ?? true),
            Container(
              padding: EdgeInsets.only(top: 16.h),
              child: listViewWidget,
            ),
          ]),
        ],
      ),
    );
  }
}
