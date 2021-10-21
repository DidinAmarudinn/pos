import 'package:flutter/material.dart';
import 'package:point_of_sale/common/theme.dart';

class ItemShimmer extends StatelessWidget {
  const ItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding:
          EdgeInsets.only(left: defaultMargin / 2, bottom: defaultMargin / 3),
      margin: EdgeInsets.symmetric(
          horizontal: defaultMargin, vertical: defaultMargin / 3),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: kwhiteTextColor,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
