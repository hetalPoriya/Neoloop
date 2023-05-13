import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoloop/controller/auth_controller.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/helper/route_helper.dart';
import 'package:neoloop/screens/widget.dart';
import 'package:neoloop/utils/network_handler.dart';
import 'package:neoloop/utils/utils.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? deviceId;

  //home controller
  var homeController = Get.put(HomeController());
  var authController = Get.put(AuthController());
  NetworkHandler nr = NetworkHandler();

  @override
  void didChangeDependencies() {
    precacheImage(
        AssetImage(
          AppImage.backgroundImage,
        ),
        context);
    precacheImage(
        AssetImage(
          AppImage.landscapeBackgroundImage,
        ),
        context);
    precacheImage(
        AssetImage(
          AppImage.tabletBackgroundImage,
        ),
        context);
    precacheImage(
        AssetImage(
          AppImage.tabletLandscapeBackgroundImage,
        ),
        context);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //tablet
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var useMobileLayout = shortestSide < 600;

    return SafeArea(
      child: Scaffold(
          body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewPadding.top,
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: 34.h,
                  padding: EdgeInsets.only(top: 3.h),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? AssetImage(AppImage.backgroundImage)
                              : AssetImage(AppImage.landscapeBackgroundImage),
                          fit: BoxFit.fill)),
                ),
                Padding(
                  padding: paddingSymmetric(horizontal: 8.w, vertical: 00),
                  child: Form(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.login,
                            style: AppStyle.extraLargeTextStyle.copyWith(
                                fontFamily: 'Montserrat-Regular',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: AppColor.lightBlack),
                          ),
                          Text(
                            AppStrings.loginDes,
                            style: AppStyle.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          mediumSizedBox,
                          AppWidget.textFormField(
                            controller: authController.loginEmailController,
                            hintText: AppStrings.neoloopID,
                          ),
                          smallSizedBox,
                          Obx(
                            () => AppWidget.textFormField(
                                controller: authController.passwordController,
                                hintText: AppStrings.password,
                                obscureText:
                                    authController.isPasswordVisible.value,
                                textInputAction: TextInputAction.done,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    authController.isPasswordVisible.value =
                                        !authController.isPasswordVisible.value;
                                    authController.update();
                                  },
                                  child: Icon(
                                    authController.isPasswordVisible.value ==
                                            true
                                        ? Icons.remove_red_eye
                                        : Icons.remove_red_eye_outlined,
                                    color: AppColor.extraLightGrey,
                                  ),
                                )),
                          ),
                          smallerSizedBox,
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () =>
                                  Get.toNamed(RouteHelper.forgotPassword),
                              child: Text(
                                AppStrings.forgotPassword,
                                style: AppStyle.extraSmallTextStyle
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp)
                                    .copyWith(color: AppColor.darkPink),
                              ),
                            ),
                          ),
                          largeSizedBox,
                          AppWidget.buttonStyle(
                              text: AppStrings.signIn,
                              onTap: () async {
                                deviceId = await _getId();
                                authController.deviceId = RxString(deviceId!);
                                bool isConnected = await nr.checkConnectivity();
                                if (isConnected) {
                                  await authController.loginUserApiCall();
                                } else {
                                  AppWidget.showShackBar(context);
                                }
                              }),
                          largeSizedBox,
                          Text(
                            AppStrings.serviceAppFor,
                            style: AppStyle.smallTextStyle,
                          ),
                          Image.asset(
                            AppImage.ecoshark,
                            width: 50.w,
                            height: 6.h,
                          )
                        ]),
                  ),
                )
              ],
            ),
            Obx(
              () => authController.isLoading.value == true
                  ? AppWidget.progressIndicator()
                  : Container(),
            ),
          ],
        ),
      )),
    );
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.id}');
      //var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // unique ID on Android
    }
  }
}
