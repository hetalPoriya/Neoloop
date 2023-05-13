import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/controller/processOne_controller.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:neoloop/utils/app_colors.dart';
import 'package:neoloop/utils/app_images.dart';
import 'package:neoloop/utils/app_styles.dart';
import 'package:sizer/sizer.dart';

class ProdukteingangProduktionConfirmation extends StatelessWidget {
  const ProdukteingangProduktionConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Controller
    HomeController homeController = Get.put(HomeController());
    ProcessOneController processOneController = Get.put(ProcessOneController());
    return Padding(
      padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppWidget.productOneDetailContainer(
            context: context,
          ),
          AppWidget.questionOneValue(),
          // AppWidget.selectedTextForProductOne(
          //     color: processOneController.firstQueAns.value == 'Nein'
          //         ? AppColor.green
          //         : Colors.red,
          //     icon: processOneController.firstQueAns.value == 'Nein'
          //         ? Icons.done
          //         : Icons.close,
          //     text: 'Produkt durch Mitarbeiter auf Beschädigungen geprüft.'),
          smallerSizedBox,
          AppWidget.questionTwoValue(),
          // AppWidget.selectedTextForProductOne(
          //     color: processOneController.secondQueAns.value == 'Ja'
          //         ? AppColor.green
          //         : Colors.red,
          //     icon: processOneController.secondQueAns.value == 'Ja'
          //         ? Icons.done
          //         : Icons.close,
          //     text: 'Gerät erfolgreich auf Funktion getestet und abgenommen.'),
          smallSizedBox,
          const Divider(
            color: Colors.grey,
            thickness: 2,
            height: 1,
          ),
          Container(
            height: 4.h,
            color: AppColor.extraLightPink,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppWidget.commanTextStyForProductOne(text: 'Serial No.'),
                AppWidget.commanTextStyForProductOne(text: 'Date'),
                AppWidget.commanTextStyForProductOne(text: 'Time'),
              ],
            ),
          ),
          Container(
            height: 5.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    processOneController
                        .selectedProductItem.value.ecosharkSerialNo
                        .toString(),
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.smallTextStyle.copyWith(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp),
                  ),
                ),
                Flexible(
                  child: Text(
                    DateFormat.yMd().format(DateTime.now()),
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.smallTextStyle.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp),
                  ),
                ),
                Flexible(
                  child: Text(DateFormat.jm().format(DateTime.now()),
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.smallTextStyle.copyWith(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp)),
                )
              ],
            ),
          ),
          smallSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppWidget.richTextForProductOne(
                  text1: 'Type:',
                  text2: processOneController
                      .selectedProductItem.value.producttypeInfo![0]!.type
                      .toString()),
              AppWidget.richTextForProductOne(text1: 'Qty:', text2: ' 01'),
            ],
          ),
          smallSizedBox,
          AppWidget.richTextForProductOne(
              text1: 'Color:',
              text2: processOneController.selectedProductItem.value.color
                  .toString()),
          smallSizedBox,
          AppWidget.richTextForProductOne(
              text1: 'Lagerplätze:',
              childColor: (processOneController.firstQueAns.value == 'Nein' &&
                      processOneController.secondQueAns.value == 'Ja')
                  ? AppColor.green
                  : Colors.red,
              text2: (processOneController.firstQueAns.value == 'Nein' &&
                      processOneController.secondQueAns.value == 'Ja')
                  ? processOneController
                      .selectedProductItem.value.undamagedStorage
                      .toString()
                  : processOneController
                      .selectedProductItem.value.damagedStorage
                      .toString()),
          mediumSizedBox,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     AppWidget.richTextForProductOne(text1: 'Type:', text2: ' Heater'),
          //     AppWidget.richTextForProductOne(text1: 'Qty:', text2: ' 01'),
          //   ],
          // ),
          // smallSizedBox,
          // AppWidget.richTextForProductOne(
          //     text1: 'Color:', text2: ' White & Gray'),
          // smallSizedBox,
          // AppWidget.richTextForProductOne(
          //     text1: 'Lagerplätze:', text2: ' EC54'),
          SizedBox(height: 8.h),
          Padding(
              padding: paddingSymmetric(horizontal: 8.w, vertical: 00),
              child: AppWidget.buttonStyleSmallText(
                text: 'Erfolfreich eingelagert',
                onTap: () async {
                  await processOneController
                      .addInventoryForProductTypeEinzelufungApiCall()
                      .then((value) => _showSuccessDialog(
                          context: context,
                          homeController: homeController,
                          processOneController: processOneController));
                },
                fontSize: 11.sp,
              )),
          smallSizedBox,
        ],
      ),
    );
  }

  _showSuccessDialog(
      {required BuildContext context,
      required HomeController homeController,
      required ProcessOneController processOneController}) {
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
                    'Produkt erfolgreich registriert und eingelagert.',
                    textAlign: TextAlign.center,
                    style: AppStyle.smallTextStyle
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  smallSizedBox,
                  AppWidget.richTextForProductOne(
                      text1: 'Lagerplätze:',
                      childColor: (processOneController.firstQueAns.value ==
                                  'Nein' &&
                              processOneController.secondQueAns.value == 'Ja')
                          ? AppColor.green
                          : Colors.red,
                      text2: (processOneController.firstQueAns.value ==
                                  'Nein' &&
                              processOneController.secondQueAns.value == 'Ja')
                          ? processOneController
                              .selectedProductItem.value.undamagedStorage
                              .toString()
                          : processOneController
                              .selectedProductItem.value.damagedStorage
                              .toString()),
                  mediumSizedBox,
                  Padding(
                    padding: paddingSymmetric(horizontal: 15.w, vertical: 00),
                    child: AppWidget.buttonStyleSmallText(
                      // height: 4.h,
                      text: 'Ok',
                      onTap: () {
                        Get.back();
                        homeController.processOneIndex.value = 3;
                        homeController.update();
                      },
                    ),
                  )
                ],
              ),
              scrollable: true,
            )));
  }
}
