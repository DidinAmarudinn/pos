import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/common/theme.dart';
import 'package:point_of_sale/ui/widgets/categories_container.dart';

class CategorisWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  const CategorisWidget(
      {Key? key, required this.onTap, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: defaultMargin / 2,
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: defaultMargin),
                  child: GestureDetector(
                    onTap: () {
                      onTap(0);
                    },
                    child: CategoriesContainer(
                      title: "Semua",
                      selected: selectedIndex,
                      index: 0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onTap(1);
                  },
                  child: CategoriesContainer(
                    title: "Ready to Ship",
                    selected: selectedIndex,
                    index: 1,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onTap(2);
                  },
                  child: CategoriesContainer(
                    title: "Shipping",
                    selected: selectedIndex,
                    index: 2,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onTap(3);
                  },
                  child: CategoriesContainer(
                    title: "Done",
                    selected: selectedIndex,
                    index: 3,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onTap(4);
                  },
                  child: CategoriesContainer(
                    title: "New",
                    selected: selectedIndex,
                    index: 4,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
