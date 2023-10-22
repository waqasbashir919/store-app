import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/constants/contants.dart';
import 'package:store/model/model.dart';

class RemoteServices {
  static Future<List<Product>?> getProducts(limit) async {
    try {
      var uri = Uri.parse('${Constant.allProducts}?limit=${limit}');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        final products = productFromJson(response.body);
        return products;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> signIn(String email, String password) async {
    try {
      var uri = Uri.parse('${Constant.login}');
      final response = await http
          .post(uri, body: {'username': '${email}', 'password': '${password}'});
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }
}
