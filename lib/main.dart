import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/provider/print_order_provider.dart';
import 'package:point_of_sale/ui/screen/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PrintOrderProvider(),
      child: GetMaterialApp(
        title: 'Point Order',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
