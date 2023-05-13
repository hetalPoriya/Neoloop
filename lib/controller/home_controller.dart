import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //for bottomTab
  RxInt bottomIndex = 0.obs;

  //main page
  RxInt processIndex = 0.obs;
  RxBool isProcessSelected = false.obs;
  RxBool isSettingPage = false.obs;

  // product one screen
  RxInt processOneIndex = 0.obs;
  RxInt processTwoIndex = 0.obs;
  RxInt processThreeIndex = 0.obs;
}
