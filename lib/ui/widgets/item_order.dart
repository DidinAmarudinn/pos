import 'package:flutter/material.dart';
import 'package:point_of_sale/common/asset_path.dart';
import 'package:point_of_sale/common/theme.dart';
import 'package:point_of_sale/model/order_model.dart';

class ItemOrder extends StatelessWidget {
  final OrderModel orderModel;
  final int index;
  final Function onClick;
  final bool isDone;
  const ItemOrder(
      {Key? key,
      required this.orderModel,
      required this.index,
      required this.onClick,
      required this.isDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: defaultMargin / 2, bottom: defaultMargin / 3),
      margin: EdgeInsets.symmetric(
          horizontal: defaultMargin, vertical: defaultMargin / 3),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: kwhiteTextColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: defaultMargin / 3),
                child: Image.asset(
                  index == 0
                      ? imgShopee
                      : index == 1
                          ? imgTokoped
                          : index == 2
                              ? imgBlibli
                              : index == 3
                                  ? imgBukalapak
                                  : index == 4
                                      ? imgLazada
                                      : index == 5
                                          ? imgJdid
                                          : imgShopee,
                  width: 40,
                ),
              ),
              SizedBox(
                width: defaultMargin / 2,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: defaultMargin / 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderModel.product ?? "",
                        style: primaryTextStyle.copyWith(fontWeight: semiBold),
                      ),
                      Text(
                        orderModel.rname ?? "",
                        style: primaryTextStyle.copyWith(fontWeight: medium),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 4, horizontal: defaultMargin / 3),
                      decoration: BoxDecoration(
                        color: kblackColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        orderModel.state ?? "",
                        style: whiteTextStyle,
                      )),
                  SizedBox(
                    height: defaultMargin / 3,
                  ),
                  isDone
                      ? IconButton(
                          onPressed: () {
                            onClick();
                          },
                          icon: Icon(
                            Icons.done,
                            color: kblackColor,
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            onClick();
                          },
                          child: Text(
                            "print",
                            style: primaryTextStyle,
                          ),
                        )
                ],
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 15,
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                child: Text(
                  orderModel.rcity ?? "",
                  maxLines: 2,
                  style: primaryTextStyle.copyWith(fontSize: 12),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
