import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:neoloop/model/processTwo/all_order_details.dart';
import 'package:neoloop/model/processTwo/assign_inventory_to_order_item.dart';
import 'package:neoloop/model/processTwo/get_inventory_by_device_id.dart';
import 'package:neoloop/model/processTwo/get_package_order_item_inventory.dart';
import 'package:neoloop/model/processTwo/undelivered_orders.dart';
import '../model/processTwo/all_order_details.dart';
import '../utils/utils.dart';

class ProcessTwoController extends GetxController {
  //ProdukteingangProduktion (product one)
  RxInt produktausgangKundenSelectedIndex = 0.obs;

  //for loading
  var isLoading = false.obs;

  //for all undelivered order
  Rx<UndeliveredOrders> undeliveredOrdersList = UndeliveredOrders().obs;

  //for all product details
  RxString selectedOrderNo = ''.obs;

  Rx<OrderItem> selectedProductItem = OrderItem().obs;
  Rx<GetPackageOrderItemInventoryList> selectedPackageItem =
      GetPackageOrderItemInventoryList().obs;
  Rx<OrderDetails> orderDetails = OrderDetails().obs;
  RxList orderItem = [].obs;
  RxList orderItemsDetail = [].obs;

  // RxList orderTaxDetail = [].obs;
  // RxList orderInvoiceDetail = [].obs;
  Rx<CustomerInfoForAllDetails> customerInfo = CustomerInfoForAllDetails().obs;

  //get_package_order_item_inventory
  RxString isProductOrPackageAndType = ''.obs;
  Rx<TextEditingController> manuallyAddedQuantity = TextEditingController().obs;
  RxString isProductOrPackage = ''.obs;
  RxString packageName = ''.obs;
  RxString scanBarcodeDeviceId = ''.obs;
  RxList packagesList = [].obs;
  Rx<InventoryDetails> inventoryDetails = InventoryDetails().obs;

  Future getUndeliveredOrderApiCall() async {
    try {
      isLoading(true);
      var response = await NetworkHandler.post(
        {},
        AppStrings.getUndeliveredOrdersApi,
      );
      var undeliveredOrder = undeliveredOrdersFromMap(response);
      undeliveredOrdersList(undeliveredOrder);
      log(' undeliveredOrder ${undeliveredOrder.response?[0].orderNo}');
    } finally {
      isLoading(false);
    }
  }

  Future getAllOrderApiCall() async {
    try {
      isLoading(true);
      log('OrderNo ${selectedOrderNo.toString()}');
      ToAllOrderModel toAllOrderModel =
          ToAllOrderModel(orderId: selectedOrderNo.toString());
      var response = await NetworkHandler.post(
        allOrderDetailsToMap(toAllOrderModel),
        AppStrings.getOrderDetailsByIdApi,
      );
      var allOrderDetails = allOrderDetailsFromMap(response);
      orderDetails(allOrderDetails.result?.orderDetails);
      orderItem(allOrderDetails.result?.orderItems);
      orderItemsDetail(allOrderDetails.result?.orderItemsDetails);
      // orderTaxDetail(allOrderDetails.result?.orderTaxDetails);
      // orderInvoiceDetail(allOrderDetails.result?.orderInvoiceDetails);
      customerInfo(allOrderDetails.result?.customerInfo);
    } finally {
      isLoading(false);
    }
  }

  Future getPackageOrderItemInventoryApiCall() async {
    try {
      isLoading(true);
      log('SelectedPackageId ${selectedProductItem.value.id}');
      TOGetPackageOrderItemInventory toGetPackageOrderItemInventory =
          TOGetPackageOrderItemInventory(
              orderItemId: selectedProductItem.value.id.toString());
      var response = await NetworkHandler.post(
        getPackageOrderItemInventoryToMap(toGetPackageOrderItemInventory),
        AppStrings.getPackageOrderItemInventory,
      );
      var getPackageOrderItem = getPackageOrderItemInventoryFromMap(response);
      packageName(getPackageOrderItem.packageName);
      packagesList(getPackageOrderItem.data);
    } finally {
      isLoading(false);
    }
  }

  Future getInventoryByDeviceIdApiCall() async {
    try {
      isLoading(true);
      ToGetInventoryByDeviceId toGetInventoryByDeviceId =
          ToGetInventoryByDeviceId(deviceId: scanBarcodeDeviceId.value);
      var response = await NetworkHandler.post(
        getInventoryByDeviceIdToJson(toGetInventoryByDeviceId),
        AppStrings.getInventoryByDeviceIdApi,
      );
      log('Response $response');
      var getInventoryByDeviceId = getInventoryByDeviceIdFromJson(response);
      inventoryDetails(getInventoryByDeviceId.inventoryDetails);
    } finally {
      isLoading(false);
    }
  }

  Future assignInventoryToOrderItemApiCall() async {
    // Get oder details api ke under
    // Customer info me  _id.
    // Order details me Order no.
    // Both are comman
    // Jo Order select kiya hai uski
    // Order item ke under ki item id
    //sold bu me login id
    // picked quantity jo add ki hai
    //fot package order_item_produvt_id me productInfo id
    try {
      isLoading(true);
      String loginId = SharedPrefClass.getString(SharedPrefStrings.loginId);
      log('ProductOrPackage ${isProductOrPackage.value}');
      log('type ${isProductOrPackageAndType.value}');
      log('Customer id ${customerInfo.value.id}');
      log('Order no ${orderDetails.value.orderNo}');
      log('Sold by ${loginId}');
      log('Inventory Id ${inventoryDetails.value.id}');
      log('Order item id  ${selectedProductItem.value.id}');
      log('Order item product id ${selectedPackageItem.value.productInfo?.id}');
      log('Quantity ${manuallyAddedQuantity.value.text}');

      var response;
      ToAssignInventoryToOrderItem toAssignInventoryToOrderItem =
          ToAssignInventoryToOrderItem();
      if (isProductOrPackageAndType.value ==
          AppStrings.productTypeEinzelprufung) {
        toAssignInventoryToOrderItem = ToAssignInventoryToOrderItem(
            customerId: customerInfo.value.id,
            orderNo: orderDetails.value.orderNo,
            orderItemId: selectedProductItem.value.id,
            inventoryId: inventoryDetails.value.id,
            soldBy: loginId);
      } else if (isProductOrPackageAndType.value ==
          AppStrings.productTypeMassenErfassung) {
        toAssignInventoryToOrderItem = ToAssignInventoryToOrderItem(
            customerId: customerInfo.value.id,
            orderNo: orderDetails.value.orderNo,
            orderItemId: selectedProductItem.value.id,
            pickedQuantity: manuallyAddedQuantity.value.text);
      } else if (isProductOrPackageAndType.value ==
          AppStrings.packageTypeEinzelprufung) {
        toAssignInventoryToOrderItem = ToAssignInventoryToOrderItem(
            customerId: customerInfo.value.id,
            orderNo: orderDetails.value.orderNo,
            orderItemId: selectedProductItem.value.id,
            inventoryId: inventoryDetails.value.id,
            soldBy: loginId,
            orderItemProductId: selectedPackageItem.value.productInfo?.id);
      } else {
        toAssignInventoryToOrderItem = ToAssignInventoryToOrderItem(
            customerId: customerInfo.value.id,
            orderNo: orderDetails.value.orderNo,
            orderItemId: selectedProductItem.value.id,
            pickedQuantity: manuallyAddedQuantity.value.text,
            orderItemProductId: selectedPackageItem.value.productInfo?.id);
      }
      response = await NetworkHandler.post(
        assignInventoryToOrderItemToJson(toAssignInventoryToOrderItem),
        AppStrings.assignInventoryToOrderItemApi,
      );
      log('Response $response');
      var assignInventoryToOrderItem =
          assignInventoryToOrderItemFromJson(response);
      Fluttertoast.showToast(msg: assignInventoryToOrderItem.msg.toString());
      if (assignInventoryToOrderItem.status == '200') {
        Get.back();
        if (isProductOrPackage.value == 'product') {
          await getAllOrderApiCall();
        } else {
          await getPackageOrderItemInventoryApiCall();
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
