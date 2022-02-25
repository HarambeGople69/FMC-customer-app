import 'package:get/get.dart';
import 'package:myapp/controller/authentication_controller.dart';
import 'package:myapp/controller/dashboard_controller.dart';
import 'package:myapp/controller/order_cart_controller.dart';
import 'package:myapp/controller/search_text_controller.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(
      () => AuthenticationController(),
    );
    Get.lazyPut(
      () => DashboardController(),
    );
    Get.lazyPut(
      () => SearchTextController(),
    );
    Get.lazyPut(
      () => OrderCartController(),
    );
  }
}
