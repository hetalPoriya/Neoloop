import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/controller/processOne_controller.dart';
import 'package:neoloop/model/processOne/upload_document_info.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:neoloop/utils/app_colors.dart';
import 'package:neoloop/utils/app_images.dart';
import 'package:neoloop/utils/app_strings.dart';
import 'package:neoloop/utils/app_styles.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class ProdukteingangProduktionQue extends StatefulWidget {
  const ProdukteingangProduktionQue({Key? key}) : super(key: key);

  @override
  State<ProdukteingangProduktionQue> createState() =>
      _ProdukteingangProduktionQueState();
}

class _ProdukteingangProduktionQueState
    extends State<ProdukteingangProduktionQue> {
  // controller
  HomeController homeController = Get.put(HomeController());
  ProcessOneController processOneController = Get.put(ProcessOneController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            //shrinkWrap: true,
            children: [
              AppWidget.productOneDetailContainer(
                context: context,
              ),
              smallSizedBox,
              if (processOneController
                      .selectedProductItem.value.producttypeInfo?[0]?.type ==
                  'Massen Erfassung') ...[
                Text(
                  AppStrings.stockLable,
                  style: AppStyle.extraSmallTextStyle
                      .copyWith(color: Colors.black, fontSize: 10.sp),
                ),
                smallSizedBox,
                AppWidget.outlineTextFormField(
                    hintText: AppStrings.stockPlaceHolder,
                    textInputType: TextInputType.number,
                    controller: processOneController.stockController.value),
                smallerSizedBox,
                AppWidget.richTextForProductOne(
                    text1: AppStrings.stockLocation,
                    text2: processOneController
                        .selectedProductItem.value.undamagedStorage
                        .toString(),
                    childColor: AppColor.green),
                smallerSizedBox,
                Divider(color: Colors.grey.shade400, thickness: 2),
                smallerSizedBox,
                Text(
                  AppStrings.damagedStockLable,
                  style: AppStyle.extraSmallTextStyle
                      .copyWith(color: Colors.black, fontSize: 10.sp),
                ),
                smallSizedBox,
                AppWidget.outlineTextFormField(
                    hintText: AppStrings.damagedStockPlaceHolder,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    controller:
                        processOneController.damagedStockController.value),
                smallSizedBox,
                AppWidget.richTextForProductOne(
                    text1: AppStrings.stockLocation,
                    text2: processOneController
                        .selectedProductItem.value.damagedStorage
                        .toString(),
                    childColor: Colors.red),
                smallSizedBox,
              ] else ...[
                Container(
                  height: 4.h,
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.w),
                    color: AppColor.extraDarkPink,
                  ),
                  child: Text(
                    'Fragen:',
                    style:
                        AppStyle.smallTextStyle.copyWith(color: Colors.white),
                  ),
                ),
                smallSizedBox,
                _questions(
                    checkListItems1: processOneController.checkListItems1,
                    Queindex: 0,
                    question: '1). Ist eine sichtbare Beschädigung erkennbar?'),
                smallSizedBox,
                _questions(
                    checkListItems1: processOneController.checkListItems2,
                    Queindex: 1,
                    question: '2). Lässt sich das Gerät einschalten?'),
                smallSizedBox,
                Text(
                    'Bitte machen Sie ein Foto von Front und Rückseite des Geräts.',
                    style: AppStyle.extraSmallTextStyle
                        .copyWith(color: Colors.grey.shade800)),
                mediumSizedBox,
                Container(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 12.h
                          : 20.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Image.asset(
                          AppImage.box,
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 11.h
                              : 18.h,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppWidget.addPictureContainer(
                                // image:
                                //     processOneController.frontImage.value,
                                onTap: () => _openCamera(front: true),
                                text: 'Front',
                                context: context),
                            SizedBox(
                              width: 2.w,
                            ),
                            AppWidget.addPictureContainer(
                                // image: processOneController.backImage.value,
                                onTap: () => _openCamera(front: false),
                                text: 'Back',
                                context: context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                displayImageWidget(
                    list: processOneController.frontImagesList,
                    title: 'Vorderseite:'),
                displayImageWidget(
                    list: processOneController.backImagesList,
                    title: 'Rückseite:'),
              ],
              smallSizedBox,
              Padding(
                padding: paddingSymmetric(horizontal: 4.w, vertical: 00),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(2.w),
                  child: AppWidget.buttonStyleSmallText(
                      text: 'Produkt registrieren & einlagern',
                      onTap: () async {
                        if (processOneController.selectedProductItem.value
                                .producttypeInfo?[0]?.type ==
                            'Massen Erfassung') {
                          if (processOneController
                                  .stockController.value.text.isNotEmpty ||
                              processOneController.damagedStockController.value
                                  .text.isNotEmpty) {
                            await processOneController
                                .addInventoryForProductTypeMassenErfassungApiCall()
                                .then((value) => _showSuccessDialog());
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Please fill any one filed');
                          }
                        } else {
                          log('CHECKBOX ${processOneController.questionOneAttemptOrNot.value}');
                          log('CHECKBOX ${processOneController.questionTwoAttemptOrNot.value}');
                          // log(processOneController.backImagesList.length
                          //     .toString());
                          if (processOneController
                                      .questionOneAttemptOrNot.value ==
                                  false ||
                              processOneController
                                      .questionTwoAttemptOrNot.value ==
                                  false) {
                            Fluttertoast.showToast(
                                msg: 'Please attempt questions');
                          } else if (processOneController
                                  .frontImagesList.isEmpty ||
                              processOneController.backImagesList.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please add photo atleast one in both');
                          } else {
                            homeController.processOneIndex.value = 2;
                            homeController.update();
                          }
                        }
                      },
                      fontSize: 11.sp),
                ),
              ),
              smallSizedBox,
            ],
          ),
          Obx(
            () => (processOneController.isLoading.value == true)
                ? AppWidget.progressIndicator()
                : Container(),
          )
        ],
      ),
    );
  }

  _questions(
      {required List checkListItems1,
      required String question,
      required int Queindex}) {
    log('Values ${checkListItems1[0]["value"]}');
    log('Values ${checkListItems1[1]["value"]}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          question,
          style: AppStyle.extraSmallTextStyle.copyWith(fontSize: 9.sp),
        ),
        Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            alignment: Alignment.bottomCenter,
            child: Obx(
              () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    2,
                    (index) => Flexible(
                        child: Container(
                            width: 35.w,
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  side: BorderSide(
                                      color: checkListItems1[index]["value"] ==
                                              true
                                          ? AppColor.extraDarkPink
                                          : Colors.grey,
                                      width: 1.5),
                                  activeColor: AppColor.extraDarkPink,
                                  value: checkListItems1[index]["value"],
                                  onChanged: (value) {
                                    for (var element in checkListItems1) {
                                      element["value"] = false;
                                    }
                                    checkListItems1[index]["value"] = value;

                                    if (Queindex == 0) {
                                      processOneController.firstQueAns.value =
                                          checkListItems1[index]["title"];
                                      processOneController
                                          .questionOneAttemptOrNot.value = true;
                                      processOneController.update();
                                    }
                                    if (Queindex == 1) {
                                      processOneController.secondQueAns.value =
                                          checkListItems1[index]["title"];
                                      processOneController
                                          .questionTwoAttemptOrNot.value = true;
                                      processOneController.update();
                                    }

                                    setState(() {});
                                  },
                                ),
                                Text(
                                  checkListItems1[index]["title"],
                                  style: AppStyle.extraSmallTextStyle.copyWith(
                                      fontSize: 9.sp,
                                      color: checkListItems1[index]["value"] ==
                                              true
                                          ? AppColor.extraDarkPink
                                          : Colors.grey),
                                ),
                              ],
                            ))),
                  )),
            )),
      ],
    );
  }

  _askPermission() async {
    //await Permission.camera.request();
    PermissionStatus status = await Permission.camera.request();
    log(status.toString());
    if (status.isGranted == true) {
      return true;
    } else if (status.isDenied == true) {
      log('denied');
      _askPermission();
    } else {
      await openAppSettings();
      Fluttertoast.showToast(msg: 'Please grant camera permission.');
    }
  }

  _openCamera({required bool front}) async {
    await _askPermission();

    var image = (await ImagePicker().pickImage(source: ImageSource.camera))!;
    if (front == true) {
      processOneController.frontImage.value = File(image.path);
    } else {
      processOneController.backImage.value = File(image.path);
    }

    final bytes = File(image.path).readAsBytesSync().lengthInBytes;
    double sizeInMb = bytes / (1024 * 1024);
    String value = getFileExtension(image.path)!;
    log('${sizeInMb.floor().toStringAsFixed(2)}mb,image/$value,${DateTime.now().millisecondsSinceEpoch}');
    processOneController.uploadDocumentApiCall(
        image: File(image.path),
        size: sizeInMb,
        type: value,
        front: front == true ? true : false);
    processOneController.update();
    return image;
  }

  String? getFileExtension(String fileName) {
    try {
      return "." + fileName.split('.').last;
    } catch (e) {
      print(e);
    }
  }

  _showSuccessDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImage.checkMark,
                      height: 10.h, color: AppColor.green),
                  mediumSizedBox,
                  Text(
                    'Erfolgreich eingelagert',
                    style: AppStyle.smallTextStyle
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  smallSizedBox,
                  AppWidget.richTextForProductOne(
                      text1: 'Unbeschädigt Lagerplatz: ',
                      text2: processOneController
                          .selectedProductItem.value.undamagedStorage
                          .toString(),
                      childColor: AppColor.green),
                  smallSizedBox,
                  AppWidget.richTextForProductOne(
                      text1: 'Beschädigt Lagerplatz: ',
                      text2: processOneController
                          .selectedProductItem.value.undamagedStorage
                          .toString(),
                      childColor: Colors.red),
                  smallSizedBox,
                  Padding(
                    padding: paddingSymmetric(horizontal: 15.w, vertical: 00),
                    child: AppWidget.buttonStyleSmallText(
                      // height: 4.h,
                      text: 'Ok',
                      onTap: () {
                        Get.back();
                        homeController.processOneIndex.value = 0;
                        homeController.processIndex.value = 0;
                        homeController.isProcessSelected.value = false;
                        homeController.update();
                      },
                    ),
                  )
                ],
              ),
              scrollable: true,
            )));
  }

  displayImageWidget(
      {required RxList<UploadDocumentInfo> list, required String title}) {
    return Obx(
      () => list.isEmpty
          ? Container()
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              smallerSizedBox,
              Text(
                title,
                style: AppStyle.extraSmallTextStyle
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              smallerSizedBox,
              Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 12.h
                        : 20.h,
                child: ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) => Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 12.h
                                  : 20.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        FileImage(File(list[index].imagePath!)),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                          ],
                        ))),
              )
            ]),
    );
  }
}
