import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoloop/controller/home_controller.dart';
import 'package:neoloop/screens/background_screen.dart';
import 'package:neoloop/screens/home/home.dart';
import 'package:neoloop/screens/home/product/Produktausgang%20Kunden/produktausgang_kunden.dart';
import 'package:neoloop/screens/home/product/Produkteingang%20Produktion/produkteingang_produktion.dart';
import 'package:neoloop/screens/home/product/Produktretoure%20Kunden/produktretoure_kunden.dart';
import 'package:neoloop/screens/screens.dart';
import 'package:neoloop/utils/app_images.dart';
import 'package:neoloop/utils/app_styles.dart';
import 'package:sizer/sizer.dart';

class ProductMainPage extends StatelessWidget {
  const ProductMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //home controller
    HomeController homeController = Get.put(HomeController());
    //product list
    List<Product> productList = [
      Product(
          imageString: AppImage.processOne,
          productName: 'Produkteingang \nProduktion'),
      Product(
          imageString: AppImage.processTwo,
          productName: 'Produktausgang \nKunden'),
      Product(
          imageString: AppImage.processThree,
          productName: 'Produktretoure \nKunden'),
    ];

    List<Widget> mainPage = [
      ProdukteingangProduktionMainPage(),
      ProduktausgangKundenExitCustomers(),
      ReturnAndReplacement()
    ];

    return BackgroundScreen(
        onBackButtonPressed: () {
          if (homeController.isSettingPage.value == true) {
            homeController.isSettingPage.value = false;
            // homeController.isProcessSelected.value = false;
            homeController.update();
          }
          if (homeController.isProcessSelected.value == true) {
            if (homeController.processIndex.value == 0) {
              if (homeController.processOneIndex.value != 0) {
                homeController.processOneIndex.value =
                    homeController.processOneIndex.value - 1;
                homeController.update();
              } else {
                homeController.isProcessSelected.value = false;
                homeController.bottomIndex.value = 0;
                homeController.update();
              }
            }

            if (homeController.processIndex.value == 1) {
              if (homeController.processTwoIndex.value != 0) {
                homeController.processTwoIndex.value =
                    homeController.processTwoIndex.value - 1;
                homeController.update();
              } else {
                homeController.isProcessSelected.value = false;
                homeController.bottomIndex.value = 0;
                homeController.update();
              }
            }

            if (homeController.processIndex.value == 2) {
              if (homeController.processThreeIndex.value != 0) {
                homeController.processThreeIndex.value =
                    homeController.processThreeIndex.value - 1;
                homeController.update();
              } else {
                homeController.isProcessSelected.value = false;
                homeController.bottomIndex.value = 0;
                homeController.update();
              }
            }
          } else {
            homeController.isProcessSelected.value = false;
            homeController.bottomIndex.value = 0;
            homeController.update();
          }
        },
        listViewWidget: Center(
            child: Obx(
          () => homeController.isProcessSelected.value == false
              ? ListView.builder(
                  itemCount: productList.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) => GestureDetector(
                        onTap: () {
                          homeController.isProcessSelected.value = true;
                          homeController.processIndex.value = index;

                          homeController.update();
                        },
                        child: Container(
                          padding:
                              paddingSymmetric(horizontal: 8.w, vertical: 00),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              smallSizedBox,
                              AppWidget.productContainer(
                                  imageString: productList[index].imageString,
                                  name: productList[index].productName),
                              smallSizedBox,
                            ],
                          ),
                        ),
                      )),
                )
              : mainPage.elementAt(homeController.processIndex.value),
        )));
  }
}

class Product {
  String imageString;
  String productName;

  Product({required this.imageString, required this.productName});
}
