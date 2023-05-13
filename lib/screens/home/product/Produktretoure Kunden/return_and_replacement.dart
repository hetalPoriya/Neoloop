import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/screens/home/product/Produktretoure%20Kunden/produktretoure_kunden.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:neoloop/utils/app_colors.dart';
import 'package:neoloop/utils/app_images.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/app_styles.dart';

class ReturnAndReplacement extends StatelessWidget {
  const ReturnAndReplacement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //controller
    HomeController homeController = Get.put(HomeController());
    return Obx(
      () {
        return homeController.processThreeIndex.value == 0
            ? Column(
                children: [
                  Padding(
                    padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
                    child: AppWidget.productContainer(
                        imageString: AppImage.processThree,
                        name: 'Produktretoure \nKunden'),
                  ),
                  mediumSizedBox,
                  AppWidget.orderListContainer(
                      context: context, text: 'Return and replacement'),
                  smallSizedBox,
                  Padding(
                    padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
                    child: Material(
                      elevation: 1.w,
                      shadowColor: Colors.black,
                      borderRadius: BorderRadius.circular(8.w),
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.zero,
                            hintText: 'Search customer name or order no...',
                            hintStyle: AppStyle.extraSmallTextStyle.copyWith(
                              fontSize: 8.sp,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.w),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.w),
                                borderSide: BorderSide(color: AppColor.grey))),
                      ),
                    ),
                  ),
                  mediumSizedBox,
                  ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                homeController.processThreeIndex.value = 1;
                                homeController.update();
                              },
                              child: Container(
                                height: 11.h,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColor.extraDarkPink
                                                .withOpacity(0.1),
                                            width: 2.w))),
                                child: Padding(
                                  padding: paddingSymmetric(
                                      horizontal: 6.w, vertical: 00),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppWidget.richTextForProductOne(
                                            fontSize: 11.sp,
                                            text1: 'Delivery on:',
                                            text2:
                                                ' Fri, 28th Nov 2022, 04:15PM',
                                            color: AppColor.green),
                                        SizedBox(height: 1.w),
                                        Expanded(
                                            flex: 3,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  color:
                                                      AppColor.extraLightPink,
                                                  child: Row(
                                                    children: [
                                                      AppWidget
                                                          .productTwoTitleText(
                                                              text:
                                                                  'Order no.'),
                                                      AppWidget
                                                          .productTwoTitleText(
                                                              text: 'Product'),
                                                      AppWidget
                                                          .productTwoTitleText(
                                                              text: 'Status'),
                                                      AppWidget
                                                          .productTwoTitleText(
                                                              text: 'Qty'),
                                                    ],
                                                  ),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                  color: Colors.white,
                                                  child: Row(
                                                    children: [
                                                      AppWidget
                                                          .productTwoSubText(
                                                              text:
                                                                  'N59643422'),
                                                      AppWidget
                                                          .productTwoSubText(
                                                              text:
                                                                  'Click here',
                                                              textColor:
                                                                  Colors.blue),
                                                      AppWidget.productTwoSubText(
                                                          text:
                                                              'Return request',
                                                          textColor: AppColor
                                                              .extraDarkPink),
                                                      AppWidget
                                                          .productTwoSubText(
                                                              text: '1'),
                                                    ],
                                                  ),
                                                )),
                                              ],
                                            )),
                                      ]),
                                ),
                              ),
                            ),
                            mediumSizedBox,
                          ],
                        );
                      }))
                ],
              )
            : ReturnDetails();
      },
    );
  }
}
