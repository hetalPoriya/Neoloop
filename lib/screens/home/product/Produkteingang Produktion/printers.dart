import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/controller/processOne_controller.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:neoloop/utils/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:zsdk/zsdk.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';
import 'package:network_info_plus/network_info_plus.dart';

class Printers extends StatefulWidget {
  const Printers({Key? key}) : super(key: key);

  @override
  State<Printers> createState() => _PrintersState();
}

class _PrintersState extends State<Printers> {
  //controller
  ProcessOneController processOneController = Get.put(ProcessOneController());
  HomeController homeController = Get.put(HomeController());
  final NetworkInfo _networkInfo = NetworkInfo();
  String? wifiIp = '';
  String _connectionStatus = '';
  List<PrinterAddress> address = [];
  List<PrinterAddress> searchAddress = [];
  Uint8List? capture;
  Uint8List? bytes;

  @override
  void initState() {
    _initNetworkInfo();
    processOneController.searchForIpController.value.clear();
    processOneController.update();
    getPrinterString();
    super.initState();
  }

  getPrinterString() {
    processOneController.isDamagedOrNotText.value =
        (processOneController.firstQueAns.value == 'Nein' &&
                processOneController.secondQueAns.value == 'Ja')
            ? processOneController.selectedProductItem.value.undamagedStorage
                .toString()
            : processOneController.selectedProductItem.value.damagedStorage
                .toString();

    processOneController.zplCommandDamagedOrNotFirstQue.value =
        processOneController.firstQueAns.value == 'Nein'
            ? processOneController.trueZplValueForQueOne.value
            : processOneController.falseZplValueForQueOne.value;

    processOneController.zplCommandDamagedOrNotSecQue.value =
        processOneController.secondQueAns.value == 'Ja'
            ? processOneController.trueZplValueForQueTwo.value
            : processOneController.falseZplValueForQueTwo.value;

    //27(25)
    // log('productNAme ${processOneController.selectedProductItem.value.producttypeInfo![0]!.name.toString()}');
    // log('productNAme ${processOneController.selectedProductItem.value.producttypeInfo![0]!.name.toString().length}');
    // log('productNAme ${25 > 23}');
    processOneController.productTypeNameForPrinter.value = processOneController
                .selectedProductItem.value.producttypeInfo![0]!.name
                .toString()
                .length >
            25
        ? processOneController
            .selectedProductItem.value.producttypeInfo![0]!.name
            .toString()
            .substring(0, 25)
        : processOneController
            .selectedProductItem.value.producttypeInfo![0]!.name
            .toString();
    // log('productNAme ${processOneController.productTypeNameForPrinter.value}');
    //
    // //5(4)
    // log('damagedOrNot ${processOneController.isDamagedOrNotText.value}');
    // log('damagedOrNot ${processOneController.isDamagedOrNotText.value.length}');
    processOneController.isDamagedOrNotText.value =
        processOneController.isDamagedOrNotText.value.toString().length > 6
            ? processOneController.isDamagedOrNotText.value
                .toString()
                .substring(0, 6)
            : processOneController.isDamagedOrNotText.value;
    // log('damagedOrNot ${processOneController.isDamagedOrNotText.value}');
    //
    // //30(27)
    // log('product ${processOneController.selectedProductItem.value.productName.toString()}');
    // log('product ${processOneController.selectedProductItem.value.productName.toString().length}');
    processOneController.productForPrinter.value = processOneController
                .selectedProductItem.value.productName
                .toString()
                .length >
            27
        ? processOneController.selectedProductItem.value.productName
            .toString()
            .substring(0, 27)
        : processOneController.selectedProductItem.value.productName.toString();
    // log('product ${processOneController.productForPrinter.value}');
    //
    // //32(28)
    // log('customer number ${SharedPrefClass.getString(SharedPrefStrings.customerNo)}');
    // log('customer number ${SharedPrefClass.getString(SharedPrefStrings.customerNo).length}');
    processOneController.customerNumberForPrinter.value =
        SharedPrefClass.getString(SharedPrefStrings.customerNo).length > 28
            ? SharedPrefClass.getString(SharedPrefStrings.customerNo)
                .length
                .toString()
                .substring(0, 28)
            : SharedPrefClass.getString(SharedPrefStrings.customerNo);
    // log('customer number ${processOneController.customerNumberForPrinter.value}');

    processOneController.update();

    log('Device id ${SharedPrefClass.getString(SharedPrefStrings.deviceId)}');
    log('productNAme ${processOneController.productTypeNameForPrinter.value}');
    log('damagedOrNot ${processOneController.isDamagedOrNotText.value}');
    log('product ${processOneController.productForPrinter.value}');
    log('customer number ${processOneController.customerNumberForPrinter.value}');
    log('DateTime ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}');
    // log('device Id ${SharedPrefClass.getString(SharedPrefStrings.deviceId)}');
    // log('productTypeName ${productTypeName.toString()}');
    // log('product ${product.toString()}');
    // log('damagedOrNotString ${damagedOrNotString.toString()}');
    // log('customerNumber ${customerNumber.toString()}');
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 42.h,
          padding: paddingSymmetric(horizontal: 2.w, vertical: 1.h),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Row(children: [
                  Expanded(
                      child: Padding(
                    padding: paddingSymmetric(horizontal: 3.w, vertical: 3.w),
                    child: Image.asset(
                      AppImage.ecosharkRotate,
                      fit: BoxFit.fill,
                    ),
                  )),
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding:
                            paddingSymmetric(horizontal: 1.w, vertical: 3.w),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      flex: 2,
                                      child: AppWidget.richTextForProductOne(
                                          maxLine: 2,
                                          fontSize: 11.sp,
                                          text1: 'ProduKtttype:',
                                          text2: processOneController
                                              .selectedProductItem
                                              .value
                                              .producttypeInfo![0]!
                                              .name
                                              .toString())),
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                        DateFormat('dd.MM.yyyy HH:mm')
                                            .format(DateTime.now()),
                                        style: AppStyle.smallTextStyle.copyWith(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w400,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 9.sp)),
                                  ),
                                ],
                              ),
                              smallerSizedBox,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      flex: 3,
                                      child: AppWidget.richTextForProductOne(
                                          fontSize: 11.sp,
                                          maxLine: 2,
                                          text1: 'ProduKt:',
                                          text2: processOneController
                                              .selectedProductItem
                                              .value
                                              .productName
                                              .toString())),
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                        (processOneController.firstQueAns.value == 'Nein' &&
                                                processOneController.secondQueAns.value ==
                                                    'Ja')
                                            ? processOneController
                                                .selectedProductItem
                                                .value
                                                .undamagedStorage
                                                .toString()
                                            : processOneController
                                                .selectedProductItem
                                                .value
                                                .damagedStorage
                                                .toString(),
                                        style: AppStyle.extraSmallTextStyle.copyWith(
                                            fontSize: 10.sp,
                                            color: (processOneController.firstQueAns.value ==
                                                        'Nein' &&
                                                    processOneController.secondQueAns.value == 'Ja')
                                                ? AppColor.green
                                                : Colors.red)),
                                  ),
                                ],
                              ),
                              smallerSizedBox,
                              Flexible(
                                child: AppWidget.richTextForProductOne(
                                    fontSize: 11.sp,
                                    maxLine: 1,
                                    text1: 'Gepruft durch:',
                                    text2: SharedPrefClass.getString(
                                        SharedPrefStrings.customerNo)),
                              ),
                              smallerSizedBox,
                              Flexible(
                                child: AppWidget.questionOneValue(),
                              ),
                              smallerSizedBox,
                              Flexible(
                                child: AppWidget.questionTwoValue(),
                              ),
                            ]),
                      )),
                ]),
              ),
              Flexible(
                flex: 1,
                child: SfBarcodeGenerator(
                  symbology: Code128(),
                  value: SharedPrefClass.getString(SharedPrefStrings.deviceId),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: paddingSymmetric(horizontal: 4.w, vertical: 00),
                  child: Text(
                    SharedPrefClass.getString(SharedPrefStrings.deviceId),
                    style: AppStyle.extraSmallTextStyle
                        .copyWith(fontSize: 10.sp, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
        smallerSizedBox,

        Padding(
          padding: paddingSymmetric(horizontal: 6.w, vertical: 0.0),
          child: AppWidget.searchField(
              text: 'Search your ip address',
              searchController:
                  processOneController.searchForIpController.value,
              onChanged: (v) {
                searchAddress = [];
                for (var printerDetails in address) {
                  if (printerDetails.ip.contains(v) ||
                      printerDetails.hostName.contains(v)) {
                    searchAddress.add(printerDetails);
                  }
                  setState(() {});
                }
              }),
        ),
        smallSizedBox,
        processOneController.searchForIpController.value.text.isEmpty
            ? myConnectedDevices(address: address)
            : myConnectedDevices(address: searchAddress),
        smallSizedBox,
        Padding(
          padding: paddingSymmetric(horizontal: 10.w, vertical: 00),
          child: AppWidget.buttonStyleSmallText(
              text: 'Get Connected Devices', onTap: () => scanNetwork()),
        ),
        smallSizedBox,
        // Center(child: capture != null ? Image.memory(capture!) : Container()),
      ],
    );
    // ProcessOneController processOneController = Get.put(ProcessOneController());
    // return StreamBuilder<List<BluetoothDevice>>(
    //     stream: Stream.periodic(const Duration(minutes: 3))
    //         .asyncMap((_) => FlutterBluePlus.instance.connectedDevices),
    //     initialData: const [],
    //     builder: (c, snapshot) {
    //       log('SnapShot ${snapshot.data}');
    //       return Column(
    //         children: snapshot.data!
    //             .map((d) => ListTile(
    //                   title: Text(d.name),
    //                   subtitle: Text(d.id.toString()),
    //                   trailing: StreamBuilder<BluetoothDeviceState>(
    //                     stream: d.state,
    //                     initialData: BluetoothDeviceState.disconnected,
    //                     builder: (c, snapshot) {
    //                       if (snapshot.data == BluetoothDeviceState.connected) {
    //                         return ElevatedButton(
    //                           child: const Text('OPEN'),
    //                           onPressed: () => _printData(d.id.id),
    //                         );
    //                       }
    //                       return Center(child: Text(snapshot.data.toString()));
    //                     },
    //                   ),
    //                 ))
    //             .toList(),
    //       );
    //     });
    // return Obx(
    //   () => ListView.builder(
    //       shrinkWrap: true,
    //       physics: ClampingScrollPhysics(),
    //       itemCount: processOneController.deviceData.length,
    //       itemBuilder: ((context, index) {
    //         // log('DEVISE ${processOneController.devicesList[index]['printerName']}');
    //         // log('DEVISE ${processOneController.devicesList[index]['printerId']}');
    //         return GestureDetector(
    //           onTap: () {
    //             _printData(
    //                 processOneController.deviceData[index].id.toString());
    //           },
    //           child: Padding(
    //             padding: paddingSymmetric(horizontal: 6.w, vertical: 2.h),
    //             child: Container(
    //                 height: 10.h,
    //                 padding: paddingSymmetric(horizontal: 2.w, vertical: 00),
    //                 alignment: Alignment.centerLeft,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(2.w),
    //                     color: Colors.black12),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       processOneController.deviceData[index].id.toString(),
    //                       overflow: TextOverflow.ellipsis,
    //                       maxLines: 1,
    //                       style: AppStyle.smallTextStyle
    //                           .copyWith(color: Colors.black),
    //                     ),
    //                     Text(
    //                       processOneController.deviceData[index].name
    //                               .toString()
    //                               .isNotEmpty
    //                           ? processOneController.deviceData[index].name
    //                           : 'Unknown',
    //                       overflow: TextOverflow.ellipsis,
    //                       maxLines: 1,
    //                       style: AppStyle.smallTextStyle
    //                           .copyWith(color: Colors.black),
    //                     )
    //                   ],
    //                 )),
    //           ),
    //         );
    //       })),
    // );
  }

  myConnectedDevices({required List<PrinterAddress> address}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: address.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () => _printData(id: address[index].ip.toString()),
            child: Padding(
              padding: paddingSymmetric(horizontal: 4.w, vertical: 1.w),
              child: Container(
                height: 6.h,
                margin: paddingSymmetric(horizontal: 4.w, vertical: 1.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.w),
                  color: AppColor.darkPink,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: address[index]
                                .hostName
                                .toString()
                                .split('.')
                                .first,
                            style: AppStyle.mediumTextStyle
                                .copyWith(color: Colors.white),
                            children: [
                              TextSpan(
                                  text: '(${address[index].ip.toString()})',
                                  style: AppStyle.smallTextStyle
                                      .copyWith(color: Colors.white))
                            ]),

                        // Text(address[index]['ip'].toString(),
                        //     style: AppStyle.smallTextStyle
                        //         .copyWith(color: Colors.white)),
                        // Text(address[index]['hostName'].toString(),
                        //     style: AppStyle.smallTextStyle
                        //         .copyWith(color: Colors.white))
                      )
                    ]),
              ),
            ),
          );
        }));
  }

  Future<void> _initNetworkInfo() async {
    String? wifiName,
        wifiBSSID,
        wifiIPv4,
        wifiIPv6,
        wifiGatewayIP,
        wifiBroadcast,
        wifiSubmask;

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiName = await _networkInfo.getWifiName();
        } else {
          wifiName = await _networkInfo.getWifiName();
        }
      } else {
        wifiName = await _networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      log('Failed to get Wifi Name', error: e);
      wifiName = 'Failed to get Wifi Name';
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        } else {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        }
      } else {
        wifiBSSID = await _networkInfo.getWifiBSSID();
      }
    } on PlatformException catch (e) {
      log('Failed to get Wifi BSSID', error: e);
      wifiBSSID = 'Failed to get Wifi BSSID';
    }

    try {
      wifiIPv4 = await _networkInfo.getWifiIP();
      wifiIp = await _networkInfo.getWifiIP();
      setState(() {});
    } on PlatformException catch (e) {
      log('Failed to get Wifi IPv4', error: e);
      wifiIPv4 = 'Failed to get Wifi IPv4';
    }

    try {
      if (!Platform.isWindows) {
        wifiIPv6 = await _networkInfo.getWifiIPv6();
      }
    } on PlatformException catch (e) {
      log('Failed to get Wifi IPv6', error: e);
      wifiIPv6 = 'Failed to get Wifi IPv6';
    }

    try {
      if (!Platform.isWindows) {
        wifiSubmask = await _networkInfo.getWifiSubmask();
      }
    } on PlatformException catch (e) {
      log('Failed to get Wifi submask address', error: e);
      wifiSubmask = 'Failed to get Wifi submask address';
    }

    try {
      if (!Platform.isWindows) {
        wifiBroadcast = await _networkInfo.getWifiBroadcast();
      }
    } on PlatformException catch (e) {
      log('Failed to get Wifi broadcast', error: e);
      wifiBroadcast = 'Failed to get Wifi broadcast';
    }

    try {
      if (!Platform.isWindows) {
        wifiGatewayIP = await _networkInfo.getWifiGatewayIP();
      }
    } on PlatformException catch (e) {
      log('Failed to get Wifi gateway address', error: e);
      wifiGatewayIP = 'Failed to get Wifi gateway address';
    }

    setState(() {
      _connectionStatus = 'Wifi Name: $wifiName\n'
          'Wifi BSSID: $wifiBSSID\n'
          'Wifi IPv4: $wifiIPv4\n'
          'Wifi IPv6: $wifiIPv6\n'
          'Wifi Broadcast: $wifiBroadcast\n'
          'Wifi Gateway: $wifiGatewayIP\n'
          'Wifi Submask: $wifiSubmask\n';
    });

    print('WIFI ${wifiIp.toString()}');
    const port = 80;
    final stream = NetworkAnalyzer.discover(wifiIp.toString(), port);
    stream.listen((NetworkAddress addr) {
      print('Address ${addr.toString()}');
      if (addr.exists) {
        log('Found device: ${addr.ip}');
      }
    });
  }

  Future scanNetwork() async {
    // await screenshotController
    //     .capture(delay: const Duration(milliseconds: 10), pixelRatio: 1.33)
    //     .then((Uint8List? image) async {
    //   setState(() {
    //     capture = image;
    //   });
    //   // if (image != null) {
    //   //   final directory = await getApplicationDocumentsDirectory();
    //   //   log('Path ${image}');
    //   //   log('Path ${directory.path}');
    //   //   File file = await File('${directory.path}/image.png').create();
    //   //   //final imagePath = await File('${directory.path}/image.png').create();
    //   //   file.writeAsBytesSync(image);
    //   // }
    // });

    address = [];
    await (NetworkInfo().getWifiIP()).then(
      (ip) async {
        final String subnet = ip!.substring(0, ip.lastIndexOf('.'));
        const port = 80;
        for (var i = 0; i < 256; i++) {
          String ip = '$subnet.$i';

          await Socket.connect(ip, port, timeout: Duration(milliseconds: 50))
              .then((socket) async {
            log(socket.remotePort.toString());
            log(socket.remoteAddress.toString());
            await InternetAddress(socket.address.host,
                    type: InternetAddressType.any)
                .reverse()
                .then((value) {
              log('socket ${socket}');
              log(value.host.toString());
              //address.add({'ip': value.address, 'hostName': value.host});
              address.add(PrinterAddress(
                  ip: value.address, hostName: value.host.toLowerCase()));

              log(value.address);
              setState(() {});
              return socket;
            }).catchError((error) {
              log(socket.address.address);
              log('Error: $error');
            });
            socket.destroy();
          }).catchError((error) => null);
        }
      },
    );
  }

  _printData({required String id}) async {
    final zsdk = ZSDK();
    await Socket.startConnect(id.toString(), 9100);
    print(id.toString());

    Fluttertoast.showToast(msg: 'Your Ip ${id.toString()}');

    String zplData = "^XA"
        "${processOneController.zplCommandDamagedOrNotFirstQue.value}"
        "${processOneController.zplCommandDamagedOrNotSecQue.value}"
        "^BY6,3,200^FT94,850^BCN,,Y,N"
        "^FD>:${SharedPrefClass.getString(SharedPrefStrings.deviceId)}^FS"
        "^FT130,110^A0N,52,50^FB270,1,0^FH^FDProdukttyp:^FS"
        "^FT130,200^A0N,52,50^FB215,1,0^FH^FDProdukt:^FS"
        "^FT370,110^A0N,50,45^FB570,1,0^FH^FD${processOneController.productTypeNameForPrinter.toString()}^FS"
        "^FT910,110^A0N,40,40^FB330,1,0^FH^FD${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now())}^FS"
        "^FT310,200^A0N,50,45^FB816,1,0^FH^FD${processOneController.productForPrinter.toString()}^FS"
        "^FT1070,200^A0N,50,45^FB370,1,0^FH^FD${processOneController.isDamagedOrNotText.toString()}^FS"
        "^FT130,290^A0N,52,50^FH\\^FDGepr\\81ft durch:^FS"
        "^FT420,290^A0N,50,45^FB790,1,0^FH^FD${processOneController.customerNumberForPrinter.toString()}^FS"
        "^FT230,390^A0N,52,50^FH\\^FDProdukt durch Mitarbeiter auf Besch\\84digungen^FS"
        "^FT230,450^A0N,52,50^FH\\^FDgepr\\81ft.^FS"
        "^FT230,540^A0N,52,50^FH\\^FDGer\\84t erfolgreich auf Funktion getestet und^FS"
        "^FT230,600^A0N,52,50^FB571,1,0^FH^FDabgenommen.^FS"
        "^FT100,630^A0B,90,130^FB774,1,0^FH^FDECOSHARK^FS"
        "^FO130,510^GE74,78,6^FS"
        "^FO130,370^GE74,78,6^FS"
        "^XZ";
    // //barcode not printed
    // String zplData = "^XA"
    //     "^FO140,510^GFA,00512,00512,00008,:Z64:"
    //     "eJxjYBgCQAFKJ0Aoxg8QmhlK8/+A0PJQ2h4q/v8ARPn/Bojyf1Dlf1CV1z9AUc4AVc5QB7W1BkobkOf4wQ0AZe4R2w==:0FA5"
    //     "^FO140,510^GFA,00256,00256,00004,:Z64:"
    //     "eJxjYKAxYGxgYGA+wMDA/oCBgf8DkP4B5P8Biv8DSv4H4nqgAnugAnlkBUDMCGQzPKC18wBfuA7u:FCE4"
    //     "^FO135,700^GFA,00512,00512,00008,:Z64:"
    //     "eJxjYBj6QAJK20Fp+wYIXQ/l/4NQjDD6D4Rm/gGh2T9AaH4Y/QBCyx9AMw6HsTDjcBkLNY4ZSjMcwOsZOgMAcuwTCQ==:8BFC"
    //     "^FO135,700^GFA,00512,00512,00008,:Z64:"
    //     "eJxjYBh2oAFCMR6A0MxQmv0BlP4AFf8Bpf9A1f+D6v8PpeuhBtlDDZCHGsAPNYAdlwEwuh5K20NpOSgtA6U58HqDPgAA/4AQ0g==:137D"
    //     "^BY6,3,200^FT94,1110^BCN,,Y,N"
    //     "^FD>:ES-718f179019^FS"
    //     "^FT130,130^A0N,52,50^FB270,1,0^FH^FDProdukttype:^FS"
    //     "^FT130,260^A0N,52,50^FB215,1,0^FH^FDProdukt:^FS"
    //     "^FT390,130^A0N,50,45^FB570,1,0^FH^FDInfrarot Heizungen^FS"
    //     "^FT900,130^A0N,40,40^FB330,1,0^FH^FD20-02-2023 11:46^FS"
    //     "^FT310,260^A0N,50,45^FB616,1,0^FH^FDTesting Product^FS"
    //     "^FT920,260^A0N,50,45^FB380,1,0^FH^FDdamaged-test^FS"
    //     "^FT130,390^A0N,52,50^FB312,1,0^FH^FDGerpuft durch:^FS"
    //     "^FT430,390^A0N,50,45^FB790,1,0^FH^FD10265-70-ec^FS"
    //     "^FT230,530^A0N,52,50^FB1070,1,0^FH^FDProdukt durch Mitarbeiter auf Beschandigungen^FS"
    //     "^FT230,600^A0N,52,50^FB670,1,0^FH^FDgerpruft.^FS"
    //     "^FT230,730^A0N,52,50^FB1000,1,0^FH^FDGerat erfolgerich auf Funktion getestet und^FS"
    //     "^FT230,800^A0N,52,50^FB571,1,0^FH^FDabgenommen.^FS"
    //     "^FT110,860^A0B,90,180^FB974,1,0^FH^FDECOSHARK^FS"
    //     "^FO130,700^GE74,78,6^FS"
    //     "^FO130,500^GE74,78,6^FS"
    //     "^XZ";
    //    almost
    // String zplData = "^XA"
    //     "^FO94,490^GFA,00512,00512,00008,:Z64:"
    //     "eJxjYBgCQAFKJ0Aoxg8QmhlK8/+A0PJQ2h4q/v8ARPn/Bojyf1Dlf1CV1z9AUc4AVc5QB7W1BkobkOf4wQ0AZe4R2w==:0FA5"
    //     "^FO96,490^GFA,00256,00256,00004,:Z64:"
    //     "eJxjYKAxYGxgYGA+wMDA/oCBgf8DkP4B5P8Biv8DSv4H4nqgAnugAnlkBUDMCGQzPKC18wBfuA7u:FCE4"
    //     "^FO94,645^GFA,00512,00512,00008,:Z64:"
    //     "eJxjYBj6QAJK20Fp+wYIXQ/l/4NQjDD6D4Rm/gGh2T9AaH4Y/QBCyx9AMw6HsTDjcBkLNY4ZSjMcwOsZOgMAcuwTCQ==:8BFC"
    //     "^FO96,645^GFA,00512,00512,00008,:Z64:"
    //     "eJxjYBh2oAFCMR6A0MxQmv0BlP4AFf8Bpf9A1f+D6v8PpeuhBtlDDZCHGsAPNYAdlwEwuh5K20NpOSgtA6U58HqDPgAA/4AQ0g==:137D ^BY4,3,214^FT90,1064^BCN,,Y,N"
    //     "^FD>:ES-dde85b404e^FS"
    //     "^FT98,180^A0N,32,42^FB270,1,0^FH^FDProdukttype:^FS"
    //     "^FT98,280^A0N,32,42^FB215,1,0^FH^FDProdukt:^FS"
    //     "^FT335,180^A0N,32,42^FB260,1,0^FH^FDghnvbasaaasn^FS"
    //     "^FT610,180^A0N,30,40^FB290,1,0^FH^FD22-01-22 15:20^FS"
    //     "^FT260,280^A0N,32,42^FB416,1,0^FH^FDbvnvbnsdsddfdfsdsdsd^FS"
    //     "^FT700,280^A0N,32,42^FB180,1,0^FH^FDgvfbdfdfd^FS"
    //     "^FT98,380^A0N,32,42^FB312,1,0^FH^FDGerpuft durch:^FS"
    //     "^FT380,380^A0N,32,42^FB510,1,0^FH^FDcvbsadasdasgdghhgghhgasd^FS"
    //     "^FT173,500^A0N,32,42^FB670,1,0^FH^FDProdukt durch Mitarbeiter auf^FS"
    //     "^FT173,550^A0N,32,42^FB670,1,0^FH^FDBeschandigungen gerpruft.^FS"
    //     "^FT170,670^A0N,32,42^FB971,1,0^FH^FDGerat erfolgerich auf Funktion getestet^FS"
    //     "^FT170,720^A0N,32,42^FB571,1,0^FH^FDund abgenommen.^FS"
    //     "^FT74,770^A0B,50,150^FB864,1,0^FH^FDECOSHARK^FS"
    //     "^FO98,650^GE54,58,6^FS"
    //     "^FO98,490^GE54,58,6^FS"
    //     "^XZ";

    log(zplData.toString());
    // String zplData = "^XA"
    //     "^FX Top section with logo, name and address."
    //     "^CF0,60"
    //     "^FO50,50^GB100,100,100^FS"
    //     "^FO75,75^FR^GB100,100,100^FS"
    //     "^FO93,93^GB40,40,40^FS"
    //     "^FO220,50^FDIntershipping, Inc.^FS"
    //     "^CF0,30"
    //     "^FO220,115^FD1000 Shipping Lane^FS"
    //     "^FO220,155^FDShelbyville TN 38102^FS"
    //     "^FO220,195^FDUnited States (USA)^FS"
    //     "^FO50,250^GB700,3,3^FS"
    //     "^FX Second section with recipient address and permit information."
    //     "^CFA,30"
    //     "^FO50,300^FDJohn Doe^FS"
    //     "^FO50,340^FD100 Main Street^FS"
    //     "^FO50,380^FDSpringfield TN 39021^FS"
    //     "^FO50,420^FDUnited States (USA)^FS"
    //     "^CFA,15"
    //     "^FO600,300^GB150,150,3^FS"
    //     "^FO638,340^FDPermit^FS"
    //     "^FO638,390^FD123456^FS"
    //     "^FO50,500^GB700,3,3^FS"
    //     "^FX Third section with bar code."
    //     "^BY5,2,270"
    //     "^FO100,550^BC^FD12345678^FS"
    //     "^FX Fourth section (the two boxes on the bottom)."
    //     "^FO50,900^GB700,250,3^FS"
    //     "^FO400,900^GB3,250,3^FS"
    //     "^CF0,40"
    //     "^FO100,960^FDCtr. X34B-1^FS"
    //     " ^FO100,1010^FDREF1 F00B47^FS"
    //     "^FO100,1060^FDREF2 BL4H8^FS"
    //     "^CF0,190"
    //     "^FO470,955^FDCA^FS"
    //     "^XZ";
    log(zplData);
    if (zplData == null || zplData.isEmpty) {
      Fluttertoast.showToast(msg: 'ZPL data can\'t be empty');
      throw Exception("ZPL data can't be empty");
    }
    Fluttertoast.showToast(msg: "Print job started...");

    zsdk
        .printZplDataOverTCPIP(
            data: zplData, address: id, timeout: Duration(minutes: 2))
        .then((value) {
      Fluttertoast.showToast(msg: 'print: $value');
    }, onError: (error, stacktrace) {
      try {
        throw error;
      } on PlatformException catch (e) {
        PrinterResponse printerResponse;
        try {
          printerResponse = PrinterResponse.fromMap(e.details);
          Fluttertoast.showToast(
              msg:
                  "${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause}");
        } catch (e) {
          print('ERROR $e');
          Fluttertoast.showToast(msg: 'ERROR ${e.toString()}');
        }
      } on MissingPluginException catch (e) {
        print('ERROR $e');
        Fluttertoast.showToast(msg: 'MissingPluginException ${e.toString()}');
      } catch (e) {
        print('ERROR $e');
        Fluttertoast.showToast(msg: 'ERROR ${e.toString()}');
      }
    });

    //
    // zsdk
    //     .printZplDataOverTCPIP(
    //   data: data,
    //   address: id,
    // )
    //     .then((value) {
    //   final printerResponse = PrinterResponse.fromMap(value);
    //   Status status = printerResponse.statusInfo.status;
    //   print(status);
    //   if (printerResponse.errorCode == ErrorCode.SUCCESS) {
    //     Fluttertoast.showToast(msg: value.toString());
    //     //Do something
    //   } else {
    //     Cause cause = printerResponse.statusInfo.cause;
    //     Fluttertoast.showToast(msg: cause.toString());
    //     print(cause);
    //   }
    // });
  }

// _printReceipt({required String id}) async {
//   final zsdk = ZSDK();
//   await Socket.startConnect(id.toString(), 9100);
//   print('IDD ${id}');
//   await _printData(id: id).then((zplData) async {
//     log('data ${zplData.toString()}');
//     if (zplData == null || zplData.isEmpty) {
//       Fluttertoast.showToast(msg: 'ZPL data can\'t be empty');
//       throw Exception("ZPL data can't be empty");
//     }
//     Fluttertoast.showToast(msg: "Print job started...");
//     await zsdk
//         .printZplDataOverTCPIP(
//             data: zplData, address: id, timeout: Duration(minutes: 2))
//         .then((value) {
//       Fluttertoast.showToast(msg: 'print: $value');
//       // final printerResponse = PrinterResponse.fromMap(value);
//       // Status status = printerResponse.statusInfo.status;
//       // print(status);
//       // print(value);
//       // if (printerResponse.errorCode == ErrorCode.SUCCESS) {
//       //   Fluttertoast.showToast(msg: value.toString());
//       //   //Do something
//       // } else {
//       //   Cause cause = printerResponse.statusInfo.cause;
//       //   Fluttertoast.showToast(msg: cause.toString());
//       //   print(cause);
//       // }
//     }, onError: (error, stacktrace) {
//       try {
//         throw error;
//       } on PlatformException catch (e) {
//         PrinterResponse printerResponse;
//         try {
//           printerResponse = PrinterResponse.fromMap(e.details);
//           Fluttertoast.showToast(
//               msg:
//                   "${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause}");
//         } catch (e) {
//           print('ERROR $e');
//           Fluttertoast.showToast(msg: 'ERROR ${e.toString()}');
//         }
//       } on MissingPluginException catch (e) {
//         print('ERROR $e');
//         Fluttertoast.showToast(msg: 'MissingPluginException ${e.toString()}');
//       } catch (e) {
//         print('ERROR $e');
//         Fluttertoast.showToast(msg: 'ERROR ${e.toString()}');
//       }
//     });
//   });
// }
//
// Future<String> _printData({required String id}) async {
//   damagedOrNot = (processOneController.firstQueAns.value == 'Nein' &&
//           processOneController.secondQueAns.value == 'Ja')
//       ? processOneController.selectedProductItem.value.undamagedStorage
//           .toString()
//       : processOneController.selectedProductItem.value.damagedStorage
//           .toString();
//
//   zplCommandDamagedOrNotFirstQue =
//       processOneController.firstQueAns.value == 'Nein'
//           ? processOneController.trueZplValueForQueOne.value
//           : processOneController.falseZplValueForQueOne.value;
//
//   zplCommandDamagedOrNotSecQue =
//       processOneController.secondQueAns.value == 'Ja'
//           ? processOneController.trueZplValueForQueTwo.value
//           : processOneController.falseZplValueForQueTwo.value;
//
//   //20
//   // log('productNAme ${processOneController.selectedProductItem.value.producttypeInfo![0]!.name.toString()}');
//   // log('productNAme ${processOneController.selectedProductItem.value.producttypeInfo![0]!.name.toString().length}');
//
//   String productTypeName = processOneController
//               .selectedProductItem.value.producttypeInfo![0]!.name
//               .toString()
//               .length >
//           20
//       ? processOneController
//           .selectedProductItem.value.producttypeInfo![0]!.name
//           .toString()
//           .substring(0, 20)
//       : processOneController
//           .selectedProductItem.value.producttypeInfo![0]!.name
//           .toString();
//   //log('productNAme $productTypeName');
//
//   //12
//   // log('damagedOrNot ${damagedOrNot}');
//   // log('damagedOrNot ${damagedOrNot.length}');
//   String damagedOrNotString = damagedOrNot.toString().length > 12
//       ? damagedOrNot.toString().substring(0, 12)
//       : damagedOrNot;
//   // log('damagedOrNot ${damagedOrNotString}');
//
//   //24
//   // log('product ${processOneController.selectedProductItem.value.productName.toString()}');
//   // log('product ${processOneController.selectedProductItem.value.productName.toString().length}');
//   String product = processOneController.selectedProductItem.value.productName
//               .toString()
//               .length >
//           24
//       ? processOneController.selectedProductItem.value.productName
//           .toString()
//           .substring(0, 24)
//       : processOneController.selectedProductItem.value.productName.toString();
//   //log('product ${product}');
//
//   //34
//   // log('customer number ${SharedPrefClass.getString(SharedPrefStrings.customerNo)}');
//   // log('customer number ${SharedPrefClass.getString(SharedPrefStrings.customerNo).length}');
//   String customerNumber =
//       SharedPrefClass.getString(SharedPrefStrings.customerNo).length > 34
//           ? SharedPrefClass.getString(SharedPrefStrings.customerNo)
//               .length
//               .toString()
//               .substring(0, 34)
//           : SharedPrefClass.getString(SharedPrefStrings.customerNo);
//   //log('customer number ${cuzplDatastomerNumber}');
//
//   log('FIrst ${zplCommandDamagedOrNotFirstQue}');
//   log('Sec ${zplCommandDamagedOrNotSecQue}');
//   // log('device Id ${SharedPrefClass.getString(SharedPrefStrings.deviceId)}');
//   // log('DateTime ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}');
//   // log('productTypeName ${productTypeName.toString()}');
//   // log('product ${product.toString()}');
//   // log('damagedOrNotString ${damagedOrNotString.toString()}');
//   // log('customerNumber ${customerNumber.toString()}');
//   // setState(() {});
//
//   // String zplData = "^XA"
//   //     "${zplCommandDamagedOrNotFirstQue.toString()}"
//   //     "${zplCommandDamagedOrNotSecQue.toString()}"
//   //     "^FD>:${SharedPrefClass.getString(SharedPrefStrings.deviceId)}^FS"
//   //     "^FT130,130^A0N,52,50^FB270,1,0^FH^FDProdukttype:^FS"
//   //     "^FT130,260^A0N,52,50^FB215,1,0^FH^FDProdukt:^FS"
//   //     "^FT390,130^A0N,50,45^FB570,1,0^FH^FD${productTypeName.toString()}^FS"
//   //     "^FT950,130^A0N,40,40^FB290,1,0^FH^FD${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}^FS"
//   //     "^FT310,260^A0N,50,45^FB616,1,0^FH^FD${product.toString()}^FS"
//   //     "^FT920,260^A0N,50,45^FB380,1,0^FH^FD${damagedOrNotString.toString()}^FS"
//   //     "^FT130,390^A0N,52,50^FB312,1,0^FH^FDGerpuft durch:^FS"
//   //     "^FT430,390^A0N,50,45^FB790,1,0^FH^FD${customerNumber.toString()}^FS"
//   //     "^FT230,530^A0N,52,50^FB1070,1,0^FH^FDProdukt durch Mitarbeiter auf Beschandigungen^FS"
//   //     "^FT230,600^A0N,52,50^FB670,1,0^FH^FDgerpruft.^FS"
//   //     "^FT230,730^A0N,52,50^FB1000,1,0^FH^FDGerat erfolgerich auf Funktion getestet und^FS"
//   //     "^FT230,800^A0N,52,50^FB571,1,0^FH^FDabgenommen.^FS"
//   //     "^FT110,860^A0B,90,180^FB974,1,0^FH^FDECOSHARK^FS"
//   //     "^FO130,700^GE74,78,6^FS"
//   //     "^FO130,500^GE74,78,6^FS"
//   //     "^XZ";
//
//   String zplData = "^XA"
//       "${zplCommandDamagedOrNotFirstQue.toString()}"
//       "${zplCommandDamagedOrNotSecQue.toString()}"
//       "^BY6,3,200^FT94,1110^BCN,,Y,N"
//       "^FD>:${SharedPrefClass.getString(SharedPrefStrings.deviceId)}^FS"
//       "^FT130,130^A0N,52,50^FB270,1,0^FH^FDProdukttype:^FS"
//       "^FT130,260^A0N,52,50^FB215,1,0^FH^FDProdukt:^FS"
//       "^FT390,130^A0N,50,45^FB570,1,0^FH^FD${productTypeName.toString()}^FS"
//       "^FT900,130^A0N,40,40^FB330,1,0^FH^FD${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}^FS"
//       "^FT310,260^A0N,50,45^FB616,1,0^FH^FD${product.toString()}^FS"
//       "^FT920,260^A0N,50,45^FB380,1,0^FH^FD${damagedOrNotString.toString()}^FS"
//       "^FT130,390^A0N,52,50^FB312,1,0^FH^FDGerpuft durch:^FS"
//       "^FT430,390^A0N,50,45^FB790,1,0^FH^FD${customerNumber.toString()}^FS"
//       "^FT230,530^A0N,52,50^FB1070,1,0^FH^FDProdukt durch Mitarbeiter auf Beschandigungen^FS"
//       "^FT230,600^A0N,52,50^FB670,1,0^FH^FDgerpruft.^FS"
//       "^FT230,730^A0N,52,50^FB1000,1,0^FH^FDGerat erfolgerich auf Funktion getestet und^FS"
//       "^FT230,800^A0N,52,50^FB571,1,0^FH^FDabgenommen.^FS"
//       "^FT110,860^A0B,90,180^FB974,1,0^FH^FDECOSHARK^FS"
//       "^FO130,700^GE74,78,6^FS"
//       "^FO130,500^GE74,78,6^FS"
//       "^XZ";
//
//   // ^FH^FDProdukt durch Mitarbeiter auf Beschandigungen^FS
//   // ^FT230,600^A0N,52,50^FB670,1,0^FH^FDgerpruft.^FS
//   // ^FT230 ,730^A0N,52,50^FB1000,1,0^FH^FDGerat erfolgerich auf Funktion getestet und^FS^FT230,800^A0N,52,50^FB571,1,0^FH^FDabgenommen.^FS^FT110,860^A0B,90,180^FB974,1,0^FH^FDECOSHARK^FS^FO130,700^GE74,78,6^FS^FO130,500^GE74,78,6^FS^XZ
//   //almost
//   // String zplData = "^XA"
//   //     "^FO94,490^GFA,00512,00512,00008,:Z64:"
//   //     "eJxjYBgCQAFKJ0Aoxg8QmhlK8/+A0PJQ2h4q/v8ARPn/Bojyf1Dlf1CV1z9AUc4AVc5QB7W1BkobkOf4wQ0AZe4R2w==:0FA5"
//   //     "^FO96,490^GFA,00256,00256,00004,:Z64:"
//   //     "eJxjYKAxYGxgYGA+wMDA/oCBgf8DkP4B5P8Biv8DSv4H4nqgAnugAnlkBUDMCGQzPKC18wBfuA7u:FCE4"
//   //     "^FO94,645^GFA,00512,00512,00008,:Z64:"
//   //     "eJxjYBj6QAJK20Fp+wYIXQ/l/4NQjDD6D4Rm/gGh2T9AaH4Y/QBCyx9AMw6HsTDjcBkLNY4ZSjMcwOsZOgMAcuwTCQ==:8BFC"
//   //     "^FO96,645^GFA,00512,00512,00008,:Z64:"
//   //     "eJxjYBh2oAFCMR6A0MxQmv0BlP4AFf8Bpf9A1f+D6v8PpeuhBtlDDZCHGsAPNYAdlwEwuh5K20NpOSgtA6U58HqDPgAA/4AQ0g==:137D ^BY4,3,214^FT90,1064^BCN,,Y,N"
//   //     "^FD>:ES-dde85b404e^FS"
//   //     "^FT98,180^A0N,32,42^FB270,1,0^FH^FDProdukttype:^FS"
//   //     "^FT98,280^A0N,32,42^FB215,1,0^FH^FDProdukt:^FS"
//   //     "^FT335,180^A0N,32,42^FB260,1,0^FH^FDghnvbasaaasn^FS"
//   //     "^FT610,180^A0N,30,40^FB290,1,0^FH^FD22-01-22 15:20^FS"
//   //     "^FT260,280^A0N,32,42^FB416,1,0^FH^FDbvnvbnsdsddfdfsdsdsd^FS"
//   //     "^FT700,280^A0N,32,42^FB180,1,0^FH^FDgvfbdfdfd^FS"
//   //     "^FT98,380^A0N,32,42^FB312,1,0^FH^FDGerpuft durch:^FS"
//   //     "^FT380,380^A0N,32,42^FB510,1,0^FH^FDcvbsadasdasgdghhgghhgasd^FS"
//   //     "^FT173,500^A0N,32,42^FB670,1,0^FH^FDProdukt durch Mitarbeiter auf^FS"
//   //     "^FT173,550^A0N,32,42^FB670,1,0^FH^FDBeschandigungen gerpruft.^FS"
//   //     "^FT170,670^A0N,32,42^FB971,1,0^FH^FDGerat erfolgerich auf Funktion getestet^FS"
//   //     "^FT170,720^A0N,32,42^FB571,1,0^FH^FDund abgenommen.^FS"
//   //     "^FT74,770^A0B,50,150^FB864,1,0^FH^FDECOSHARK^FS"
//   //     "^FO98,650^GE54,58,6^FS"
//   //     "^FO98,490^GE54,58,6^FS"
//   //     "^XZ";
//   // String zplData = "^XA"
//   //     "^FO64,490^GFA,00512,00512,00008,:Z64:"
//   //     "eJxjYBjyoAFCMR6A0MwPIDT7BygfSjP+gKr/g0bXQWl7GA01UB5K80MNZkc3+AGqxUMSAAA+GQ1s:6F09"
//   //     "^FO96,490^GFA,00256,00256,00004,:Z64:"
//   //     "eJxjYKAC4AFiPiCWB2J7KK4D4j8QzPiDgYH5AwSzP2Bg4D8AwfINmMprgNiCGm4iEgAAqSEL3Q==:9BD5"
//   //     "^FO64,660^GFA,00512,00512,00008,:Z64:"
//   //     "eJxjYKAYsEFpPigtj043QGj+A6g0+wMIzQyjP0BoRhj9A2rAHzS6DkrbQWl7ci2E0oxQ+ZEIAPC2D/Q=:D7AA"
//   //     "^FO64,660^GFA,00256,00256,00008,:Z64:"
//   //     "eJxjYCADKEDpAij9A0Ix/oHSUD7zBwjN/gCV5j8AoeUbUGl7qHF1UPoflMZhLLrxMGPRjYcZWw+l7aC0DIgAAM/IEh8=:CAC3"
//   //     "^BY4,3,214^FT90,1064^BCN,,Y,N"
//   //     "^FD>:ES-dde85b404e^FS"
//   //     "^FT64,790^A0B,61,170^FB826,1,0^FH\^FDECOSHARK^FS"
//   //     "^FT76,140^A0N,46,36^FB224,1,0^FH\^FDProdukttype:^FS"
//   //     "^FT270,140^A0N,46,36^FB503,1,0^FH\^FDHeateraaaaaaaaaaaaaa^FS"
//   //     "^FT620,140^A0N,40,30^FB322,1,0^FH\^FD02-02-2023 15:53^FS"
//   //     "^FT76,258^A0N,46,36^FB190,1,0^FH\^FDProdukt:^FS"
//   //     "^FT180,258^A0N,46,36^FB453,1,0,C^FH^FDTesting Proadauctaaaaaaaaa\&^FS"
//   //     "^FT648,258^A0N,46,36^FB257,1,0^FH\^FDUP -2asasasa^FS"
//   //     "^FT76,378^A0N,46,36^FB241,1,0^FH\^FDGerpuft durch:^FS"
//   //     "^FT200,378^A0N,46,36^FB774,1,0,C^FH^FDES-7b834b9cc36a666666666sasa66666\&^FS"
//   //     "^FO76,490^GE47,60,5^FS"
//   //     "^FT100,500^A0N,46,36^FB519,1,0,C^FH^FDProdukt durch Mitarbeiter auf\&^FS"
//   //     "^FT100,570^A0N,46,36^FB489,1,0,C^FH^FDBeschandigungen gerpruft.\&^FS"
//   //     "^FO76,650^GE47,60,5^FS"
//   //     "^FT136,669^A0N,46,36^FB680,1,0,C^FH^FDGerat erfolgerich auf Funktion getestet Dund\&^FS"
//   //     "^FT136,740^A0N,46,36^FB240,1,0,C^FH^FDabgenommen.\&^FS"
//   //     "^XZ";
//
//   // not printed
//   // String zplData = ;"^XA"
//   //     "${processOneController.trueZplValue.value}"
//   //     "${processOneController.falseZplValue.value}"
//   //     "^BY12,3,350^FT42,1690^BCN,,Y,N"
//   //     "^FD>:${SharedPrefClass.getString(SharedPrefStrings.deviceId)}^FS"
//   //     "^FT146,1280^A0B,140,280^FB1360,1,0^FH^FDECOSHARK^FS"
//   //     "^FT200,200^A0N,86,86^FB822,1,0^FH^FDProdukttype:^FS"
//   //     "^FT650,200^A0N,86,86^FB1295,1,0^FH^FD${processOneController.selectedProductItem.value.producttypeInfo![0]!.name.toString()}^FS"
//   //     "^FT1500,200^A0N,86,86^FB950,1,0^FH^FD${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}^FS"
//   //     "^FT200,423^A0N,86,86^FB348,1,0^FH^FDProdukt:^FS"
//   //     "^FT280,423^A0N,86,86^FB1480,1,0,C^FH^FD${processOneController.selectedProductItem.value.productName.toString()}^FS"
//   //     "^FT1580,423^A0N,86,86^FB1080,1,0^FH^FD${damagedOrNot.toString()}^FS"
//   //     "^FT200,640^A0N,86,86^FB956,1,0^FH^FDGerpuft durch:^FS"
//   //     "^FT650,640^A0N,86,86^FB1580,1,0,C^FH^FD${SharedPrefClass.getString(SharedPrefStrings.customerNo)}^FS"
//   //     "^FO200,790^GE130,130,8^FS"
//   //     "^FT247,830^A0N,86,86^FB1325,1,0,C^FH^FDProdukt durch Mitarbeiter auf^FS"
//   //     "^FT147,940^A0N,86,86^FB1430,1,0,C^FH^FDBeschandigungen gerpruft.^FS"
//   //     "^FO200,1050^GE130,130,8^FS"
//   //     "^FT247,1100^A0N,86,86^FB1625,1,0,C^FH^FDGerat erfolgerich auf Funktion getestet^FS"
//   //     "^FT147,1200^A0N,86,86^FB1200,1,0,C^FH^FDDund abgenommen.^FS"
//   //     "^XZ"
//
//   // String zplData = "^XA"
//   //     "${zplCommandDamagedOrNotFirstQue.toString()}"
//   //     "${zplCommandDamagedOrNotSecQue.toString()}"
//   //     "^BY4,3,86^FT47,534^BCN,,Y,N"
//   //     "^FD>:${SharedPrefClass.getString(SharedPrefStrings.deviceId)}^FS"
//   //     "^FT98,83^A0N,25,33^FB173,1,0^FH^FDProdukttype:^FS"
//   //     "^FT98,143^A0N,25,33^FB115,1,0^FH^FDProdukt:^FS"
//   //     "^FT284,83^A0N,25,55^FB225,1,0^FH^FD${processOneController.selectedProductItem.value.producttypeInfo![0]!.name.toString()}^FS"
//   //     "^FT524,87^A0N,25,26^FB220,1,0^FH^FD${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}^FS"
//   //     "^FT217,143^A0N,25,43^FB276,1,0^FH^FD${processOneController.selectedProductItem.value.productName.toString()}^FS"
//   //     "^FT602,143^A0N,25,55^FB142,1,0^FH^FD${damagedOrNot.toString()}^FS"
//   //     "^FT98,208^A0N,27,28^FB182,1,0^FH^FDGerpuft durch:^FS"
//   //     "^FT284,208^A0N,27,43^FB292,1,0^FH^FD${SharedPrefClass.getString(SharedPrefStrings.customerNo)}^FS"
//   //     "^FT173,282^A0N,21,38^FB470,1,0^FH^FDProdukt durch Mitarbeiter auf^FS"
//   //     "^FT173,308^A0N,21,38^FB470,1,0^FH^FDBeschandigungen gerpruft.^FS"
//   //     "^FT170,384^A0N,21,36^FB571,1,0^FH^FDGerat erfolgerich auf Funktion getestet^FS"
//   //     "^FT170,410^A0N,21,36^FB571,1,0^FH^FDund abgenommen.^FS"
//   //     "^FT74,426^A0B,50,84^FB464,1,0^FH^FDECOSHARK^FS"
//   //     "^FO98,255^GE54,58,6^FS"
//   //     "^FO98,359^GE54,58,6^FS"
//   //     "^XZ";
//
//   //
//   // if (await File('${directory.path}/image.pdf').exists()) {
//   //   log("File exists");
//   //   Fluttertoast.showToast(msg: "Print job started...");
//   //   zsdk
//   //       .printZplFileOverTCPIP(
//   //           filePath: '${directory.path}/image.pdf',
//   //           address: id,
//   //           timeout: Duration(minutes: 2))
//   //       .then((value) {
//   //     // Fluttertoast.showToast(msg: 'print: $value');
//   //     homeController.isProcessSelected.value = false;
//   //     homeController.bottomIndex.value = 0;
//   //     homeController.update();
//   //   }, onError: (error, stacktrace) {
//   //     try {
//   //       throw error;
//   //     } on PlatformException catch (e) {
//   //       PrinterResponse printerResponse;
//   //       try {
//   //         printerResponse = PrinterResponse.fromMap(e.details);
//   //         Fluttertoast.showToast(
//   //             msg:
//   //                 "${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause}");
//   //       } catch (e) {
//   //         log('ERROR $e');
//   //         Fluttertoast.showToast(msg: 'ERROR ${e.toString()}');
//   //       }
//   //     } on MissingPluginException catch (e) {
//   //       log('ERROR $e');
//   //       Fluttertoast.showToast(msg: 'MissingPluginException ${e.toString()}');
//   //     } catch (e) {
//   //       log('ERROR $e');
//   //       Fluttertoast.showToast(msg: 'ERROR ${e.toString()}');
//   //     }
//   //   });
//   // } else {
//   //   log("File don't exists");
//   //   Fluttertoast.showToast(msg: "File not found");
//   // }
//   //
//   // if (zplData == null || zplData.isEmpty) {
//   //   Fluttertoast.showToast(msg: 'ZPL data can\'t be empty');
//   //   throw Exception("ZPL data can't be empty");
//   // }
//   log('IDD ${id}');
//   log('zplData ${zplData}');
//
//   return zplData;
// }

// _printData(String id) async {
//   final zsdk = ZSDK();
//   log("Searching BL devices");
//   log(id);
//
//   Fluttertoast.showToast(msg: id.toString());
//   String zplData = "^XA"
//       "    ^FX Top section with logo, name and address."
//       "    ^CF0,60"
//       "    ^FO50,50^GB100,100,100^FS"
//       "    ^FO75,75^FR^GB100,100,100^FS"
//       "    ^FO93,93^GB40,40,40^FS"
//       "    ^FO220,50^FDIntershipping, Inc.^FS"
//       "    ^CF0,30"
//       "    ^FO220,115^FD1000 Shipping Lane^FS"
//       "   ^FO220,155^FDShelbyville TN 38102^FS"
//       "^FO220,195^FDUnited States (USA)^FS"
//       " ^FO50,250^GB700,3,3^FS"
//       "    ^FX Second section with recipient address and permit information."
//       "    ^CFA,30"
//       "    ^FO50,300^FDJohn Doe^FS"
//       "    ^FO50,340^FD100 Main Street^FS"
//       "    ^FO50,380^FDSpringfield TN 39021^FS"
//       "  ^FO50,420^FDUnited States (USA)^FS"
//       "    ^CFA,15"
//       " ^FO600,300^GB150,150,3^FS"
//       "   ^FO638,340^FDPermit^FS"
//       "    ^FO638,390^FD123456^FS"
//       "   ^FO50,500^GB700,3,3^FS"
//       " ^FX Third section with bar code."
//       "   ^BY5,2,270"
//       " ^FO100,550^BC^FD12345678^FS"
//       "  ^FX Fourth section (the two boxes on the bottom)."
//       " ^FO50,900^GB700,250,3^FS"
//       " ^FO400,900^GB3,250,3^FS"
//       "^CF0,40"
//       "^FO100,960^FDCtr. X34B-1^FS"
//       " ^FO100,1010^FDREF1 F00B47^FS"
//       "^FO100,1060^FDREF2 BL4H8^FS"
//       " ^CF0,190"
//       "  ^FO470,955^FDCA^FS"
//       "^XZ";
//
//   if (zplData == null || zplData.isEmpty) {
//     Fluttertoast.showToast(msg: 'ZPL data can\'t be empty');
//     throw Exception("ZPL data can't be empty");
//   }
//   Fluttertoast.showToast(msg: "Print job started...");
//
//   zsdk
//       .printZplDataOverTCPIP(
//     data: zplData,
//     address: id,
//     port: int.tryParse(id),
//   )
//       .then((value) {
//     Fluttertoast.showToast(msg: 'print: $value');
//   }, onError: (error, stacktrace) {
//     try {
//       throw error;
//     } on PlatformException catch (e) {
//       Printer.PrinterResponse printerResponse;
//       try {
//         printerResponse = Printer.PrinterResponse.fromMap(e.details);
//         Fluttertoast.showToast(
//             msg:
//                 "${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause}");
//       } catch (e) {
//         print(e);
//         Fluttertoast.showToast(msg: 'ERROR ${e.toString()}');
//       }
//     } on MissingPluginException catch (e) {
//       Fluttertoast.showToast(msg: 'MissingPluginException ${e.toString()}');
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'ERROR ${e.toString()}');
//     }
//   });
//
//   //
//   // zsdk
//   //     .printZplDataOverTCPIP(
//   //   data: data,
//   //   address: id,
//   // )
//   //     .then((value) {
//   //   final printerResponse = PrinterResponse.fromMap(value);
//   //   Status status = printerResponse.statusInfo.status;
//   //   print(status);
//   //   if (printerResponse.errorCode == ErrorCode.SUCCESS) {
//   //     Fluttertoast.showToast(msg: value.toString());
//   //     //Do something
//   //   } else {
//   //     Cause cause = printerResponse.statusInfo.cause;
//   //     Fluttertoast.showToast(msg: cause.toString());
//   //     print(cause);
//   //   }
//   // });
// }
}

class PrinterResponse {
  ErrorCode errorCode;
  StatusInfo statusInfo;
  PrinterSettings? settings;
  String? message;

  PrinterResponse(
      {ErrorCode? errorCode,
      StatusInfo? statusInfo,
      this.settings,
      this.message})
      : errorCode = errorCode ?? ErrorCode.UNKNOWN,
        statusInfo = statusInfo ?? StatusInfo(Status.UNKNOWN, Cause.UNKNOWN);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'errorCode': errorCode.name,
        'statusInfo': statusInfo.toMap(),
        'settings': settings?.toMap(),
        'message': message,
      };

  factory PrinterResponse.fromMap(Map<dynamic, dynamic> map) => PrinterResponse(
        errorCode: ErrorCodeUtils.valueOf(map['errorCode']),
        statusInfo: map['statusInfo'] == null
            ? null
            : StatusInfo.fromMap(map['statusInfo']),
        settings: map['settings'] == null
            ? null
            : PrinterSettings.fromMap(map['settings']),
        message: map['message'],
      );
}

class PrinterAddress {
  String ip;
  String hostName;

  PrinterAddress({required this.ip, required this.hostName});
}

// import 'dart:async';
// import 'dart:io';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
//
// class Printers extends StatelessWidget {
//   const Printers({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<BluetoothState>(
//         stream: FlutterBluePlus.instance.state,
//         initialData: BluetoothState.unknown,
//         builder: (c, snapshot) {
//           final state = snapshot.data;
//           if (state == BluetoothState.on) {
//             return const FindDevicesScreen();
//           }
//           return BluetoothOffScreen(state: state);
//         });
//   }
// }
//
// class BluetoothOffScreen extends StatelessWidget {
//   const BluetoothOffScreen({Key? key, this.state}) : super(key: key);
//
//   final BluetoothState? state;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue,
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Icon(
//               Icons.bluetooth_disabled,
//               size: 200.0,
//               color: Colors.white54,
//             ),
//             Text(
//               'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
//               style: Theme.of(context)
//                   .primaryTextTheme
//                   .subtitle2
//                   ?.copyWith(color: Colors.white),
//             ),
//             ElevatedButton(
//               child: const Text('TURN ON'),
//               onPressed: Platform.isAndroid
//                   ? () => FlutterBluePlus.instance.turnOn()
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class FindDevicesScreen extends StatelessWidget {
//   const FindDevicesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Find Devices'),
//         actions: [
//           ElevatedButton(
//             child: const Text('TURN OFF'),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.black,
//               onPrimary: Colors.white,
//             ),
//             onPressed: Platform.isAndroid
//                 ? () => FlutterBluePlus.instance.turnOff()
//                 : null,
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () => FlutterBluePlus.instance
//             .startScan(timeout: const Duration(seconds: 4)),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               StreamBuilder<List<BluetoothDevice>>(
//                 stream: Stream.periodic(const Duration(seconds: 2))
//                     .asyncMap((_) => FlutterBluePlus.instance.connectedDevices),
//                 initialData: const [],
//                 builder: (c, snapshot) => Column(
//                   children: snapshot.data!
//                       .map((d) => ListTile(
//                             title: Text(d.name),
//                             subtitle: Text(d.id.toString()),
//                             trailing: StreamBuilder<BluetoothDeviceState>(
//                               stream: d.state,
//                               initialData: BluetoothDeviceState.disconnected,
//                               builder: (c, snapshot) {
//                                 if (snapshot.data ==
//                                     BluetoothDeviceState.connected) {
//                                   return ElevatedButton(
//                                     child: const Text('OPEN'),
//                                     onPressed: () => Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 DeviceScreen(device: d))),
//                                   );
//                                 }
//                                 return Text(snapshot.data.toString());
//                               },
//                             ),
//                           ))
//                       .toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: StreamBuilder<bool>(
//         stream: FlutterBluePlus.instance.isScanning,
//         initialData: false,
//         builder: (c, snapshot) {
//           if (snapshot.data!) {
//             return FloatingActionButton(
//               child: const Icon(Icons.stop),
//               onPressed: () => FlutterBluePlus.instance.stopScan(),
//               backgroundColor: Colors.red,
//             );
//           } else {
//             return FloatingActionButton(
//                 child: const Icon(Icons.search),
//                 onPressed: () => FlutterBluePlus.instance
//                     .startScan(timeout: const Duration(seconds: 4)));
//           }
//         },
//       ),
//     );
//   }
// }
//
// class DeviceScreen extends StatelessWidget {
//   const DeviceScreen({Key? key, required this.device}) : super(key: key);
//
//   final BluetoothDevice device;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(device.name),
//         actions: <Widget>[
//           StreamBuilder<BluetoothDeviceState>(
//             stream: device.state,
//             initialData: BluetoothDeviceState.connecting,
//             builder: (c, snapshot) {
//               VoidCallback? onPressed;
//               String text;
//               switch (snapshot.data) {
//                 case BluetoothDeviceState.connected:
//                   onPressed = () => device.disconnect();
//                   text = 'DISCONNECT';
//                   break;
//                 case BluetoothDeviceState.disconnected:
//                   onPressed = () => device.connect();
//                   text = 'CONNECT';
//                   break;
//                 default:
//                   onPressed = null;
//                   text = snapshot.data.toString().substring(21).toUpperCase();
//                   break;
//               }
//               return TextButton(
//                   onPressed: onPressed,
//                   child: Text(
//                     text,
//                     style: Theme.of(context)
//                         .primaryTextTheme
//                         .button
//                         ?.copyWith(color: Colors.white),
//                   ));
//             },
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             StreamBuilder<BluetoothDeviceState>(
//               stream: device.state,
//               initialData: BluetoothDeviceState.connecting,
//               builder: (c, snapshot) => ListTile(
//                 leading: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     snapshot.data == BluetoothDeviceState.connected
//                         ? const Icon(Icons.bluetooth_connected)
//                         : const Icon(Icons.bluetooth_disabled),
//                     snapshot.data == BluetoothDeviceState.connected
//                         ? StreamBuilder<int>(
//                             stream: rssiStream(),
//                             builder: (context, snapshot) {
//                               return Text(
//                                   snapshot.hasData ? '${snapshot.data}dBm' : '',
//                                   style: Theme.of(context).textTheme.caption);
//                             })
//                         : Text('', style: Theme.of(context).textTheme.caption),
//                   ],
//                 ),
//                 title: Text(
//                     'Device is ${snapshot.data.toString().split('.')[1]}.'),
//                 subtitle: Text('${device.id}'),
//                 trailing: StreamBuilder<bool>(
//                   stream: device.isDiscoveringServices,
//                   initialData: false,
//                   builder: (c, snapshot) => IndexedStack(
//                     index: snapshot.data! ? 1 : 0,
//                     children: <Widget>[
//                       IconButton(
//                         icon: const Icon(Icons.refresh),
//                         onPressed: () => device.discoverServices(),
//                       ),
//                       const IconButton(
//                         icon: SizedBox(
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation(Colors.grey),
//                           ),
//                           width: 18.0,
//                           height: 18.0,
//                         ),
//                         onPressed: null,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             StreamBuilder<int>(
//               stream: device.mtu,
//               initialData: 0,
//               builder: (c, snapshot) => ListTile(
//                 title: const Text('MTU Size'),
//                 subtitle: Text('${snapshot.data} bytes'),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () => device.requestMtu(223),
//                 ),
//               ),
//             ),
//             StreamBuilder<List<BluetoothService>>(
//               stream: device.services,
//               initialData: const [],
//               builder: (c, snapshot) {
//                 return Column(
//                   children: [Text(snapshot.data!.toString())],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Stream<int> rssiStream() async* {
//     var isConnected = true;
//     final subscription = device.state.listen((state) {
//       isConnected = state == BluetoothDeviceState.connected;
//     });
//     while (isConnected) {
//       yield await device.readRssi();
//       await Future.delayed(const Duration(seconds: 1));
//     }
//     subscription.cancel();
//     // Device disconnected, stopping RSSI stream
//   }
// }
