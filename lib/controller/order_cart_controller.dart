import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:myapp/model/order_product_detail.dart';
import 'package:flutter/material.dart';

class OrderCartController extends GetxController {
  var orderCart = <Map<String, dynamic>>[].obs;

  void clearCart() {
    orderCart.clear();
  }

  void addToCart(OrderProductDetail productDetail) {
    orderCart.add(productDetail.toMap());
  }
}
