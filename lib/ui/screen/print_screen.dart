import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:point_of_sale/common/theme.dart';
import 'package:point_of_sale/model/order_model.dart';

class PrintScreen extends StatefulWidget {
  final List<OrderModel> list;
  const PrintScreen({Key? key, required this.list}) : super(key: key);

  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _devicesMsg = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => {initPrinter()});
  }

  Future<void> initPrinter() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 2));

    if (!mounted) return;
    bluetoothPrint.scanResults.listen(
      (val) {
        if (!mounted) return;
        setState(() => {_devices = val});
        if (_devices.isEmpty)
          setState(() {
            _devicesMsg = "No Devices";
          });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(defaultMargin),
            child: Text(
              "List Device Bluetooth",
              style:
                  primaryTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
            ),
          ),
          Expanded(
            child: _devices.isEmpty
                ? Center(
                    child: Text(_devicesMsg),
                  )
                : ListView.builder(
                    itemCount: _devices.length,
                    itemBuilder: (c, i) {
                      return ListTile(
                        leading: Icon(Icons.print),
                        title: Text(_devices[i].name ?? ""),
                        subtitle: Text(_devices[i].address ?? ""),
                        onTap: () {},
                      );
                    },
                  ),
          ),
        ],
      )),
    );
  }
}
