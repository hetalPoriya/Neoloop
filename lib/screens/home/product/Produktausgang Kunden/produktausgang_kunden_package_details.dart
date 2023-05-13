import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/controller/processTwo_controller.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/utils.dart';

class ProduktausgangKundenPackageDetails extends StatefulWidget {
  const ProduktausgangKundenPackageDetails({Key? key}) : super(key: key);

  @override
  State<ProduktausgangKundenPackageDetails> createState() =>
      _ProduktausgangKundenPackageDetailsState();
}

class _ProduktausgangKundenPackageDetailsState
    extends State<ProduktausgangKundenPackageDetails> {
  //controller
  HomeController homeController = Get.put(HomeController());
  ProcessTwoController processTwoController = Get.put(ProcessTwoController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return processTwoController.isLoading.value == true
            ? AppWidget.progressIndicator()
            : Column(
                children: [
                  AppWidget.productTwoDetailsContainer(
                    context: context,
                    productDetail: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppWidget.textWidgetForProcessTwoDetailsContainer(
                            title: '${AppStrings.paket}:',
                            text: '${processTwoController.packageName}'),
                      ],
                    ),
                  ),
                  smallSizedBox,
                  AppWidget.orderListContainer(
                      context: context, text: AppStrings.paketdetails),
                  smallSizedBox,
                  processTwoController.packagesList.isEmpty
                      ? Center(
                          child: Text(
                            'No product found',
                            style: AppStyle.smallTextStyle,
                          ),
                        )
                      : ListView.builder(
                          itemCount: processTwoController.packagesList.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            var response =
                                processTwoController.packagesList[index];
                            return AppWidget.productTwoFieldWidget(
                                fieldOne: AppStrings.produktPaket,
                                fieldTwo: AppStrings.menge,
                                fieldThree: AppStrings.lagerplatz,
                                fieldOneText:
                                    '${response?.productInfo?.productName}',
                                fieldTwoText:
                                    '${response?.filledQuantity} / ${response?.requiredQuantity}',
                                fieldThreeText:
                                    '${response?.productInfo?.undamagedStorage}',
                                fieldThreeColor: AppColor.green,
                                packageOrProduct: 'package',
                                buttonVisibility: response?.filledQuantity <
                                        response?.requiredQuantity
                                    ? true
                                    : false,
                                buttonText: AppStrings.produktZuweisen,
                                onTap: () async {
                                  processTwoController
                                      .isProductOrPackage.value = 'package';
                                  processTwoController
                                      .selectedPackageItem.value = response;
                                  processTwoController.update();
                                  if (response
                                          .productInfo.producttypeInfo[0].type
                                          .toString() ==
                                      'Massen Erfassung') {
                                    processTwoController
                                            .isProductOrPackageAndType.value =
                                        AppStrings.packageTypeMassenErfassung;
                                    processTwoController
                                        .manuallyAddedQuantity.value
                                        .clear();
                                    processTwoController.update();
                                    AppWidget
                                        .showDialogForProductMassenErfassung(
                                            context: context);
                                  } else {
                                    processTwoController
                                        .scanBarcodeDeviceId.value = '';
                                    processTwoController
                                            .isProductOrPackageAndType.value =
                                        AppStrings.packageTypeEinzelprufung;
                                    processTwoController.update();
                                    processTwoController.update();
                                    log(processTwoController.scanBarcodeDeviceId
                                        .toString());
                                    AppWidget.showDialogForProductEinzelprufung(
                                        context: context,
                                        unDamagedStorage: response
                                            ?.productInfo?.undamagedStorage);
                                  }
                                });
                          })),
                  // mediumSizedBox,
                  // Padding(
                  //   padding: paddingSymmetric(horizontal: 14.w, vertical: 00),
                  //   child: AppWidget.buttonStyleSmallText(
                  //     text: 'Erfolgreich abgeholt',
                  //     onTap: () => _showDialog(homeController: homeController),
                  //   ),
                  // ),
                  // mediumSizedBox,
                ],
              );
      },
    );
  }

  _showDialog({required HomeController homeController}) {
    return Get.defaultDialog(
        titlePadding: paddingSymmetric(vertical: 3.h, horizontal: 6.w),
        title: 'Bringen Sie die Ware zum Kommissionierplatz',
        titleStyle:
            AppStyle.mediumTextStyle.copyWith(fontWeight: FontWeight.w900),
        content: Row(
          children: [
            SizedBox(
              width: 4.w,
            ),
            Expanded(
              child: AppWidget.buttonWithOnlyBorder(
                  onTap: () => Get.back(),
                  text: 'Abbrechen',
                  textStyle: AppStyle.smallTextStyle
                      .copyWith(fontSize: 10.sp, color: AppColor.black)),
            ),
            SizedBox(
              width: 4.w,
            ),
            Expanded(
                child: AppWidget.buttonStyleSmallText(
                    text: 'Fortsetzen',
                    onTap: () {
                      Get.back();
                      homeController.processTwoIndex.value = 3;
                      homeController.update();
                    },
                    fontSize: 10.sp)),
            SizedBox(
              width: 4.w,
            ),
          ],
        ));
  }

  aboveWidget({required String title, required String text}) {
    return Column(
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
  }
}
