import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:saman_project/contorller/order_api_controller.dart';
import 'package:saman_project/getx/cart_getx_controller.dart';
import 'package:saman_project/models/order.dart';


class OrdersGetxController extends GetxController {

  RxList<Order> orders = <Order>[].obs;
  OrderApiController ordersController = OrderApiController();
  static OrdersGetxController get to => Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    readOrders();
    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
     orders.clear();
    super.onClose();
  }


    Future<bool> addOrders() async{
      bool order = await ordersController.addOrder();
      if(order){
        CartGetxController.to.carts.clear();
        // Navigator.pushNamed(context, "/order_successful_screen");
      }
      return order;
       }


  Future<void> readOrders() async{
  orders.value = await ordersController.indexOrders();
  }



}