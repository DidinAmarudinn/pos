import 'dart:convert';

import 'package:point_of_sale/common/api_path.dart';
import 'package:point_of_sale/model/api_return_value.dart';
import 'package:point_of_sale/model/login_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<ApiReturnValue> userLogin(
      String username, String password) async {
    String url = baseUrl + login;
    var datbody = {"uname": username, "pswrd": password};
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(datbody),
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Login Failed");
    }
    var data = jsonDecode(response.body);
    LoginModel res = LoginModel.fromJson(data);
    print(res.token);
    return ApiReturnValue(value: res);
  }

  static Future<bool> userLogout(String token) async {
    String url = baseUrl + logout + token;

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
}
