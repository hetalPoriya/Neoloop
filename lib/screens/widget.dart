import 'dart:developer';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/controller/processOne_controller.dart';
import 'package:neoloop/controller/processTwo_controller.dart';
import 'package:neoloop/screens/home/home.dart';
import 'package:neoloop/utils/utils.dart';
import 'package:sizer/sizer.dart';

class AppWidget {
  //Controller
  static HomeController homeController = Get.put(HomeController());
  static ProcessOneController processOneController =
      Get.put(ProcessOneController());
  static ProcessTwoController processTwoController =
      Get.put(ProcessTwoController());

  static Widget textFormField(
          {required String hintText,
          bool? obscureText,
          TextInputType? textInputType,
          TextInputAction? textInputAction,
          Widget? suffixIcon,
          required TextEditingController controller}) =>
      TextFormField(
        cursorColor: AppColor.darkPink,
        controller: controller,
        textInputAction: textInputAction ?? TextInputAction.next,
        obscureText: obscureText ?? false,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
            disabledBorder: UnderlineInputBorder(),
            hintText: hintText,
            hintStyle:
                AppStyle.smallTextStyle.copyWith(fontWeight: FontWeight.w300),
            suffixIcon: suffixIcon,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.darkPink))),
      );

  static Widget outlineTextFormField(
          {required String hintText,
          bool? obscureText,
          TextInputType? textInputType,
          TextInputAction? textInputAction,
          Widget? suffixIcon,
          required TextEditingController controller}) =>
      TextFormField(
        cursorColor: AppColor.darkPink,
        controller: controller,
        textInputAction: textInputAction ?? TextInputAction.next,
        obscureText: obscureText ?? false,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
            labelText: hintText,
            labelStyle:
                AppStyle.smallTextStyle.copyWith(fontWeight: FontWeight.w300),
            contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
            enabledBorder: OutlineInputBorder(),
            hintText: hintText,
            hintStyle:
                AppStyle.smallTextStyle.copyWith(fontWeight: FontWeight.w300),
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.darkPink))),
      );

  static Widget appBarWidget(
          {required VoidCallback onTap, bool backButtonVisibility = true}) =>
      Container(
        height: 20.h,
        decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage(AppImage.appbarImage), fit: BoxFit.fill)),
        child: Padding(
          padding: paddingSymmetric(horizontal: 2.w, vertical: 00),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Obx(() => Container(
                          height: 6.h,
                          color: Colors.transparent,
                          alignment: Alignment.bottomCenter,
                          margin: homeController.isSettingPage.value == true
                              ? EdgeInsets.zero
                              : homeController.bottomIndex.value == 0
                                  ? (homeController.isProcessSelected.value ==
                                          false)
                                      ? paddingSymmetric(
                                          horizontal: 4.w, vertical: 00)
                                      : EdgeInsets.zero
                                  : EdgeInsets.zero,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // IconButton(
                              //     onPressed: onTap,
                              //     highlightColor: Colors.amberAccent,
                              //     //<-- SEE HERE
                              //     iconSize: 4.h,
                              //     icon: Icon(
                              //       Icons.arrow_back_ios,
                              //       size: 4.h,
                              //     ),
                              //     color: AppColor.lightGrey),
                              Obx(
                                () => Visibility(
                                  visible: homeController.isSettingPage.value ==
                                          true
                                      ? true
                                      : homeController.bottomIndex.value == 0
                                          ? (homeController.isProcessSelected
                                                      .value ==
                                                  false)
                                              ? false
                                              : true
                                          : true,
                                  child: FloatingActionButton(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    onPressed: () => Future.delayed(
                                        Duration(milliseconds: 200), onTap),
                                    splashColor: AppColor.darkPink,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 2.w),
                                      child: Icon(Icons.arrow_back_ios,
                                          size: 4.h, color: AppColor.lightGrey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                height: 6.h,
                                child: Image.asset(
                                  AppImage.neoLoop,
                                  width: 50.w,
                                  height: 5.h,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: FloatingActionButton.small(
                                  heroTag: 'Setting',
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  onPressed: () => Future.delayed(
                                      Duration(milliseconds: 200), () {
                                    homeController.isSettingPage.value = true;
                                    homeController.update();
                                    Get.to(() => SettingsPage());
                                    log('setting page ${homeController.isSettingPage.value}');
                                  }),
                                  splashColor: AppColor.darkPink,
                                  child: Icon(Icons.settings,
                                      size: 4.h, color: AppColor.lightGrey),
                                ),
                              ),
                            ],
                          ),
                        ))),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: paddingSymmetric(horizontal: 4.w, vertical: 00),
                    child: Row(
                      children: [
                        Text(
                          AppStrings.serviceAppFor,
                          style: AppStyle.extraSmallTextStyle
                              .copyWith(fontSize: 10.sp),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Image.asset(
                          AppImage.ecoshark,
                          width: 20.w,
                          fit: BoxFit.fill,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ]),
        ),
      );

  static Widget buttonStyle({
    required String text,
    required VoidCallback onTap,
    TextStyle? textStyle,
    double? height,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: height ?? 6.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.w),
              gradient: LinearGradient(
                  colors: [AppColor.lightBlue, AppColor.darkPink])),
          child: Text(text,
              style: textStyle ??
                  AppStyle.largeTextStyle.copyWith(
                      fontSize: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1),
              overflow: TextOverflow.ellipsis),
        ),
      );

  static Widget buttonStyleSmallText(
          {required String text,
          required VoidCallback onTap,
          double? fontSize,
          Color? fontColor}) =>
      GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 2.w,
          shadowColor: AppColor.black,
          borderRadius: BorderRadius.circular(2.w),
          child: Container(
            height: 5.h,
            alignment: Alignment.center,
            padding: paddingSymmetric(horizontal: 1, vertical: 00),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
                gradient: LinearGradient(
                    colors: [AppColor.lightBlue, AppColor.darkPink])),
            child: Text(text,
                //maxLines: 2,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: AppStyle.smallTextStyle.copyWith(
                  fontSize: fontSize ?? 12.sp,
                  color: fontColor ?? Colors.white,
                ),
                overflow: TextOverflow.ellipsis),
          ),
        ),
      );

  static Widget productContainer(
          {required String imageString, required String name}) =>
      Container(
        height: 19.h,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imageString), fit: BoxFit.fill),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200, spreadRadius: 4, blurRadius: 7)
            ]),
        child: Container(
          padding: EdgeInsets.only(top: 9.h, bottom: 2.w),
          width: 50.w,
          alignment: Alignment.bottomCenter,
          child: Text(name,
              textAlign: TextAlign.left,
              style: AppStyle.mediumTextStyle.copyWith(color: Colors.white)),
        ),
      );

  static Widget searchField(
          {required TextEditingController searchController,
          Function(String)? onChanged,
          String? text}) =>
      Material(
        elevation: 2,
        type: MaterialType.card,
        borderRadius: BorderRadius.circular(2.w),
        //shadowColor: Colors.black,
        child: TextField(
            onChanged: onChanged,
            onSubmitted: onChanged,
            cursorColor: AppColor.darkPink,
            controller: searchController,
            decoration: InputDecoration(
                contentPadding: paddingSymmetric(horizontal: 2.w, vertical: 00),
                hintText: text ?? AppStrings.searchText,
                hintStyle: AppStyle.extraSmallTextStyle
                    .copyWith(fontSize: 10.sp, color: AppColor.grey),
                prefixIcon: Container(
                  margin: EdgeInsets.only(right: 2.w),
                  decoration: BoxDecoration(
                      color: AppColor.extraDarkPink,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.w),
                          bottomLeft: Radius.circular(2.w))),
                  child: Icon(Icons.search, color: Colors.white),
                ),
                // suffixIcon: Icon(Icons.arrow_drop_down_outlined,
                //     color: AppColor.lightGrey, size: 4.h),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.w),
                  borderSide: BorderSide(color: AppColor.darkPink),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.w),
                  borderSide: BorderSide(color: Colors.white),
                ))),
      );

  static Widget productOneDetailContainer(
      {required BuildContext context,
      String? productName,
      String? imageWidget}) {
    ProcessOneController processOneController = Get.put(ProcessOneController());
    log(processOneController.selectedProductItem.value.productImageUrl
        .toString());
    return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? 20.h
          : 25.h,
      child: Row(children: [
        Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product:',
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.smallTextStyle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  processOneController.selectedProductItem.value.productName
                          .toString() ??
                      ' ',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.smallTextStyle.copyWith(
                      color: AppColor.extraDarkPink,
                      fontWeight: FontWeight.w700),
                )
              ],
            )),
        Expanded(
            flex: 2,
            child: Container(
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 15.h
                  : 20.h,
              width: MediaQuery.of(context).size.width * .90,
              child: FadeInImage(
                  image: NetworkImage(
                    processOneController
                        .selectedProductItem.value.productImageUrl
                        .toString(),
                  ),
                  placeholder: AssetImage(AppImage.blur),
                  fit: BoxFit.contain),
            )),
      ]),
    );
  }

  static Widget productTwoDetailsContainer(
      {required BuildContext context, Widget? productDetail}) {
    return Padding(
        padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
        child: Container(
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? 20.h
              : 25.h,
          child: Row(children: [
            Expanded(
              flex: 3,
              child: productDetail ??
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidgetForProcessTwoDetailsContainer(
                          title: '${AppStrings.customerName}:',
                          text:
                              '${processTwoController.customerInfo.value.firstname.toString()} ${processTwoController.customerInfo.value.lastname}'),
                      textWidgetForProcessTwoDetailsContainer(
                          title: '${AppStrings.orderNumber}:',
                          text: processTwoController.orderDetails.value.orderNo
                              .toString()),
                      textWidgetForProcessTwoDetailsContainer(
                          title: '${AppStrings.orderDate}:',
                          text: DateFormat('dd.MM.yyyy').format(
                              processTwoController.orderDetails.value
                                  .orderStatusDates![0].placed!)),
                    ],
                  ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 15.h
                          : 20.h,
                  width: MediaQuery.of(context).size.width * .90,
                  child: FadeInImage(
                    image: NetworkImage(
                      'https://fiorettosystem.s3.eu-central-1.amazonaws.com/a7b1cd03-3b39-46fa-a091-68b1765b2435.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4N5HTZ5LCQDP24GO%2F20230221%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20230221T050740Z&X-Amz-Expires=604800&X-Amz-Signature=326f68e2e14860c2d54d660df1872d494124ec0e440ef90505477fca91a5dd63&X-Amz-SignedHeaders=host',
                    ),
                    fit: BoxFit.contain,
                    placeholder: AssetImage(AppImage.blur),
                  ),
                )),
          ]),
        ));
  }

  static Widget productTwoFieldWidget(
          {required String fieldOne,
          required String fieldTwo,
          required String fieldThree,
          required String fieldOneText,
          required String fieldTwoText,
          required String fieldThreeText,
          Color? fieldThreeColor,
          String? packageOrProduct,
          String? undamagedStorage,
          bool buttonVisibility = true,
          required String buttonText,
          required VoidCallback onTap}) =>
      Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            margin: paddingSymmetric(horizontal: 6.w, vertical: 0.w),
            padding: paddingSymmetric(horizontal: 1.w, vertical: 3.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppWidget.productTwoTitleText(
                    alignment: Alignment.centerLeft,
                    text: fieldOne ?? '',
                    flex: 2),
                AppWidget.productTwoTitleText(
                    alignment: Alignment.centerLeft, text: fieldTwo ?? ' '),
                AppWidget.productTwoTitleText(
                    alignment: Alignment.centerLeft,
                    flex: 2,
                    text: fieldThree ?? '',
                    maxLines: 2)
              ],
            ),
          ),
          Container(
            margin: paddingSymmetric(horizontal: 6.w, vertical: 0.w),
            padding: paddingSymmetric(horizontal: 1.w, vertical: 2.w),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppWidget.productTwoSubText(
                    alignment: Alignment.centerLeft,
                    flex: 2,
                    maxLine: 3,
                    text: fieldOneText ?? ''),
                AppWidget.productTwoSubText(
                  alignment: Alignment.centerLeft,
                  text: fieldTwoText,
                ),
                AppWidget.productTwoSubText(
                  alignment: Alignment.centerLeft,
                  maxLine: 3,
                  flex: 2,
                  text: fieldThreeText,
                  textColor: fieldThreeColor,
                ),
              ],
            ),
          ),
          Padding(
            padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  packageOrProduct == 'package'
                      ? Flexible(flex: 2, child: Container())
                      : Flexible(
                          flex: 2,
                          child: AppWidget.richTextForProductOne(
                              fontSize: 10.sp,
                              text1: '${AppStrings.lagerplatz}:',
                              text2: undamagedStorage ?? '',
                              childColor: AppColor.green),
                        ),
                  Flexible(
                    child: Visibility(
                        visible: buttonVisibility,
                        child: AppWidget.buttonStyleSmallText(
                          fontSize: 9.sp,
                          text: buttonText,
                          onTap: onTap,
                        )),

                    // child: Container(
                    //   //    color: Colors.red,
                    //   alignment: Alignment.centerRight,
                    //   child: Text(AppStrings.produktZuweisen,
                    //       style: AppStyle.extraSmallTextStyle
                    //           .copyWith(
                    //               color: AppColor.lightBlue,
                    //               decoration:
                    //                   TextDecoration.underline,
                    //               fontSize: 9.sp),
                    //       textAlign: TextAlign.center),
                    // ),
                  ),
                ]),
          ),
          smallerSizedBox,
          Divider(
            color: AppColor.extraDarkPink.withOpacity(0.1),
            thickness: 2.w,
          ),
          smallerSizedBox,
        ],
      );

  static textWidgetForProcessTwoDetailsContainer(
          {required String title, required String text}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyle.smallTextStyle.copyWith(
                color: AppColor.black,
                fontWeight: FontWeight.w700,
                fontSize: 11.sp),
          ),
          Text(
            text,
            style: AppStyle.smallTextStyle.copyWith(
                color: AppColor.extraDarkPink,
                fontWeight: FontWeight.w700,
                fontSize: 11.sp),
          ),
          smallerSizedBox,
        ],
      );

  static richTextForProductOne(
          {required String text1,
          required String text2,
          double? fontSize,
          Color? color,
          Color? childColor,
          int? maxLine}) =>
      RichText(
          maxLines: maxLine ?? 3,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
              text: text1,
              style: AppStyle.smallTextStyle.copyWith(
                  color: color ?? AppColor.black,
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                  fontSize: fontSize),
              children: [
                TextSpan(
                  text: text2,
                  style: AppStyle.smallTextStyle.copyWith(
                      color: childColor ?? AppColor.black,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                      fontSize: fontSize),
                )
              ]));

  static questionOneValue() => AppWidget.selectedTextForProductOne(
      color: processOneController.firstQueAns.value == 'Nein'
          ? AppColor.green
          : Colors.red,
      icon: processOneController.firstQueAns.value == 'Nein'
          ? Icons.done
          : Icons.close,
      text: 'Produkt durch Mitarbeiter auf Beschädigungen geprüft.');

  static questionTwoValue() => AppWidget.selectedTextForProductOne(
      color: processOneController.secondQueAns.value == 'Ja'
          ? AppColor.green
          : Colors.red,
      icon: processOneController.secondQueAns.value == 'Ja'
          ? Icons.done
          : Icons.close,
      text: 'Gerät erfolgreich auf Funktion getestet und abgenommen.');

  static selectedTextForProductOne(
          {required String text, IconData? icon, Color? color}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            minRadius: 10,
            maxRadius: 10,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 14,
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          Flexible(
              child: Text(
            text,
            style: AppStyle.extraSmallTextStyle.copyWith(fontSize: 9.sp),
          ))
        ],
      );

  static commanTextStyForProductOne({required String text}) => Text(
        text,
        style: AppStyle.smallTextStyle
            .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
      );

  static orderListContainer(
          {required BuildContext context, required String text}) =>
      Container(
        height: 3.h,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 3.w),
        margin: paddingSymmetric(horizontal: 6.w, vertical: 00),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.w),
          color: AppColor.extraDarkPink,
        ),
        child: Text(text,
            style: AppStyle.extraSmallTextStyle.copyWith(color: Colors.white)),
      );

  static productTwoTitleText(
          {required String text,
          int? maxLines,
          int? flex,
          AlignmentGeometry? alignment}) =>
      Expanded(
        flex: flex ?? 1,
        child: Align(
          alignment: alignment ?? Alignment.center,
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            textAlign: TextAlign.center,
            style: AppStyle.extraSmallTextStyle.copyWith(
                fontSize: 9.sp,
                color: AppColor.black,
                fontWeight: FontWeight.w700),
          ),
        ),
      );

  static productTwoSubText(
          {required String text,
          Color? textColor,
          int? maxLine,
          int? flex,
          AlignmentGeometry? alignment}) =>
      Expanded(
        flex: flex ?? 1,
        child: Align(
          alignment: alignment ?? Alignment.center,
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            textWidthBasis: TextWidthBasis.parent,
            textAlign: TextAlign.left,
            maxLines: maxLine ?? 2,
            style: AppStyle.extraSmallTextStyle.copyWith(
                fontSize: 9.sp,
                color: textColor ?? AppColor.black,
                fontWeight: FontWeight.w400),
          ),
        ),
      );

  static buttonWithOnlyBorder(
          {required VoidCallback onTap,
          required String text,
          double? fontSize,
          TextStyle? textStyle}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 5.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.w),
              border: Border.all(color: AppColor.lightBlue)),
          child: Text(text,
              style: textStyle ??
                  AppStyle.extraSmallTextStyle
                      .copyWith(color: Colors.black, fontSize: fontSize),
              // maxLines: 2,
              // textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis),
        ),
      );

  static addPictureContainer(
          {required String text,
          required BuildContext context,
          required VoidCallback onTap}) =>
      Flexible(
          child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: DottedDecoration(
            shape: Shape.box,
            color: AppColor.grey,
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: paddingAll(padding: 1.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.w),
                color: AppColor.extraDarkPink,
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
            smallerSizedBox,
            Text(
              text,
              style: AppStyle.extraSmallTextStyle,
            )
          ]),
        ),
      ));

  static progressIndicator() => Center(
        child: CircularProgressIndicator(
            color: AppColor.lightBlue, backgroundColor: AppColor.extraDarkPink),
      );

  static showShackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(days: 1),
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_wifi_off,
              color: Colors.white,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
                child: Text(
                  'No internet available',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
            textColor: Colors.white, label: 'RETRY', onPressed: () async {}),
        backgroundColor: Colors.grey,
      ));

  static showDialogForProductEinzelprufung(
          {required BuildContext context, required unDamagedStorage}) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) {
            log('PAC ${processTwoController.isProductOrPackage.value}');
            return AlertDialog(
              content: SingleChildScrollView(
                  child: Obx(
                () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppStrings.scannenSieDasGerat,
                              style: AppStyle.smallTextStyle
                                  .copyWith(color: Colors.black)),
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.close),
                            color: Colors.black,
                            splashColor: AppColor.extraDarkPink,
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 2,
                      ),
                      smallSizedBox,
                      Center(
                        child: processTwoController
                                .scanBarcodeDeviceId.value.isEmpty
                            ? Image.asset(
                                AppImage.barcode,
                                height: 15.h,
                              )
                            : FadeInImage(
                                placeholder: AssetImage(AppImage.blur),
                                placeholderErrorBuilder:
                                    ((context, error, stackTrace) {
                                  return Container();
                                }),
                                image: (processTwoController
                                            .inventoryDetails
                                            .value
                                            .productInfo?[0]
                                            .productImageUrl !=
                                        null)
                                    ? NetworkImage(processTwoController
                                        .inventoryDetails
                                        .value
                                        .productInfo![0]
                                        .productImageUrl
                                        .toString())
                                    : AssetImage(AppImage.blur)
                                        as ImageProvider,
                                height: 15.h),
                      ),
                      smallerSizedBox,
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 2,
                      ),
                      smallerSizedBox,
                      AppWidget.richTextForProductOne(
                          text1: AppStrings.produktIstAn,
                          text2: unDamagedStorage,
                          childColor: AppColor.green),
                      smallerSizedBox,
                      Visibility(
                        visible: processTwoController
                                .scanBarcodeDeviceId.value.isEmpty
                            ? false
                            : true,
                        child: AppWidget.richTextForProductOne(
                          text1: AppStrings.deviceID,
                          text2: processTwoController.scanBarcodeDeviceId.value,
                        ),
                      ),
                      smallerSizedBox,
                      Visibility(
                        visible: processTwoController
                                .scanBarcodeDeviceId.value.isEmpty
                            ? false
                            : true,
                        child: AppWidget.richTextForProductOne(
                          text1: '${AppStrings.produkt}:',
                          text2: processTwoController.inventoryDetails.value
                                  .productInfo?[0].productName ??
                              ' ',
                        ),
                      ),
                      smallSizedBox,
                      if (processTwoController.isProductOrPackage.value ==
                          'product') ...[
                        if (processTwoController
                                .scanBarcodeDeviceId.value.isNotEmpty &&
                            (processTwoController
                                    .selectedProductItem.value.itemId
                                    .toString() !=
                                (processTwoController.inventoryDetails.value
                                        .productInfo?[0].id ??
                                    '')))
                          Text(
                              'Sie haben das falsche Produkt gescannt. Holen Sie '
                              '${processTwoController.selectedProductItem.value.itemName} an: ${unDamagedStorage} ab.',
                              style: AppStyle.smallTextStyle
                                  .copyWith(color: Colors.red)),
                      ] else ...[
                        if (processTwoController
                                .scanBarcodeDeviceId.value.isNotEmpty &&
                            (processTwoController
                                    .selectedPackageItem.value.productInfo?.id
                                    .toString() !=
                                (processTwoController.inventoryDetails.value
                                        .productInfo?[0].id ??
                                    '')))
                          Text(
                              'Sie haben das falsche Produkt gescannt. Holen Sie '
                              '${processTwoController.selectedProductItem.value.itemName} an: ${unDamagedStorage} ab.',
                              style: AppStyle.smallTextStyle
                                  .copyWith(color: Colors.red)),
                      ],
                      smallSizedBox,
                      Obx(
                        () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (processTwoController
                                  .scanBarcodeDeviceId.value.isNotEmpty)
                                AppWidget.buttonStyleSmallText(
                                  fontSize: 9.sp,
                                  text: AppStrings.erneutScannen,
                                  onTap: () async => await scanBarcodeNormal(),
                                ),
                              SizedBox(
                                width: 2.w,
                              ),
                              if (processTwoController
                                      .isProductOrPackage.value ==
                                  'product') ...[
                                if (processTwoController
                                        .scanBarcodeDeviceId.value.isNotEmpty &&
                                    (processTwoController
                                            .selectedProductItem.value.itemId
                                            .toString() ==
                                        (processTwoController.inventoryDetails
                                                .value.productInfo?[0].id ??
                                            '')))
                                  AppWidget.buttonStyleSmallText(
                                      fontSize: 10.sp,
                                      text: AppStrings.hinzufugen,
                                      onTap: () async {
                                        await processTwoController
                                            .assignInventoryToOrderItemApiCall();
                                      }),
                              ] else ...[
                                if (processTwoController
                                        .scanBarcodeDeviceId.value.isNotEmpty &&
                                    (processTwoController.selectedPackageItem
                                            .value.productInfo?.id
                                            .toString() ==
                                        (processTwoController.inventoryDetails
                                                .value.productInfo?[0].id ??
                                            '')))
                                  AppWidget.buttonStyleSmallText(
                                      fontSize: 10.sp,
                                      text: AppStrings.hinzufugen,
                                      onTap: () async {
                                        await processTwoController
                                            .assignInventoryToOrderItemApiCall();
                                      }),
                              ],
                              if (processTwoController
                                  .scanBarcodeDeviceId.value.isEmpty)
                                AppWidget.buttonStyleSmallText(
                                  fontSize: 10.sp,
                                  text: AppStrings.scanStarten,
                                  onTap: () async => await scanBarcodeNormal(),
                                ),
                            ]),
                      )
                    ]),
              )),
            );
          }));

  // Platform messages are asynchronous, so we initialize in an async method.
  static Future<void> scanBarcodeNormal() async {
    log('LOGINID ${SharedPrefClass.getString(SharedPrefStrings.loginId)}');
    log('LOGINID ${SharedPrefClass.getString(SharedPrefStrings.loginId)}');
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.BARCODE)
          .then((barcodeScanRes) async {
        log(barcodeScanRes);
        processTwoController.scanBarcodeDeviceId.value = barcodeScanRes;
        await processTwoController.getInventoryByDeviceIdApiCall();

        log('ItemId ${processTwoController.selectedProductItem.value.itemId.toString()}');
        log('ProductInfoId ${processTwoController.inventoryDetails.value.productInfo?[0].id.toString()}');
        processTwoController.update();
        return barcodeScanRes;
      });
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  static showDialogForProductMassenErfassung({required BuildContext context}) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.produktZuweisen,
                          style: AppStyle.smallTextStyle
                              .copyWith(color: Colors.black)),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.close),
                        color: Colors.black,
                        splashColor: AppColor.extraDarkPink,
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                  ),
                  smallSizedBox,
                  Obx(
                    () => AppWidget.outlineTextFormField(
                        hintText: AppStrings.menge,
                        controller:
                            processTwoController.manuallyAddedQuantity.value),
                  ),
                  smallSizedBox,
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                  ),
                  smallerSizedBox,
                  AppWidget.buttonStyleSmallText(
                      text: AppStrings.hinzufugen,
                      onTap: () async {
                        await processTwoController
                            .assignInventoryToOrderItemApiCall();
                      })
                ]),
              ),
            );
          }));
}
