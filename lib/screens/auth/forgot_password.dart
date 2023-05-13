import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoloop/helper/route_helper.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:neoloop/utils/app_strings.dart';
import 'package:neoloop/utils/app_styles.dart';
import 'package:sizer/sizer.dart';

import '../../controller/auth_controller.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());
    return SafeArea(
        child: Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top,
          child: Column(
            children: [
              AppWidget.appBarWidget(onTap: () => Get.back()),
              largeSizedBox,
              Text(
                AppStrings.forgotPass,
                style: AppStyle.largeTextStyle,
              ),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: paddingSymmetric(horizontal: 8.w, vertical: 00),
                child: AppWidget.textFormField(
                  controller: authController.loginEmailController,
                  hintText: AppStrings.neoloopID,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Spacer(flex: 2),
              Padding(
                padding: paddingSymmetric(horizontal: 8.w, vertical: 00),
                child: AppWidget.buttonStyle(
                    text: AppStrings.submit,
                    onTap: () => Get.offNamedUntil(
                        RouteHelper.loginScreen, (route) => false)),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          )),
    ));
  }
}
