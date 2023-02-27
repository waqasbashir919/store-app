import 'package:get/get.dart';
import 'package:store/model/model.dart';
import 'package:flutter/material.dart';

class FavouriteController extends GetxController {
  var _favProducts = {}.obs;

  get favCount => _favProducts.length;

  get products => _favProducts;
  void addFavProduct(Product product) {
    _favProducts[product] = 1;
  }

  void removeFavProducts(Product product) {
    if (_favProducts.containsKey(product)) {
      _favProducts.removeWhere((key, value) => key == product);
    }
  }

  get favSubTotal => _favProducts.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get favTotal => _favProducts.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element);
}
