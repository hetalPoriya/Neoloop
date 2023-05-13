import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoloop/controller/auth_controller.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/controller/processOne_controller.dart';
import 'package:neoloop/model/auth/login_model.dart';
import 'package:neoloop/screens/background_screen.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:neoloop/utils/app_strings.dart';
import 'package:neoloop/utils/app_styles.dart';
import 'package:neoloop/utils/sharedPref.dart';
import 'package:sizer/sizer.dart';

import '../../utils/utils.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  User userData = User();
  LoginModel? loginModel;
  //controller
  HomeController homeController = Get.put(HomeController());
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    String user =
        json.decode(SharedPrefClass.getString(SharedPrefStrings.userModel));

    loginModel = loginModelFromJson(user);
    userData = loginModel!.user;
    log('${userData.customerno}');
    authController.titleController.value.text = userData.title.toString();
    authController.firstnameController.value.text =
        userData.firstname.toString();
    authController.lastnameController.value.text = userData.lastname.toString();
    authController.eMailController.value.text = userData.email.toString();
    authController.strassaController.value.text = userData.strassa.toString();
    authController.strnoController.value.text = userData.strno.toString();
    authController.plzController.value.text = userData.plz.toString();
    authController.cityController.value.text = userData.city.toString();
    authController.currentCountryController.value.text =
        userData.currentCountry.toString();
    authController.contactNoController.value.text =
        userData.contactno.toString();
    authController.customerNoontroller.value.text =
        userData.customerno.toString();
    authController.update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
        backButtonVisibility: true,
        onBackButtonPressed: () {
          homeController.isProcessSelected.value == true;
          homeController.bottomIndex.value = 0;
          homeController.update();
        },
        listViewWidget: Padding(
          padding: paddingSymmetric(horizontal: 6.w, vertical: 0.h),
          child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                      unselectedLabelColor: Colors.black54,
                      labelColor: AppColor.darkPink,
                      indicatorColor: AppColor.darkPink,
                      tabs: [
                        Tab(
                          text: AppStrings.personlicheDaten,
                        ),
                        Tab(
                          text: AppStrings.offiziellerWohnsitz,
                        ),
                        Tab(
                          text: AppStrings.mehrInfo,
                        ),
                      ]),
                  Container(
                    height: 67.h,
                    child: TabBarView(children: [
                      _firstTabView(),
                      _secondTabView(),
                      _thirdTabView(),
                    ]),
                  )
                ],
              )),
          // child: Obx(
          //   () => ListView(
          //     shrinkWrap: true,
          //     physics: ClampingScrollPhysics(),
          //     children: [
          //       Text(
          //         AppStrings.personlicheDaten,
          //         style: AppStyle.mediumTextStyle
          //             .copyWith(fontWeight: FontWeight.w700),
          //       ),
          //       Divider(color: Colors.grey.shade400, thickness: 2),
          //       mediumSizedBox,
          //       AppWidget.outlineTextFormField(
          //           hintText: AppStrings.anrede,
          //           controller: authController.titleController.value),
          //       smallSizedBox,
          //       AppWidget.outlineTextFormField(
          //           hintText: AppStrings.vorname,
          //           controller: authController.firstnameController.value),
          //       smallSizedBox,
          //       AppWidget.outlineTextFormField(
          //           hintText: AppStrings.nachname,
          //           controller: authController.lastnameController.value),
          //       smallSizedBox,
          //       AppWidget.outlineTextFormField(
          //           hintText: AppStrings.eMail,
          //           controller: authController.eMailController.value),
          //       mediumSizedBox,
          //       Text(
          //         AppStrings.offiziellerWohnsitz,
          //         style: AppStyle.mediumTextStyle
          //             .copyWith(fontWeight: FontWeight.w700),
          //       ),
          //       Divider(color: Colors.grey.shade400, thickness: 2),
          //       mediumSizedBox,
          //       AppWidget.outlineTextFormField(
          //           hintText: AppStrings.strabe,
          //           controller: authController.strassaController.value),
          //       smallSizedBox,
          //       AppWidget.outlineTextFormField(
          //           hintText: AppStrings.nr,
          //           controller: authController.strnoController.value),
          //       smallSizedBox,
          //       AppWidget.outlineTextFormField(
          //           hintText: AppStrings.plz,
          //           controller: authController.plzController.value),
          //       smallSizedBox,
          //       AppWidget.outlineTextFormField(
          //           hintText: AppStrings.stadt,
          //           controller: authController.cityController.value),
          //       smallSizedBox,
          //       AppWidget.outlineTextFormField(
          //           hintText: AppStrings.landDesWohnsitzes,
          //           controller:
          //               authController.currentCountryController.value),
          //       smallSizedBox,
          //       AppWidget.outlineTextFormField(
          //           hintText: AppStrings.telefonnummer,
          //           controller: authController.contactNoController.value),
          //       smallSizedBox,
          //       Text(
          //         AppStrings.mehrInfo,
          //         style: AppStyle.mediumTextStyle
          //             .copyWith(fontWeight: FontWeight.w700),
          //       ),
          //       smallSizedBox,
          //       AppWidget.outlineTextFormField(
          //           hintText: AppStrings.benutzerNr,
          //           controller: authController.customerNoontroller.value),
          //     ],
          //   ),
          // )
        ));
  }

  _firstTabView() {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: paddingSymmetric(horizontal: 0.0, vertical: 4.h),
      children: [
        AppWidget.outlineTextFormField(
            hintText: AppStrings.anrede,
            controller: authController.titleController.value),
        smallSizedBox,
        AppWidget.outlineTextFormField(
            hintText: AppStrings.vorname,
            controller: authController.firstnameController.value),
        smallSizedBox,
        AppWidget.outlineTextFormField(
            hintText: AppStrings.nachname,
            controller: authController.lastnameController.value),
        smallSizedBox,
        AppWidget.outlineTextFormField(
            hintText: AppStrings.eMail,
            controller: authController.eMailController.value),
      ],
    );
  }

  _secondTabView() {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: paddingSymmetric(horizontal: 0.0, vertical: 4.h),
      children: [
        AppWidget.outlineTextFormField(
            hintText: AppStrings.strabe,
            controller: authController.strassaController.value),
        smallSizedBox,
        AppWidget.outlineTextFormField(
            hintText: AppStrings.nr,
            controller: authController.strnoController.value),
        smallSizedBox,
        AppWidget.outlineTextFormField(
            hintText: AppStrings.plz,
            controller: authController.plzController.value),
        smallSizedBox,
        AppWidget.outlineTextFormField(
            hintText: AppStrings.stadt,
            controller: authController.cityController.value),
        smallSizedBox,
        AppWidget.outlineTextFormField(
            hintText: AppStrings.landDesWohnsitzes,
            controller: authController.currentCountryController.value),
        smallSizedBox,
        AppWidget.outlineTextFormField(
            hintText: AppStrings.telefonnummer,
            controller: authController.contactNoController.value),
      ],
    );
  }

  _thirdTabView() {
    return Padding(
      padding: paddingSymmetric(horizontal: 0.0, vertical: 4.h),
      child: AppWidget.outlineTextFormField(
          hintText: AppStrings.benutzerNr,
          controller: authController.customerNoontroller.value),
    );
  }
}
