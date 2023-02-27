import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/model/model.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Product>?> getProducts() async {
    try {
      var uri = Uri.parse('https://fakestoreapi.com/products');
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        return productFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
