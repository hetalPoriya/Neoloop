import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';
import 'package:neoloop/model/processOne/add_inventory.dart';
import 'package:neoloop/model/processOne/add_inventory_einzelufung.dart';
import 'package:neoloop/model/processOne/get_productType.dart';
import 'package:neoloop/model/processOne/search_product.dart';
import 'package:neoloop/model/processOne/upload_document.dart';
import 'package:neoloop/model/processOne/upload_document_info.dart';
import 'package:neoloop/utils/app_strings.dart';
import 'package:neoloop/utils/network_handler.dart';
import 'package:neoloop/utils/sharedPref.dart';
import 'package:neoloop/utils/sharedPref_string.dart';

class ProcessOneController extends GetxController {
  //ProdukteingangProduktion (product one)
  RxInt produkteingangProduktionSelectedIndex = 0.obs;

  //for loading
  var isLoading = false.obs;

  //for all product list
  var productList = [].obs;

  //selected product list data
  RxList allProductList = [].obs;

  //bluetooth list data
  RxList deviceData = [].obs;

  //to get particular selected item
  Rx<SearchProducts> selectedProductItem = SearchProducts().obs;

  //controller
  var searchController = TextEditingController().obs;
  var searchForIpController = TextEditingController().obs;
  var stockController = TextEditingController().obs;
  var damagedStockController = TextEditingController().obs;

  //select product text and id
  RxString selectedProduct = ''.obs;
  RxString selectedProductId = ''.obs;

  //selected question answer
  RxString firstQueAns = ''.obs;
  RxString secondQueAns = ''.obs;

  // //printer related strings
  // RxString trueZplValueForQueOne = "^FO140,510^GFA,00512,00512,00008,:Z64:"
  //         "eJxjYBgCQAFKJ0Aoxg8QmhlK8/+A0PJQ2h4q/v8ARPn/Bojyf1Dlf1CV1z9AUc4AVc5QB7W1BkobkOf4wQ0AZe4R2w==:0FA5"
  //         "^FO140,510^GFA,00256,00256,00004,:Z64:"
  //         "eJxjYKAxYGxgYGA+wMDA/oCBgf8DkP4B5P8Biv8DSv4H4nqgAnugAnlkBUDMCGQzPKC18wBfuA7u:FCE4"
  //     .obs;
  //
  // RxString trueZplValueForQueTwo = "^FO140,710^GFA,00512,00512,00008,:Z64:"
  //         "eJxjYBgCQAFKJ0Aoxg8QmhlK8/+A0PJQ2h4q/v8ARPn/Bojyf1Dlf1CV1z9AUc4AVc5QB7W1BkobkOf4wQ0AZe4R2w==:0FA5"
  //         "^FO140,710^GFA,00256,00256,00004,:Z64:"
  //         "eJxjYKAxYGxgYGA+wMDA/oCBgf8DkP4B5P8Biv8DSv4H4nqgAnugAnlkBUDMCGQzPKC18wBfuA7u:FCE4"
  //     .obs;
  //
  // RxString falseZplValueForQueTwo = "^FO135,700^GFA,00512,00512,00008,:Z64:"
  //         "eJxjYBj6QAJK20Fp+wYIXQ/l/4NQjDD6D4Rm/gGh2T9AaH4Y/QBCyx9AMw6HsTDjcBkLNY4ZSjMcwOsZOgMAcuwTCQ==:8BFC"
  //         "^FO135,700^GFA,00512,00512,00008,:Z64:"
  //         "eJxjYBh2oAFCMR6A0MxQmv0BlP4AFf8Bpf9A1f+D6v8PpeuhBtlDDZCHGsAPNYAdlwEwuh5K20NpOSgtA6U58HqDPgAA/4AQ0g==:137D"
  //     .obs;
  //
  // RxString falseZplValueForQueOne = "^FO135,500^GFA,00512,00512,00008,:Z64:"
  //         "eJxjYBj6QAJK20Fp+wYIXQ/l/4NQjDD6D4Rm/gGh2T9AaH4Y/QBCyx9AMw6HsTDjcBkLNY4ZSjMcwOsZOgMAcuwTCQ==:8BFC"
  //         "^FO135,500^GFA,00512,00512,00008,:Z64:"
  //         "eJxjYBh2oAFCMR6A0MxQmv0BlP4AFf8Bpf9A1f+D6v8PpeuhBtlDDZCHGsAPNYAdlwEwuh5K20NpOSgtA6U58HqDPgAA/4AQ0g==:137D"
  //     .obs;
  //printer related strings
  //printer related strings
  RxString isDamagedOrNotText = ''.obs;
  RxString zplCommandDamagedOrNotFirstQue = ''.obs;
  RxString zplCommandDamagedOrNotSecQue = ''.obs;
  RxString productTypeNameForPrinter = ''.obs;
  RxString productForPrinter = ''.obs;
  RxString showStorageForPrinter = ''.obs;
  RxString customerNumberForPrinter = ''.obs;

  RxString trueZplValueForQueOne = "^FO140,380^GFA,00512,00512,00008,:Z64:"
          "eJxjYBgCQAFKJ0Aoxg8QmhlK8/+A0PJQ2h4q/v8ARPn/Bojyf1Dlf1CV1z9AUc4AVc5QB7W1BkobkOf4wQ0AZe4R2w==:0FA5"
          "^FO140,380^GFA,00256,00256,00004,:Z64:"
          "eJxjYKAxYGxgYGA+wMDA/oCBgf8DkP4B5P8Biv8DSv4H4nqgAnugAnlkBUDMCGQzPKC18wBfuA7u:FCE4"
      .obs;

  RxString trueZplValueForQueTwo = "^FO140,520^GFA,00512,00512,00008,:Z64:"
          "eJxjYBgCQAFKJ0Aoxg8QmhlK8/+A0PJQ2h4q/v8ARPn/Bojyf1Dlf1CV1z9AUc4AVc5QB7W1BkobkOf4wQ0AZe4R2w==:0FA5"
          "^FO140,520^GFA,00256,00256,00004,:Z64:"
          "eJxjYKAxYGxgYGA+wMDA/oCBgf8DkP4B5P8Biv8DSv4H4nqgAnugAnlkBUDMCGQzPKC18wBfuA7u:FCE4"
      .obs;

  RxString falseZplValueForQueTwo = "^FO135,510^GFA,00512,00512,00008,:Z64:"
          "eJxjYBj6QAJK20Fp+wYIXQ/l/4NQjDD6D4Rm/gGh2T9AaH4Y/QBCyx9AMw6HsTDjcBkLNY4ZSjMcwOsZOgMAcuwTCQ==:8BFC"
          "^FO135,510^GFA,00512,00512,00008,:Z64:"
          "eJxjYBh2oAFCMR6A0MxQmv0BlP4AFf8Bpf9A1f+D6v8PpeuhBtlDDZCHGsAPNYAdlwEwuh5K20NpOSgtA6U58HqDPgAA/4AQ0g==:137D"
      .obs;

  RxString falseZplValueForQueOne = "^FO135,370^GFA,00512,00512,00008,:Z64:"
          "eJxjYBj6QAJK20Fp+wYIXQ/l/4NQjDD6D4Rm/gGh2T9AaH4Y/QBCyx9AMw6HsTDjcBkLNY4ZSjMcwOsZOgMAcuwTCQ==:8BFC"
          "^FO135,370^GFA,00512,00512,00008,:Z64:"
          "eJxjYBh2oAFCMR6A0MxQmv0BlP4AFf8Bpf9A1f+D6v8PpeuhBtlDDZCHGsAPNYAdlwEwuh5K20NpOSgtA6U58HqDPgAA/4AQ0g==:137D"
      .obs;

  //for front and back image
  Rx<File> frontImage = File('').obs;
  Rx<File> backImage = File('').obs;
  RxList<UploadDocumentInfo> frontImagesList = RxList<UploadDocumentInfo>();
  RxList<UploadDocumentInfo> backImagesList = RxList<UploadDocumentInfo>();

  RxBool questionOneAttemptOrNot = false.obs;
  RxBool questionTwoAttemptOrNot = false.obs;
  //bool
  RxList checkListItems1 = [
    {
      "id": 0,
      "value": false,
      "title": "Ja",
    },
    {
      "id": 1,
      "value": false,
      "title": "Nein",
    },
  ].obs;

  RxList checkListItems2 = [
    {
      "id": 0,
      "value": false,
      "title": "Ja",
    },
    {
      "id": 1,
      "value": false,
      "title": "Nein",
    },
  ].obs;

  Future getProductListApiCall() async {
    try {
      isLoading(true);
      var response = await NetworkHandler.getApi(AppStrings.getProductListApi);
      var productListData = getProductTypesFromMap(response);
      productList(productListData);
    } finally {
      isLoading(false);
    }
  }

  Future productSearchApiCall() async {
    try {
      isLoading(true);
      print("Inside process one Controller");
      ToSearchProduct toSearchProduct = ToSearchProduct(
          producttypeId: selectedProductId.value,
          searchKeyword: searchController.value.text);
      var response = await NetworkHandler.post(
          searchProductsToMap(toSearchProduct), AppStrings.searchProductApi);
      print('Response $response');
      var data = json.decode(response);
      print('data $data');

      if (data.length != 0) {
        var searchProductData = searchProductsFromMap(response);
        allProductList(searchProductData);
        selectedProductItem(searchProductData?[0]);
        print(selectedProductItem);
      } else {
        allProductList = [].obs;
        selectedProductItem = SearchProducts().obs;
      }
    } finally {
      isLoading(false);
    }
  }

  Future addInventoryForProductTypeMassenErfassungApiCall() async {
    try {
      isLoading(true);
      ToAddInventoryTypeMassenErfassung toAddInventory =
          ToAddInventoryTypeMassenErfassung(
              type: selectedProductItem.value.producttypeInfo![0]!.type
                  .toString(),
              productId: selectedProductItem.value.id.toString(),
              stock: stockController.value.text.isNotEmpty
                  ? int.parse(stockController.value.text)
                  : 0,
              damagedStock: damagedStockController.value.text.isNotEmpty
                  ? int.parse(damagedStockController.value.text)
                  : 0);
      var response = await NetworkHandler.post(
          addInventoryToMapTypeMassenErfassung(toAddInventory),
          AppStrings.addInventoryApi);
      var data = json.decode(response);

      print('data $data');
      Fluttertoast.showToast(msg: data['msg']);
    } finally {
      isLoading(false);
    }
  }

  Future addInventoryForProductTypeEinzelufungApiCall() async {
    try {
      isLoading(true);
      print(firstQueAns.value);
      print(secondQueAns.value);

      AddInventoryEinzelufung addInventoryEinzelufung = AddInventoryEinzelufung(
          type: selectedProductItem.value.producttypeInfo![0]!.type.toString(),
          productId: selectedProductItem.value.id.toString(),
          questionAnswer: [
            QuestionAnswer(
                question: 'Ist eine sichtbare Beschädigung erkennbar?',
                answer: firstQueAns.value),
            QuestionAnswer(
                question: 'Lässt sich das Gerät einschalten?',
                answer: secondQueAns.value),
          ],
          addedBy: SharedPrefClass.getString(SharedPrefStrings.userNeoloopId),
          frontImages: [
            for (var i = 0; i < frontImagesList.length; i++)
              ImageList(
                  documentUniqueId: frontImagesList[i].documentUniqueId,
                  documentTags: frontImagesList[i].documentTags),
          ],
          backImages: [
            for (var i = 0; i < backImagesList.length; i++)
              ImageList(
                  documentUniqueId: backImagesList[i].documentUniqueId,
                  documentTags: backImagesList[i].documentTags),
          ]);
      var response = await NetworkHandler.post(
          addInventoryEinzelufungToMap(addInventoryEinzelufung),
          AppStrings.addInventoryApi);

      log(response);
      var data = json.decode(response);
      log(data['device_id']);
      SharedPrefClass.setString(SharedPrefStrings.deviceId, data['device_id']);

      log(SharedPrefClass.getString(SharedPrefStrings.deviceId));
      Fluttertoast.showToast(msg: 'Added successfully');
      // var response = await NetworkHandler.postForm(
      //   frontImagesList: frontImagesList,
      //   backImagesList: backImagesList,
      //   endpoint: AppStrings.addInventoryApi,
      //   type: selectedProductItem.value.producttypeInfo![0]!.type.toString(),
      //   productId: selectedProductItem.value.id.toString(),
      //   firstQueAns: firstQueAns.value,
      //   secoQueAns: secondQueAns.value,
      // );

      // var data = json.decode(response);
      // print('data $data');
      // Fluttertoast.showToast(msg: data['msg']);
    } finally {
      isLoading(false);
    }
  }

  Future uploadDocumentApiCall(
      {required File image,
      required bool front,
      required double size,
      required String type}) async {
    try {
      isLoading(true);
      var response = await Dio().post(
        NetworkHandler.buildImageUrl(AppStrings.uploadDocumentApi),
        data: FormData.fromMap({
          'document': await MultipartFile.fromFile(image.path),
        }),
      );
      var data = uploadDocumentFromMap(json.encode(response.data));
      if (response.data != null) {
        Fluttertoast.showToast(msg: 'Image Uploaded Successfully.');
        if (front == true) {
          frontImagesList.add(
            UploadDocumentInfo(
                documentUniqueId: data?.documentUniqueId,
                documentTags:
                    '${size.floor().toStringAsFixed(2)}mb,image/$type,${DateTime.now().toIso8601String()}',
                imagePath: image.path),
          );
        } else {
          backImagesList.add(
            UploadDocumentInfo(
                documentUniqueId: data?.documentUniqueId,
                documentTags:
                    '${size.floor().toStringAsFixed(2)}mb,image/$type,${DateTime.now().toIso8601String()}',
                imagePath: image.path),
          );
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
