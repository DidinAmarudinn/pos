import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/common/theme.dart';

class DrawerWidget extends StatelessWidget {
  final Function logout;
  final Function showDialog;
  final bool isLoading;
  const DrawerWidget({Key? key, required this.logout, required this.isLoading,required this.showDialog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget drawerItem(String text, Function onPressed) {
      return TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          text,
          style: primaryTextStyle.copyWith(fontSize: 16),
        ),
      );
    }

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topLeft,
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: kwhiteTextColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultMargin, vertical: defaultMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 40,
                    color: kblackColor,
                  ),
                ),
                drawerItem(
                    "Logout",
                    isLoading
                        ? () {}
                        : () {
                            logout();
                          }),
                drawerItem(
                    "About",
                    isLoading
                        ? () {}
                        : () {
                            showDialog();
                          }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
