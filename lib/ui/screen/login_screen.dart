import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/common/theme.dart';
import 'package:point_of_sale/model/login_model.dart';
import 'package:point_of_sale/service/user_service.dart';
import 'package:point_of_sale/ui/screen/main_screen.dart';
import 'package:point_of_sale/ui/widgets/custom_button.dart';
import 'package:point_of_sale/ui/widgets/custom_textfield.dart';
import 'package:point_of_sale/utils/preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _tEmail = TextEditingController();
  var _tPassword = TextEditingController();
  bool isLoading = false;

  PrefenceHelper _prefenceHelper =
      PrefenceHelper(SharedPreferences.getInstance());
  @override
  void initState() {
    super.initState();
    _checkUSerSession();
  }

  _checkUSerSession() async {
    String token = await _prefenceHelper.token;
    if (token.length != 0) {
      Get.to(() => MainScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hii,\nLogin Sekarang",
              style: primaryTextStyle.copyWith(fontSize: 24, fontWeight: bold),
            ),
            SizedBox(height: defaultMargin * 2),
            CustomTextField(label: "Email", controller: _tEmail),
            SizedBox(height: defaultMargin),
            CustomTextField(
              label: "Password",
              controller: _tPassword,
            ),
            SizedBox(height: defaultMargin),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: kblackColor,
                    strokeWidth: 3,
                  ))
                : CustomButtonWidget(
                    buttonName: "Login",
                    onPressed: () {
                      if (_tEmail.text.isNotEmpty &&
                          _tPassword.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        UserService.userLogin(_tEmail.text, _tPassword.text)
                            .then((value) {
                          if (value.value != null) {
                            LoginModel data = value.value;
                            _prefenceHelper.setEmail(_tEmail.text);
                            _prefenceHelper.setToken(data.token ?? "");
                            if (data.data != null) {
                              if (data.data!.login != null &&
                                  data.data!.about != null) {
                                _prefenceHelper
                                    .setId(data.data!.login!.id ?? 0);
                                _prefenceHelper
                                    .setPhone(data.data!.login!.phone ?? "");
                                _prefenceHelper
                                    .setNamaToko(data.data!.login!.name ?? "");
                                _prefenceHelper
                                    .setStore(data.data!.login!.store ?? "");
                                _prefenceHelper
                                    .setTitle(data.data!.about!.title ?? "");
                                _prefenceHelper.setDesc(
                                    data.data!.about!.description ?? "");
                                _prefenceHelper.setVersion(
                                    data.data!.about!.version ?? "");
                                _prefenceHelper
                                    .setNameApp(data.data!.about!.name ?? "");
                              }
                            }
                            setState(() {
                              isLoading = false;
                            });
                            print(data.token);
                            Get.offAll(() => MainScreen());
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Login Error",
                                ),
                              ),
                            );
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Masukan Email dan Password",
                            ),
                          ),
                        );
                      }
                    },
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: kblackColor,
                  )
          ],
        ),
      ),
    );
  }
}
