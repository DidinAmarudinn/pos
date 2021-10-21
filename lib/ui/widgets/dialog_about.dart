import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/common/theme.dart';

class DialogAbout extends StatelessWidget {
  final String title;
  final String desc;
  final String appName;
  final String version;
  const DialogAbout(
      {Key? key,
      required this.title,
      required this.desc,
      required this.appName,
      required this.version})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (2 * defaultMargin),
      child: AlertDialog(
        backgroundColor: kwhiteTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    color: kblackColor,
                    size: 30,
                  ),
                ),
              ),
              Text(
                title + " ($appName)",
                style: primaryTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
              ),
              SizedBox(
                height: defaultMargin / 2,
              ),
              Text(
                desc,
                style: primaryTextStyle.copyWith(fontWeight: light),
              ),
              SizedBox(
                height: defaultMargin / 2,
              ),
              Text(
                version,
                style: primaryTextStyle.copyWith(fontWeight: medium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
