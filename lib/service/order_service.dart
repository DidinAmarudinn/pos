import 'dart:convert';

import 'package:point_of_sale/common/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:point_of_sale/model/order_model.dart';

class OrderService {
  static Future<List<OrderModel>> getOrderData(String token) async {
    String url = baseUrl + order + token;

    var response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return Future.error("error");
    }

    return orderFromJson(response.body);
  }
}

List<OrderModel> orderFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<OrderModel>.from(data.map((item) => OrderModel.fromJson(item)));
}
