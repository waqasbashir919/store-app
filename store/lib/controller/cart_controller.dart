import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/model/model.dart';

class CartController extends GetxController {
  //Add a dict to store the products in the cart
  var _products = {}.obs;

  get count => _products.length;

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
  }

  get products => _products;

  get productSubtotal => _products.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get total => _products.length == 0
      ? 0
      : _products.entries
          .map((product) => product.key.price * product.value)
          .toList()
          .reduce((value, element) => value + element);
}
