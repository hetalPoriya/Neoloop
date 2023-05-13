import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/controller/processTwo_controller.dart';
import 'package:neoloop/model/processTwo/undelivered_orders.dart';
import 'package:neoloop/screens/home/product/Produktausgang%20Kunden/produktausgang_kunden.dart';
import 'package:neoloop/screens/home/product/Produktausgang%20Kunden/produktausgang_kunden_package_details.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/utils.dart';

class ProduktausgangKundenExitCustomers extends StatefulWidget {
  const ProduktausgangKundenExitCustomers({Key? key}) : super(key: key);

  @override
  State<ProduktausgangKundenExitCustomers> createState() =>
      _ProduktausgangKundenExitCustomersState();
}

class _ProduktausgangKundenExitCustomersState
    extends State<ProduktausgangKundenExitCustomers> {
  //Controller
  HomeController homeController = Get.put(HomeController());
  ProcessTwoController processTwoController = Get.put(ProcessTwoController());
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();
    if (isConnected) {
      await processTwoController.getUndeliveredOrderApiCall();
      processTwoController.update();
    } else {
      AppWidget.showShackBar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.processTwoIndex.value == 0
            ? Column(
                children: [
                  Padding(
                    padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
                    child: AppWidget.productContainer(
                        imageString: AppImage.processTwo,
                        name: 'Produktausgang \nKunden'),
                  ),
                  smallSizedBox,
                  AppWidget.orderListContainer(
                      context: context, text: AppStrings.bestelldetails),
                  mediumSizedBox,
                  processTwoController.isLoading.value == true
                      ? AppWidget.progressIndicator()
                      : processTwoController
                                  .undeliveredOrdersList.value.response ==
                              null
                          ? Center(
                              child: Text(
                                'No product found',
                                style: AppStyle.smallTextStyle,
                              ),
                            )
                          : ListView.builder(
                              itemCount: processTwoController
                                  .undeliveredOrdersList.value.response!.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: ((context, index) {
                                var status = processTwoController
                                    .undeliveredOrdersList
                                    .value
                                    .response![index];
                                String orderStatus =
                                    status.orderStatus == 'Placed'
                                        ? 'Bestellung platziert'
                                        : status.orderStatus == 'Process '
                                            ? 'Bestellung wird bearbeitet'
                                            : status.orderStatus ==
                                                    'Ready to dispatch'
                                                ? 'Versandfertig'
                                                : status.orderStatus ==
                                                        'Dispatched '
                                                    ? 'Bestellung versendet'
                                                    : status.orderStatus ==
                                                            'Delivered'
                                                        ? 'Bestellung geliefert'
                                                        : 'Retoure erhalten';
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        homeController.processTwoIndex.value =
                                            1;
                                        homeController.update();
                                        processTwoController
                                                .selectedOrderNo.value =
                                            processTwoController
                                                .undeliveredOrdersList
                                                .value
                                                .response![index]
                                                .id
                                                .toString();

                                        await processTwoController
                                            .getAllOrderApiCall();
                                        processTwoController.update();
                                      },
                                      child: Container(
                                        height: 13.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: AppColor
                                                        .extraDarkPink
                                                        .withOpacity(0.1),
                                                    width: 2.w))),
                                        child: Padding(
                                          padding: paddingSymmetric(
                                              horizontal: 6.w, vertical: 00),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    AppWidget.richTextForProductOne(
                                                        fontSize: 11.sp,
                                                        text1: AppStrings
                                                            .orderNumber,
                                                        text2: processTwoController
                                                            .undeliveredOrdersList
                                                            .value
                                                            .response![index]
                                                            .orderNo
                                                            .toString()),
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      color: AppColor.darkPink,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 1.w),
                                                Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                            child: Container(
                                                          color: AppColor
                                                              .extraLightPink,
                                                          child: Row(
                                                            children: [
                                                              AppWidget.productTwoTitleText(
                                                                  text: AppStrings
                                                                      .orderDate),
                                                              AppWidget.productTwoTitleText(
                                                                  text: AppStrings
                                                                      .orderTotal),
                                                              AppWidget.productTwoTitleText(
                                                                  text: AppStrings
                                                                      .orderStatus),
                                                            ],
                                                          ),
                                                        )),
                                                        Expanded(
                                                            child: Container(
                                                          color: Colors.white,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              AppWidget.productTwoSubText(
                                                                  text: DateFormat('dd.MM.yyyy').format(processTwoController
                                                                      .undeliveredOrdersList
                                                                      .value
                                                                      .response![
                                                                          index]
                                                                      .orderStatusDates![
                                                                          0]
                                                                      .placed!)),
                                                              AppWidget
                                                                  .productTwoSubText(
                                                                      text:
                                                                          '€${processTwoController.undeliveredOrdersList.value.response![index].totalAmount.toString()}'),
                                                              AppWidget
                                                                  .productTwoSubText(
                                                                      text:
                                                                          orderStatus),
                                                            ],
                                                          ),
                                                        )),
                                                      ],
                                                    )),
                                              ]),
                                        ),
                                      ),
                                    ),
                                    smallSizedBox,
                                  ],
                                );
                              }))
                ],
              )
            : homeController.processTwoIndex.value == 1
                ? ProduktausgangKundenOrderDetails()
                : ProduktausgangKundenPackageDetails()
        //: ProduktausgangKundenShippingDetails(),
        );
  }
}
