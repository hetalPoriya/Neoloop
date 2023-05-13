import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/controller/processTwo_controller.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:neoloop/utils/utils.dart';
import 'package:sizer/sizer.dart';

class ProduktausgangKundenShippingDetails extends StatelessWidget {
  ProduktausgangKundenShippingDetails({Key? key}) : super(key: key);

  ProcessTwoController processTwoController = Get.put(ProcessTwoController());
  List questions = [
    {
      "id": 0,
      "value": true,
      "title": "All goods are packed",
    },
    {
      "id": 1,
      "value": true,
      "title": "Shipping labels are printed",
    },
  ];

  //controller
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
            child: Container(
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
                      aboveWidget(
                          title: 'Kunde:',
                          text:
                              '${processTwoController.customerInfo.value.firstname.toString()} ${processTwoController.customerInfo.value.lastname}'),
                      aboveWidget(
                          title: 'Bestellnummer:',
                          text: processTwoController.orderDetails.value.orderNo
                              .toString()),
                      aboveWidget(
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
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 15.h
                          : 20.h,
                      width: MediaQuery.of(context).size.width * .90,
                      child: FadeInImage(
                        image: AssetImage(
                          AppImage.blur,
                        ),
                        placeholder: AssetImage(AppImage.blur),
                      ),
                    )),
              ]),
            )),
        smallSizedBox,
        AppWidget.orderListContainer(
            context: context, text: 'Shipping details'),
        mediumSizedBox,
        //AppWidget.productTwoShippingAndOrderContainer(onTap: () {}),
        Container(
          height: 12.h,
          child: Row(children: [
            Expanded(
                child: Padding(
              padding: paddingSymmetric(horizontal: 3.w, vertical: 00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'TRACKING',
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.extraSmallTextStyle.copyWith(
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp),
                  ),
                  Text(
                    'EC 976 456 789 NE 45-02',
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.extraSmallTextStyle
                        .copyWith(color: AppColor.black, fontSize: 8.sp),
                  )
                ],
              ),
            )),
            Expanded(
                child: Padding(
              padding: paddingSymmetric(horizontal: 3.w, vertical: 00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'EC 245 87-02',
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.mediumTextStyle.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.black),
                  ),
                  Container(
                    height: 7.h,
                    child: Image.asset(
                      AppImage.scanner,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ))
          ]),
        ),
        smallerSizedBox,
        Padding(
          padding: paddingSymmetric(horizontal: 12.w, vertical: 00),
          child: AppWidget.buttonStyleSmallText(
              text: 'Print', onTap: () => _showFirstDialog(context: context)),
        ),
        smallSizedBox,
      ],
    );
  }

  _showFirstDialog({required BuildContext context}) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            scrollable: true,
            elevation: 2.w,
            clipBehavior: Clip.hardEdge,
            content: Column(
              // shrinkWrap: true,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: paddingSymmetric(horizontal: 2.w, vertical: 00),
                  height: 5.h,
                  color: AppColor.extraLightPink,
                  child: Text('Shipping print',
                      style: AppStyle.mediumTextStyle.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w700)),
                ),
                smallSizedBox,
                Container(
                  height: 18.h,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),
                  child: Column(children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.zero,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: _dialogText(
                                    text1: 'Order no', text2: 'N59643422')),
                            _divider(),
                            Flexible(
                                child: Center(
                              child: Image.asset(
                                AppImage.blur,
                                height: 8.h,
                                width: 15.w,
                                fit: BoxFit.fill,
                              ),
                            ))
                          ]),
                    )),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                      height: 0,
                    ),
                    Expanded(
                        child: Container(
                      child: Row(children: [
                        Expanded(
                            child: _dialogText(text1: 'Qty', text2: '1'),
                            flex: 2),
                        _divider(),
                        Expanded(
                          child:
                              _dialogText(text1: 'Net Weight', text2: '65Kg'),
                          flex: 3,
                        ),
                        _divider(),
                        Expanded(
                          child: _dialogText(
                              text1: 'Packed on', text2: '02/12/22'),
                          flex: 4,
                        ),
                      ]),
                    )),
                  ]),
                ),
                smallSizedBox,
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),
                  child: Padding(
                    padding: paddingSymmetric(horizontal: 2.w, vertical: 00),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppImage.scanner,
                            height: 8.h,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding:
                                paddingSymmetric(horizontal: 3.w, vertical: 00),
                            child: Text(
                              'EC 245 87-02',
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle.extraSmallTextStyle.copyWith(
                                  color: Colors.black,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ]),
                  ),
                ),
                mediumSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: 4.w,
                    ),
                    Expanded(
                      child: AppWidget.buttonWithOnlyBorder(
                          onTap: () => Get.back(),
                          text: 'Cancel',
                          textStyle: AppStyle.smallTextStyle.copyWith(
                              fontSize: 10.sp, color: AppColor.black)),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Expanded(
                        child: AppWidget.buttonStyleSmallText(
                            text: 'Print',
                            onTap: () {
                              Get.back();
                              _showSecondDialog(context);
                            },
                            fontSize: 10.sp)),
                    SizedBox(
                      width: 4.w,
                    ),
                  ],
                ),
                smallerSizedBox,
              ],
            ),
          );
        }));
    // return Get.defaultDialog(
    //     titlePadding: paddingSymmetric(horizontal: 2.w, vertical: 00),
    //     title: '',
    //     content: Container(
    //       width: MediaQuery.of(context).size.width * .80,
    //       height: MediaQuery.of(context).size.height * .55,
    //       alignment: Alignment.center,
    //       child: Padding(
    //           padding: paddingSymmetric(horizontal: 4.w, vertical: 00),
    //           child: OrientationBuilder(
    //             builder: ((context, orientation) {
    //               return ListView(
    //                 shrinkWrap: true,
    //                 children: [
    //                   Container(
    //                     width: MediaQuery.of(context).size.width,
    //                     alignment: Alignment.centerLeft,
    //                     padding:
    //                         paddingSymmetric(horizontal: 2.w, vertical: 00),
    //                     height: 5.h,
    //                     color: AppColor.extraLightPink,
    //                     child: Text('Shipping print',
    //                         style: AppStyle.mediumTextStyle.copyWith(
    //                             color: Colors.black,
    //                             fontWeight: FontWeight.w700)),
    //                   ),
    //                   smallSizedBox,
    //                   Container(
    //                     height: 18.h,
    //                     decoration: BoxDecoration(
    //                         border: Border.all(
    //                             color: Colors.grey.shade300, width: 1)),
    //                     child: Column(children: [
    //                       Expanded(
    //                           child: Container(
    //                         padding: EdgeInsets.zero,
    //                         child: Row(
    //                             crossAxisAlignment: CrossAxisAlignment.center,
    //                             children: [
    //                               Expanded(
    //                                   flex: 2,
    //                                   child: _dialogText(
    //                                       text1: 'Order no',
    //                                       text2: 'N59643422')),
    //                               _divider(),
    //                               Flexible(
    //                                   child: Center(
    //                                 child: Image.asset(
    //                                   AppImage.blur,
    //                                   height: 8.h,
    //                                   width: 15.w,
    //                                   fit: BoxFit.fill,
    //                                 ),
    //                               ))
    //                             ]),
    //                       )),
    //                       Divider(
    //                         color: Colors.grey.shade300,
    //                         thickness: 1,
    //                         height: 0,
    //                       ),
    //                       Expanded(
    //                           child: Container(
    //                         child: Row(children: [
    //                           Expanded(
    //                               child: _dialogText(text1: 'Qty', text2: '1'),
    //                               flex: 2),
    //                           _divider(),
    //                           Expanded(
    //                             child: _dialogText(
    //                                 text1: 'Net Weight', text2: '65Kg'),
    //                             flex: 3,
    //                           ),
    //                           _divider(),
    //                           Expanded(
    //                             child: _dialogText(
    //                                 text1: 'Packed on', text2: '02/12/22'),
    //                             flex: 4,
    //                           ),
    //                         ]),
    //                       )),
    //                     ]),
    //                   ),
    //                   smallSizedBox,
    //                   Container(
    //                     height: 15.h,
    //                     decoration: BoxDecoration(
    //                         border: Border.all(
    //                             color: Colors.grey.shade300, width: 1)),
    //                     child: Padding(
    //                       padding:
    //                           paddingSymmetric(horizontal: 2.w, vertical: 00),
    //                       child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Image.asset(
    //                               AppImage.scanner,
    //                               height: 8.h,
    //                               fit: BoxFit.fill,
    //                             ),
    //                             Padding(
    //                               padding: paddingSymmetric(
    //                                   horizontal: 3.w, vertical: 00),
    //                               child: Text(
    //                                 'EC 245 87-02',
    //                                 overflow: TextOverflow.ellipsis,
    //                                 style: AppStyle.extraSmallTextStyle
    //                                     .copyWith(
    //                                         color: Colors.black,
    //                                         fontSize: 9.sp,
    //                                         fontWeight: FontWeight.w500),
    //                               ),
    //                             )
    //                           ]),
    //                     ),
    //                   ),
    //                   mediumSizedBox,
    //                   Row(
    //                     children: [
    //                       SizedBox(
    //                         width: 4.w,
    //                       ),
    //                       Expanded(
    //                         child: AppWidget.buttonWithOnlyBorder(
    //                             onTap: () => Get.back(),
    //                             text: 'Cancel',
    //                             textStyle: AppStyle.smallTextStyle.copyWith(
    //                                 fontSize: 10.sp, color: AppColor.black)),
    //                       ),
    //                       SizedBox(
    //                         width: 4.w,
    //                       ),
    //                       Expanded(
    //                           child: AppWidget.buttonStyleSmallText(
    //                               text: 'Print',
    //                               onTap: () {
    //                                 Get.back();
    //                                 _showSecondDialog(context);
    //                               },
    //                               fontSize: 10.sp)),
    //                       SizedBox(
    //                         width: 4.w,
    //                       ),
    //                     ],
    //                   ),
    //                   smallerSizedBox,
    //                 ],
    //               );
    //             }),
    //           )),
    //     ));
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

  _questionsCheckBox({required List questions}) {
    return Container(
      height: 8.h,
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            2,
            (index) => Container(
              height: 3.h,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: AppColor.green,
                      side: BorderSide(
                          color: questions[index]["value"] == true
                              ? AppColor.extraLightPink
                              : Colors.grey,
                          width: 1.5),
                      activeColor: AppColor.extraLightPink,
                      value: questions[index]["value"],
                      onChanged: (value) {
                        for (var element in questions) {
                          element["value"] = false;
                        }
                        questions[index]["value"] = value;
                      },
                    ),
                    Text(
                      questions[index]["title"],
                      overflow: TextOverflow.ellipsis,
                      style:
                          AppStyle.smallTextStyle.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  _dialogText({required String text1, required String text2}) => Padding(
        padding: paddingSymmetric(horizontal: 2.w, vertical: 00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text1,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppStyle.extraSmallTextStyle
                  .copyWith(fontSize: 9.sp, color: Colors.black),
            ),
            Text(
              text2,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppStyle.smallTextStyle
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
            )
          ],
        ),
      );

  _divider() => VerticalDivider(
        color: Colors.grey.shade300,
        thickness: 1,
      );

  _showSecondDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
              scrollable: true,
              elevation: 2.w,
              clipBehavior: Clip.hardEdge,
              content: Column(
                children: [
                  _questionsCheckBox(questions: questions),
                  smallSizedBox,
                  Divider(
                    thickness: 8,
                    height: 0,
                    color: AppColor.extraDarkPink.withOpacity(0.2),
                  ),
                  Padding(
                    padding: paddingSymmetric(horizontal: 2.w, vertical: 00),
                    child: Container(height: 3.h, color: Colors.grey.shade200),
                  ),
                  smallSizedBox,
                  Container(
                    height: 12.h,
                    child: Row(children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .45,
                        child: Text(
                          'Upload the package image',
                          style: AppStyle.mediumTextStyle
                              .copyWith(color: AppColor.extraDarkPink),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        //  width: MediaQuery.of(context).size.width * .30,
                        child: AppWidget.addPictureContainer(
                            onTap: () {}, text: 'Package', context: context),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                    ]),
                  ),
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
                                Get.back();
                              },
                              text: 'Cancel')),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                          child: AppWidget.buttonStyleSmallText(
                              text: 'Ware versandt',
                              onTap: () {
                                Get.back();
                                homeController.processTwoIndex.value = 0;
                                homeController.processIndex.value = 0;
                                homeController.isProcessSelected.value = false;
                                homeController.update();
                              },
                              fontSize: 11.sp)),
                      SizedBox(
                        width: 4.w,
                      ),
                    ],
                  ),
                  smallSizedBox
                ],
              ));
        }));
    // return Get.defaultDialog(
    //     content: Column(
    //   children: [
    //     _questionsCheckBox(questions: questions),
    //     smallSizedBox,
    //     Divider(
    //       thickness: 8,
    //       height: 0,
    //       color: AppColor.extraDarkPink.withOpacity(0.2),
    //     ),
    //     Padding(
    //       padding: paddingSymmetric(horizontal: 2.w, vertical: 00),
    //       child: Container(height: 3.h, color: Colors.grey.shade200),
    //     ),
    //     smallSizedBox,
    //     Container(
    //       height: 12.h,
    //       child: Row(children: [
    //         SizedBox(
    //           width: 2.w,
    //         ),
    //         Container(
    //           width: MediaQuery.of(context).size.width * .45,
    //           child: Text(
    //             'Upload the package image',
    //             style: AppStyle.mediumTextStyle
    //                 .copyWith(color: AppColor.extraDarkPink),
    //           ),
    //         ),
    //         SizedBox(
    //           width: 2.w,
    //         ),
    //         Container(
    //           //  width: MediaQuery.of(context).size.width * .30,
    //           child: AppWidget.addPictureContainer(
    //               text: 'Package', context: context),
    //         ),
    //         SizedBox(
    //           width: 2.w,
    //         ),
    //       ]),
    //     ),
    //     mediumSizedBox,
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         SizedBox(
    //           width: 4.w,
    //         ),
    //         Expanded(
    //             child: AppWidget.buttonWithOnlyBorder(
    //                 onTap: () {
    //                   Get.back();
    //                 },
    //                 text: 'Cancel')),
    //         SizedBox(
    //           width: 4.w,
    //         ),
    //         Expanded(
    //             child: AppWidget.buttonStyleSmallText(
    //                 text: 'Ware versandt',
    //                 onTap: () {
    //                   Get.back();
    //                   homeController.processTwoIndex.value = 0;
    //                   homeController.processIndex.value = 0;
    //                   homeController.isProcessSelected.value = false;
    //                   homeController.update();
    //                 },
    //                 fontSize: 11.sp)),
    //         SizedBox(
    //           width: 4.w,
    //         ),
    //       ],
    //     ),
    //     smallSizedBox
    //   ],
    // ));
  }
}
