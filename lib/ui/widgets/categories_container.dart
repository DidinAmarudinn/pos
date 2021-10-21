import 'package:flutter/material.dart';
import 'package:point_of_sale/common/theme.dart';

class CategoriesContainer extends StatelessWidget {
  final String title;
  final int index;
  final int selected;
  const CategoriesContainer({
    Key? key,
    required this.title,
    required this.index,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: defaultMargin / 2),
      padding: EdgeInsets.symmetric(
          horizontal: defaultMargin / 3, vertical: defaultMargin / 4),
      decoration: BoxDecoration(
        color: selected == index ? kblackColor : kwhiteTextColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(title,
          style: selected == index
              ? whiteTextStyle.copyWith(fontSize: 12, fontWeight: medium)
              : primaryTextStyle.copyWith(fontSize: 12, fontWeight: medium)),
    );
  }
}
