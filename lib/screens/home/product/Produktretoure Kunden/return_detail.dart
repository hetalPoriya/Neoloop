import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/utils.dart';

class ReturnDetails extends StatelessWidget {
  const ReturnDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //controller
    HomeController homeController = Get.put(HomeController());

    return Column(
      children: [
        Padding(
          padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
          // child: AppWidget.productDetailContainer(
          //   context: context,
          //   // productDetail: Column(
          //   //   mainAxisAlignment: MainAxisAlignment.center,
          //   //   crossAxisAlignment: CrossAxisAlignment.start,
          //   //   children: [
          //   //     Text(
          //   //       'Customer name:',
          //   //       style: AppStyle.smallTextStyle.copyWith(
          //   //           color: AppColor.black, fontWeight: FontWeight.w700),
          //   //     ),
          //   //     Text(
          //   //       'Jone mac',
          //   //       style: AppStyle.smallTextStyle.copyWith(
          //   //           color: AppColor.extraDarkPink,
          //   //           fontWeight: FontWeight.w700),
          //   //     ),
          //   //     AppWidget.richTextForProductOne(
          //   //         text1: 'Order no:', text2: ' N59643422')
          //   //   ],
          //   // ),
          // ),
        ),
        smallSizedBox,
        AppWidget.orderListContainer(context: context, text: 'Product return '),
        smallSizedBox,
        Column(
          children: [
            Container(
              height: 8.h,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: AppColor.extraDarkPink.withOpacity(0.1),
                          width: 2.w))),
              child: Padding(
                padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      color: AppColor.extraLightPink,
                      child: Row(
                        children: [
                          AppWidget.productTwoTitleText(text: 'Return date'),
                          AppWidget.productTwoTitleText(text: 'Receive Status'),
                          AppWidget.productTwoTitleText(text: 'Refund Status'),
                        ],
                      ),
                    )),
                    Expanded(
                        child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          AppWidget.productTwoSubText(text: '02DEC2022'),
                          AppWidget.productTwoSubText(
                              text: 'Received', textColor: AppColor.green),
                          AppWidget.productTwoSubText(
                              text: 'Partially refunded',
                              textColor: AppColor.extraDarkPink),
                          Container(
                              width: 1.w,
                              child: Checkbox(
                                  activeColor: Colors.grey.shade200,
                                  checkColor: AppColor.green,
                                  value: true,
                                  onChanged: (c) {})),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
            smallSizedBox
          ],
        ),
        Container(
          height: 4.h,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 8.w),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                      color: AppColor.extraDarkPink.withOpacity(0.2),
                      width: 2))),
          child: RichText(
              maxLines: 1,
              text: TextSpan(
                  text: 'Reason:',
                  style: AppStyle.smallTextStyle.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text: ' Item or product defective',
                        style: AppStyle.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis))
                  ])),
        ),
        smallSizedBox,
        Padding(
          padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
          child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              textAlign: TextAlign.left,
              style: AppStyle.extraSmallTextStyle.copyWith(fontSize: 9.sp)),
        ),
        mediumSizedBox,
        Padding(
            padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
            child: Divider(
              color: AppColor.extraDarkPink.withOpacity(0.3),
              thickness: 1,
            )),
        smallSizedBox,
        Padding(
          padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Product images:',
              style: AppStyle.extraSmallTextStyle
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        smallerSizedBox,
        Container(
          height: 12.h,
          padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
          child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return Row(
                  children: [
                    Container(
                      height: 10.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 2)
                        ],
                        borderRadius: BorderRadius.circular(4.w),
                        // image: DecorationImage(
                        //     image: AssetImage('assets/img.png'),
                        //     fit: BoxFit.fill)
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    )
                  ],
                );
              })),
        ),
        mediumSizedBox,
        Row(
          children: [
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              child: AppWidget.buttonStyleSmallText(
                  fontSize: 10.sp,
                  text: 'Reklamation ablehnen',
                  onTap: () {
                    homeController.processThreeIndex.value = 0;
                    homeController.processIndex.value = 0;
                    homeController.isProcessSelected.value = false;
                    homeController.update();
                  }),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
              child: AppWidget.buttonStyleSmallText(
                fontSize: 10.sp,
                text: 'Preis erstatten',
                onTap: () {
                  homeController.processThreeIndex.value = 0;
                  homeController.processIndex.value = 0;
                  homeController.isProcessSelected.value = false;
                  homeController.update();
                },
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            // Expanded(
            //     child: AppWidget.buttonStyleSmallText(
            //         fontSize: 8.sp,
            //         text: 'Neues Produkt versenden',
            //         onTap: () {}),
            //     flex: 3),
            SizedBox(
              width: 2.w,
            ),
          ],
        ),
        smallerSizedBox,
        Padding(
          padding: paddingSymmetric(horizontal: 12.w, vertical: 00),
          child: AppWidget.buttonStyleSmallText(
              fontSize: 10.sp,
              text: 'Neues Produkt versenden',
              onTap: () {
                homeController.processThreeIndex.value = 0;
                homeController.processIndex.value = 0;
                homeController.isProcessSelected.value = false;
                homeController.update();
              }),
        ),
        mediumSizedBox,
      ],
    );
  }
}
