import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/controller/processOne_controller.dart';
import 'package:neoloop/screens/home/product/Produkteingang%20Produktion/produkteingang_produktion.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:neoloop/utils/utils.dart';
import 'package:sizer/sizer.dart';

class ProdukteingangProduktionMainPage extends StatefulWidget {
  const ProdukteingangProduktionMainPage({Key? key}) : super(key: key);

  @override
  State<ProdukteingangProduktionMainPage> createState() =>
      _ProdukteingangProduktionMainPageState();
}

class _ProdukteingangProduktionMainPageState
    extends State<ProdukteingangProduktionMainPage> {
  HomeController homeController = Get.put(HomeController());
  ProcessOneController processOneController = Get.put(ProcessOneController());
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();
    if (isConnected) {
      await processOneController.productSearchApiCall();
      await processOneController.getProductListApiCall();
      // processOneController.selectedProduct.value = processOneController
      //         .selectedProductItem.value.producttypeInfo![0]!.name ??
      //     ''.toString();
    } else {
      AppWidget.showShackBar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return homeController.processOneIndex.value == 0
            ? Padding(
                padding: paddingSymmetric(horizontal: 6.w, vertical: 00),
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    AppWidget.productContainer(
                        imageString: AppImage.processOne,
                        name: 'Produkteingang \nProduktion'),
                    smallSizedBox,
                    Obx(
                      () => (processOneController.productList != [])
                          ? DropdownButtonFormField(
                              isExpanded: true,
                              decoration: InputDecoration(
                                  contentPadding: paddingSymmetric(
                                      horizontal: 2.w, vertical: 00),
                                  hintText: AppStrings.selectProduct,
                                  hintStyle: AppStyle.extraSmallTextStyle
                                      .copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.w),
                                    borderSide:
                                        BorderSide(color: AppColor.darkPink),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.w),
                                    borderSide:
                                        BorderSide(color: AppColor.grey),
                                  )),
                              // value: processOneController.selectedProduct.value,
                              hint: Text(processOneController
                                          .selectedProduct.value ==
                                      ''
                                  ? 'Select product'
                                  : processOneController.selectedProduct.value),
                              items: processOneController.productList.map((
                                productTypes,
                              ) {
                                return DropdownMenuItem(
                                  value: productTypes.name,
                                  child: Text(productTypes.name.toString()),
                                  onTap: () {
                                    print('ONTAP ${productTypes.id}');
                                    processOneController.selectedProductId
                                        .value = productTypes.id;
                                    processOneController.update();
                                  },
                                );
                              }).toList(),
                              onChanged: (v) async {
                                processOneController.selectedProduct.value =
                                    v.toString();
                                processOneController.update();
                                processOneController
                                    .produkteingangProduktionSelectedIndex
                                    .value = 0;
                                processOneController.update();

                                await processOneController
                                    .productSearchApiCall();
                              })
                          : AppWidget.progressIndicator(),
                    ),
                    smallSizedBox,
                    AppWidget.searchField(
                        searchController:
                            processOneController.searchController.value,
                        onChanged: (value) async {
                          await processOneController.productSearchApiCall();
                        }),
                    mediumSizedBox,
                    Obx(
                      () {
                        // return (processOneController.selectedProduct.value ==
                        //             '' ||
                        //         processOneController.allProductList.isEmpty)
                        return processOneController.isLoading.value == true
                            ? AppWidget.progressIndicator()
                            : processOneController.allProductList.isEmpty
                                ? Center(
                                    child: Text(
                                      'No product found',
                                      style: AppStyle.smallTextStyle,
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    _containerText(
                                                        name: processOneController
                                                                .selectedProductItem
                                                                .value
                                                                .producttypeInfo![
                                                                    0]!
                                                                .name ??
                                                            ' '),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    _containerText(
                                                        name: processOneController
                                                                .selectedProductItem
                                                                .value
                                                                .ecosharkSerialNo ??
                                                            ' ',
                                                        color: AppColor.grey),
                                                    smallSizedBox,
                                                  ],
                                                ),
                                              )),
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () => onTapOnProduct(),
                                              child: Text(
                                                'Continue >',
                                                style: AppStyle
                                                    .extraSmallTextStyle
                                                    .copyWith(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.blue,
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                            ),
                                          ))
                                        ],
                                      ),
                                      smallSizedBox,
                                      GridView.builder(
                                        itemCount: processOneController
                                            .allProductList.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 2.w,
                                                mainAxisSpacing: 2.w),
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder: ((context, index) {
                                          return GestureDetector(
                                            onTap: () =>
                                                onTapOnProduct(index: index),
                                            child: Material(
                                              elevation: 2,
                                              borderRadius:
                                                  BorderRadius.circular(2.w),
                                              child: Obx(
                                                () => Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2.w),
                                                        color: processOneController
                                                                    .produkteingangProduktionSelectedIndex
                                                                    .value ==
                                                                index
                                                            ? AppColor
                                                                .extraDarkPink
                                                            : Colors.white),
                                                    child: Padding(
                                                      padding: paddingSymmetric(
                                                          horizontal: 2.w,
                                                          vertical: 1.w),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child:
                                                                  FadeInImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        processOneController
                                                                            .allProductList[index]
                                                                            .productImageUrl
                                                                            .toString(),
                                                                      ),
                                                                      placeholder:
                                                                          AssetImage(AppImage
                                                                              .blur),
                                                                      fit: BoxFit
                                                                          .fill),
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                processOneController
                                                                    .allProductList[
                                                                        index]
                                                                    .productName,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppStyle.extraSmallTextStyle.copyWith(
                                                                    color: processOneController.produkteingangProduktionSelectedIndex.value ==
                                                                            index
                                                                        ? Colors
                                                                            .white
                                                                        : AppColor
                                                                            .extraDarkPink,
                                                                    fontSize:
                                                                        9.sp),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                processOneController
                                                                    .allProductList[
                                                                        index]
                                                                    .ecosharkSerialNo,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppStyle.extraSmallTextStyle.copyWith(
                                                                    color: processOneController.produkteingangProduktionSelectedIndex.value ==
                                                                            index
                                                                        ? Colors
                                                                            .white
                                                                        : AppColor
                                                                            .grey,
                                                                    fontSize:
                                                                        9.sp),
                                                              ),
                                                            )
                                                          ]),
                                                    )),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                      smallSizedBox,
                                    ],
                                  );
                      },
                    ),

                    // Obx(
                    //   () {
                    //     return processOneController.isLoading.value == true
                    //         ? AppWidget.progressIndicator()
                    //         : processOneController.allProductList.length == 0
                    //             ? Text(
                    //                 'No product found',
                    //                 style: AppStyle.mediumTextStyle,
                    //               )
                    //             : GridView.builder(
                    //                 itemCount: processOneController
                    //                     .allProductList.length,
                    //                 gridDelegate:
                    //                     SliverGridDelegateWithFixedCrossAxisCount(
                    //                         crossAxisCount: 3,
                    //                         crossAxisSpacing: 2.w,
                    //                         mainAxisSpacing: 2.w),
                    //                 shrinkWrap: true,
                    //                 physics: ClampingScrollPhysics(),
                    //                 itemBuilder: ((context, index) {
                    //                   return GestureDetector(
                    //                     onTap: () {
                    //                       processOneController
                    //                           .produkteingangProduktionSelectedIndex
                    //                           .value = index;
                    //                       processOneController.update();
                    //                       processOneController
                    //                           .selectedProductItem(
                    //                               processOneController
                    //                                   .allProductList[index]);
                    //
                    //                       processOneController
                    //                           .update();
                    //                       homeController.processOneIndex.value =
                    //                           1;
                    //                       homeController.update();
                    //                     },
                    //                     child: Material(
                    //                       elevation: 2,
                    //                       borderRadius:
                    //                           BorderRadius.circular(2.w),
                    //                       child: Obx(
                    //                         () => Container(
                    //                             decoration: BoxDecoration(
                    //                                 borderRadius:
                    //                                     BorderRadius.circular(
                    //                                         2.w),
                    //                                 color: processOneController
                    //                                             .produkteingangProduktionSelectedIndex
                    //                                             .value ==
                    //                                         index
                    //                                     ? AppColor.extraDarkPink
                    //                                     : Colors.white),
                    //                             child: Padding(
                    //                               padding: paddingSymmetric(
                    //                                   horizontal: 2.w,
                    //                                   vertical: 1.w),
                    //                               child: Column(
                    //                                   mainAxisAlignment:
                    //                                       MainAxisAlignment
                    //                                           .center,
                    //                                   children: [
                    //                                     Expanded(
                    //                                         child: Image.asset(
                    //                                             AppImage.blur,
                    //                                             fit: BoxFit
                    //                                                 .fill),
                    //                                         flex: 2),
                    //                                     Flexible(
                    //                                       child: Text(
                    //                                         processOneController
                    //                                             .allProductList[
                    //                                                 index]
                    //                                             .producttypeInfo![
                    //                                                 0]!
                    //                                             .name
                    //                                             .toString(),
                    //                                         overflow:
                    //                                             TextOverflow
                    //                                                 .ellipsis,
                    //                                         style: AppStyle.extraSmallTextStyle.copyWith(
                    //                                             color: processOneController
                    //                                                         .produkteingangProduktionSelectedIndex
                    //                                                         .value ==
                    //                                                     index
                    //                                                 ? Colors
                    //                                                     .white
                    //                                                 : AppColor
                    //                                                     .extraDarkPink,
                    //                                             fontSize: 9.sp),
                    //                                       ),
                    //                                     ),
                    //                                     Flexible(
                    //                                       child: Text(
                    //                                         processOneController
                    //                                             .allProductList[
                    //                                                 index]
                    //                                             .ecosharkSerialNo,
                    //                                         overflow:
                    //                                             TextOverflow
                    //                                                 .ellipsis,
                    //                                         style: AppStyle
                    //                                             .extraSmallTextStyle
                    //                                             .copyWith(
                    //                                                 color: processOneController
                    //                                                             .produkteingangProduktionSelectedIndex.value ==
                    //                                                         index
                    //                                                     ? Colors
                    //                                                         .white
                    //                                                     : AppColor
                    //                                                         .grey,
                    //                                                 fontSize:
                    //                                                     9.sp),
                    //                                       ),
                    //                                     )
                    //                                   ]),
                    //                             )),
                    //                       ),
                    //                     ),
                    //                   );
                    //                 }),
                    //               );
                    //   },
                    // ),
                  ],
                ),
              )
            : homeController.processOneIndex.value == 1
                ? ProdukteingangProduktionQue()
                : homeController.processOneIndex.value == 2
                    ? ProdukteingangProduktionConfirmation()
                    : homeController.processOneIndex.value == 3
                        ? ProdukteingangProduktionPrint()
                        : Printers();
      },
    );
  }

  _containerText({required String name, Color? color}) => Container(
        alignment: Alignment.center,
        height: 3.h,
        padding: paddingSymmetric(horizontal: 2.w, vertical: 00),
        decoration: BoxDecoration(
            color: color ?? AppColor.extraDarkPink,
            borderRadius: BorderRadius.circular(3.w)),
        child: Row(
          children: [
            Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.extraSmallTextStyle
                  .copyWith(color: Colors.white, fontSize: 6.sp),
            ),
            SizedBox(
              width: 5.w,
            ),
            Icon(
              Icons.close,
              color: Colors.white,
              size: 3.w,
            ),
          ],
        ),
      );

  onTapOnProduct({int? index}) {
    processOneController.produkteingangProduktionSelectedIndex.value = index!;
    processOneController.update();
    processOneController
        .selectedProductItem(processOneController.allProductList[index]);

    processOneController.update();
    homeController.processOneIndex.value = 1;
    homeController.update();
  }
}
