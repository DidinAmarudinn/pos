import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/common/theme.dart';
import 'package:point_of_sale/model/order_model.dart';
import 'package:point_of_sale/provider/print_order_provider.dart';
import 'package:point_of_sale/ui/widgets/custom_button.dart';
import 'package:point_of_sale/ui/widgets/item_order.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final List<OrderModel> list;
  const SearchScreen({Key? key, required this.list}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<OrderModel> listSearch = [];
  var textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<PrintOrderProvider>(
      builder: (context, state, _) => Scaffold(
        backgroundColor: kbackgroundColor,
        bottomNavigationBar: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            color: kwhiteTextColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButtonWidget(
                buttonName: "Print",
                onPressed: () {},
                height: 40,
                width: 150,
                color: kblackColor,
              ),
              Text(
                "Item Print: " + state.listPrintOrder.length.toString(),
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: semiBold),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: defaultMargin * 2,
              ),
              Container(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        hintText: "Cari Product / Nama Pembeli",
                        hintStyle: primaryTextStyle.copyWith(
                          fontSize: 14,
                          color: kblackColor.withOpacity(0.5),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (textEditingController.text.length > 0) {
                              setState(() {
                                listSearch.clear();
                                textEditingController.clear();
                              });
                            } else {
                              Get.back();
                            }
                          },
                          icon: Icon(Icons.close),
                        ),
                        contentPadding: EdgeInsets.all(15),
                        border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                ),
              ),
              SizedBox(
                height: defaultMargin,
              ),
              Expanded(
                child: listSearch.length > 0
                    ? ListView.builder(
                        itemCount: listSearch.length + 1,
                        itemBuilder: (context, index) {
                          if (index == listSearch.length) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: defaultMargin / 2),
                              child: Center(child: Text("No more order")),
                            );
                          } else {
                            return ItemOrder(
                              index: index,
                              isDone: state.listPrintOrder
                                  .contains(listSearch[index]),
                              orderModel: listSearch[index],
                              onClick: () {
                                if (state.listPrintOrder
                                    .contains(listSearch[index])) {
                                  state.removePrintOrder(listSearch[index]);
                                } else {
                                  state.addPrintOrder(listSearch[index]);
                                }
                              },
                            );
                          }
                        },
                      )
                    : Container(
                        alignment: Alignment.topCenter,
                        child: Text("Masukan Kata Kunci")),
              )
            ],
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    listSearch.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    widget.list.forEach((userDetail) {
      if (userDetail.product!.toLowerCase().contains(text) ||
          userDetail.rname!.toLowerCase().contains(text))
        listSearch.add(userDetail);
    });

    setState(() {});
  }
}
