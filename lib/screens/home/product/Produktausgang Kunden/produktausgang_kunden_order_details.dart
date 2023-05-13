import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/controller/processTwo_controller.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:sizer/sizer.dart';
import 'dart:developer';

import '../../../../utils/utils.dart';

class ProduktausgangKundenOrderDetails extends StatefulWidget {
  const ProduktausgangKundenOrderDetails({Key? key}) : super(key: key);

  @override
  State<ProduktausgangKundenOrderDetails> createState() =>
      _ProduktausgangKundenOrderDetailsState();
}

class _ProduktausgangKundenOrderDetailsState
    extends State<ProduktausgangKundenOrderDetails> {
  //controller
  HomeController homeController = Get.put(HomeController());
  ProcessTwoController processTwoController = Get.put(ProcessTwoController());

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  apiCall() async {
    await processTwoController.getAllOrderApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return processTwoController.isLoading.value == true
            ? AppWidget.progressIndicator()
            : Column(
                children: [
                  AppWidget.productTwoDetailsContainer(context: context),
                  smallSizedBox,
                  AppWidget.orderListContainer(
                      context: context, text: AppStrings.bestelldetails),
                  smallSizedBox,
                  processTwoController.orderItem.isEmpty
                      ? Center(
                          child: Text(
                            'No product found',
                            style: AppStyle.smallTextStyle,
                          ),
                        )
                      : ListView.builder(
                          itemCount: processTwoController.orderItem.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return AppWidget.productTwoFieldWidget(
                                fieldOne: AppStrings.produktPaket,
                                fieldTwo: AppStrings.menge,
                                fieldThree: AppStrings.orderStatus,
                                fieldOneText:
                                    '${processTwoController.orderItem[index].itemName}',
                                fieldTwoText: processTwoController.orderItem[index].itemType ==
                                        'product'
                                    ? processTwoController.orderItem[index].pickedQuantity.toString().length !=
                                            2
                                        ? '${processTwoController.orderItem[index].pickedQuantity[0].quantity.toString()} / ${processTwoController.orderItem[index].quantity.toString()}'
                                        : '0 / ${processTwoController.orderItem[index].quantity}'
                                    : processTwoController
                                        .orderItem[index].quantity,
                                fieldThreeText:
                                    processTwoController.orderItem[index].allPickedup == true
                                        ? 'Versandfertig'
                                        : 'Nicht versandfertig',
                                fieldThreeColor:
                                    processTwoController.orderItem[index].allPickedup == true
                                        ? AppColor.green
                                        : Colors.red,
                                packageOrProduct: processTwoController
                                    .orderItem[index].itemType,
                                undamagedStorage: processTwoController
                                    .orderItemsDetail[index].undamagedStorage,
                                buttonVisibility: (processTwoController.orderItem[index].itemType == 'product' &&
                                        processTwoController.orderItem[index].allPickedup ==
                                            true)
                                    ? false
                                    : true,
                                buttonText: processTwoController.orderItem[index].itemType == 'package'
                                    ? AppStrings.offnen
                                    : AppStrings.produktZuweisen,
                                onTap: () async {
                                  processTwoController
                                          .selectedProductItem.value =
                                      processTwoController.orderItem[index];
                                  processTwoController.update();
                                  if (processTwoController
                                          .orderItem[index].itemType ==
                                      'package') {
                                    processTwoController
                                        .isProductOrPackage.value = 'package';
                                    processTwoController.update();
                                    homeController.processTwoIndex.value = 2;
                                    homeController.update();

                                    await processTwoController
                                        .getPackageOrderItemInventoryApiCall();
                                  } else {
                                    processTwoController
                                        .isProductOrPackage.value = 'product';
                                    processTwoController.update();
                                    if (processTwoController
                                            .orderItemsDetail[index]
                                            .producttypeInfo
                                            .type ==
                                        'Massen Erfassung') {
                                      processTwoController
                                              .isProductOrPackageAndType.value =
                                          AppStrings.productTypeMassenErfassung;
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
                                          AppStrings.productTypeEinzelprufung;
                                      processTwoController.update();
                                      log(processTwoController
                                          .scanBarcodeDeviceId
                                          .toString());
                                      AppWidget
                                          .showDialogForProductEinzelprufung(
                                              context: context,
                                              unDamagedStorage:
                                                  processTwoController
                                                      .orderItemsDetail[index]
                                                      .undamagedStorage);
                                    }
                                  }
                                });
                          })),
                  smallerSizedBox,
                  Padding(
                    padding: paddingSymmetric(horizontal: 14.w, vertical: 00),
                    child: AppWidget.buttonStyleSmallText(
                      text: 'Erfolgreich abgeholt',
                      onTap: () {
                        int trueValue = 0;
                        for (int i = 0;
                            i < processTwoController.orderItem.length;
                            i++) {
                          if (processTwoController.orderItem[i].allPickedup ==
                              true) {
                            trueValue++;
                          }
                        }
                        log(trueValue.toString());
                        log(processTwoController.orderItem.length.toString());
                        if (trueValue ==
                            processTwoController.orderItem.length) {
                          Fluttertoast.showToast(msg: 'AllPickedUp ');
                        }
                      },
                      //onTap: () => _showDialog(homeController: homeController),
                    ),
                  ),
                  smallSizedBox,
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
}
