import 'package:flutter/foundation.dart';
import 'package:point_of_sale/model/order_model.dart';

class PrintOrderProvider extends ChangeNotifier {
  final List<OrderModel> _listPrintOrder = [];

  List<OrderModel> get listPrintOrder => _listPrintOrder;

  void addPrintOrder(OrderModel printOrder) {
    _listPrintOrder.add(printOrder);
    notifyListeners();
  }

  void removePrintOrder(OrderModel printOrder) {
    _listPrintOrder.remove(printOrder);
    notifyListeners();
  }
}
