import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/controller/processOne_controller.dart';
import 'package:neoloop/screens/screens.dart';

import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import '../../../../utils/utils.dart';

class ProdukteingangProduktionPrint extends StatelessWidget {
  const ProdukteingangProduktionPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //controller
    HomeController homeController = Get.put(HomeController());
    ProcessOneController processOneController = Get.put(ProcessOneController());

    // FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;
    // checkBluetoothPermission() async {
    //   var status = await Permission.location.status;
    //   var status1 = await Permission.bluetooth.status;
    //   var status2 = await Permission.nearbyWifiDevices.status;
    //   // processOneController.devicesList.clear();
    //   log(status.toString());
    //   if (status.isGranted || status1.isGranted || status2.isGranted) {
    //     if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
    //       processOneController.deviceData.value = [];
    //       flutterBluePlus.state.listen((event) async {
    //         Fluttertoast.showToast(
    //             msg: 'Please wait, Scanning.....',
    //             toastLength: Toast.LENGTH_LONG);
    //         log('Connected or not ${event.name}');
    //         if (event.name == 'on') {
    //           // homeController.processOneIndex.value = 4;
    //           // homeController.update();
    //
    //           flutterBluePlus
    //               .startScan(timeout: Duration(seconds: 4))
    //               .then((value) {
    //             log('Value $value');
    //             List<ScanResult> res = value;
    //             // flutterBluePlus.connectedDevices.then(
    //             //     (value) => processOneController.deviceData.value = value);
    //             // log('Devicce ${processOneController.deviceData.length.toString()}');
    //             for (var element in res) {
    //               log("id :${element.device.id}, name :${element.device.name}");
    //               log("${element.device}");
    //               processOneController.deviceData.add(element.device);
    //
    //               log(processOneController.deviceData.toString());
    //               flutterBluePlus.connectedDevices.then(
    //                   (value) => processOneController.deviceData.value = value);
    //             }
    //             flutterBluePlus.stopScan();
    //             processOneController.deviceData.value =
    //                 processOneController.deviceData.toSet().toList();
    //
    //             homeController.processOneIndex.value = 4;
    //             homeController.update();
    //           });
    //         } else {
    //           Fluttertoast.showToast(msg: 'Please on your device bluetooth');
    //         }
    //       });
    //     } else {
    //       Fluttertoast.showToast(msg: 'Please on your device location');
    //     }
    //   } else if (status.isDenied || status.isPermanentlyDenied) {
    //     Fluttertoast.showToast(msg: 'Please grant all permission');
    //     openAppSettings();
    //   }
    // }

    return Padding(
      padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppWidget.productOneDetailContainer(context: context),
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
          Divider(
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
          Divider(
            color: Colors.grey,
            thickness: 2,
            height: 1,
          ),
          Container(
            height: 14.h,
            alignment: Alignment.topCenter,
            child: SfBarcodeGenerator(
              symbology: Code128(),
              value: SharedPrefClass.getString(SharedPrefStrings.deviceId),
            ),
            // child: buildBarcode(
            //   Barcode.code128(useCode128A: false, useCode128B: false),
            //   'BARCODE\t128',
            //   // filename: 'code-128a',
            // )
            // child: Image.asset(
            //   AppImage.scanner,
            //   height: 12.h,
            //   width: MediaQuery.of(context).size.width,
            // ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Text(
                SharedPrefClass.getString(SharedPrefStrings.deviceId),
                style: AppStyle.extraSmallTextStyle,
              )),
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
          SizedBox(height: 2),
          AppWidget.richTextForProductOne(
              text1: 'Color:',
              text2: processOneController.selectedProductItem.value.color
                  .toString()),
          SizedBox(height: 2),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                  child: AppWidget.buttonWithOnlyBorder(
                      onTap: () {
                        homeController.processOneIndex.value = 4;
                        homeController.update();
                        // Get.to(() => Printers());
                        // homeController.processOneIndex.value = 0;
                        // homeController.processIndex.value = 0;
                        // homeController.isProcessSelected.value = false;
                      },
                      text: 'Abdruck')),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                  child: AppWidget.buttonStyleSmallText(
                      text: 'Drucken',
                      onTap: () {
                        homeController.processOneIndex.value = 4;
                        homeController.update();
                        // Get.to(() => Printers());
                        // homeController.processOneIndex.value = 0;
                        // homeController.processIndex.value = 0;
                        // homeController.isProcessSelected.value = false;
                      },
                      fontSize: 11.sp)),
              SizedBox(
                width: 4.w,
              ),
            ],
          ),
          smallSizedBox,
        ],
      ),
    );
  }
}

// class PrinterDetails {
//   String? printerName;
//   String? printerId;
//
//   PrinterDetails({this.printerId, this.printerName});
// }
