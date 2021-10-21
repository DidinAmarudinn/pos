import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/common/theme.dart';
import 'package:point_of_sale/model/order_model.dart';
import 'package:point_of_sale/provider/print_order_provider.dart';
import 'package:point_of_sale/service/order_service.dart';
import 'package:point_of_sale/service/user_service.dart';
import 'package:point_of_sale/ui/screen/login_screen.dart';
import 'package:point_of_sale/ui/screen/print_screen.dart';
import 'package:point_of_sale/ui/screen/search_screen.dart';
import 'package:point_of_sale/ui/widgets/categories_widget.dart';
import 'package:point_of_sale/ui/widgets/custom_button.dart';
import 'package:point_of_sale/ui/widgets/dialog_about.dart';
import 'package:point_of_sale/ui/widgets/drawer_widget.dart';
import 'package:point_of_sale/ui/widgets/item_order.dart';
import 'package:point_of_sale/ui/widgets/item_shimmer.dart';
import 'package:point_of_sale/utils/preference_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool _enabled = true;
  bool isLoading = true;
  bool isLoadLogout = false;
  int selectedCategories = 0;
  List<OrderModel> list = [];
  List<OrderModel> listAll = [];
  List<OrderModel> listDone = [];
  List<OrderModel> listRts = [];
  List<OrderModel> listShip = [];
  List<OrderModel> listNew = [];
  List<OrderModel> listSearch = [];
  String token = "";
  int id = 0;
  var textEditingController = TextEditingController();
  String email = "";
  String title = "";
  String version = "";
  String desc = "";
  String nameApp = "";
  late SharedPreferences _preferences;
  PrefenceHelper _prefenceHelper =
      PrefenceHelper(SharedPreferences.getInstance());
  @override
  void initState() {
    super.initState();

    _getData();
  }

  _getData() async {
    int idUser = await _prefenceHelper.id;
    String emailUser = await _prefenceHelper.email;
    String tokenUser = await _prefenceHelper.token;
    String titleApp = await _prefenceHelper.title;
    String name = await _prefenceHelper.nameApp;
    String descApp = await _prefenceHelper.description;
    String versionApp = await _prefenceHelper.version;
    OrderService.getOrderData(tokenUser).then((value) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        list = value;
        listDone = value.where((element) => element.state == "Done").toList();
        listAll = value;
        listRts = value.where((element) => element.state == "RTS").toList();
        listShip = value.where((element) => element.state == "Ship").toList();
        listNew = value.where((element) => element.state == "New").toList();
        id = idUser;
        email = emailUser;
        token = tokenUser;
        nameApp = name;
        title = titleApp;
        desc = descApp;
        version = versionApp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showAboutDialog() async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogAbout(
              title: title, desc: desc, appName: nameApp, version: version);
        },
      );
    }

    return Consumer<PrintOrderProvider>(
      builder: (context, state, _) => Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: kbackgroundColor,
          title: Text(""),
          elevation: 0,
          leading: IconButton(
            onPressed: isLoading
                ? null
                : () {
                    _key.currentState!.openDrawer();
                  },
            icon: Icon(
              Icons.menu,
              color: kblackColor,
            ),
          ),
        ),
        drawer: DrawerWidget(
          showDialog: () {
            showAboutDialog();
          },
          logout: () async {
            _preferences = await SharedPreferences.getInstance();
            setState(() {
              isLoadLogout = true;
            });
            UserService.userLogout(token).then((value) {
              if (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Berhasil Logout"),
                  ),
                );
                _preferences.clear();
                Get.to(() => LoginScreen());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Gagal Logout"),
                  ),
                );
              }
            });
          },
          isLoading: isLoadLogout,
        ),
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
                  onPressed: () {
                    if (state.listPrintOrder.isNotEmpty) {
                      Get.to(() => PrintScreen(
                            list: state.listPrintOrder,
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Pilih untuk Print Order"),
                        ),
                      );
                    }
                  },
                  height: 40,
                  width: 150,
                  color: kblackColor),
              Text(
                "Item Print: " + state.listPrintOrder.length.toString(),
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: semiBold),
              ),
            ],
          ),
        ),
        backgroundColor: kbackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(defaultMargin),
                child: Text(
                  "List Order",
                  style: primaryTextStyle.copyWith(
                      fontSize: 20, fontWeight: semiBold),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SearchScreen(list: listAll));
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: TextField(
                      enabled: false,
                      controller: textEditingController,
                      decoration: InputDecoration(
                          hintText: "Search Order",
                          contentPadding: EdgeInsets.all(15),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              SizedBox(height: defaultMargin / 2),
              CategorisWidget(
                selectedIndex: selectedCategories,
                onTap: (value) {
                  setState(() {
                    selectedCategories = value;
                    print(selectedCategories);
                  });
                  if (selectedCategories == 0) {
                    setState(() {
                      list = listAll;
                    });
                  } else if (selectedCategories == 1) {
                    setState(() {
                      list = listRts;
                    });
                  } else if (selectedCategories == 2) {
                    setState(() {
                      list = listShip;
                    });
                  } else if (selectedCategories == 3) {
                    setState(() {
                      list = listDone;
                    });
                  } else {
                    setState(() {
                      list = listNew;
                    });
                  }
                },
              ),
              SizedBox(
                height: defaultMargin / 2,
              ),
              Expanded(
                child: isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        enabled: _enabled,
                        child: ListView.builder(
                          itemBuilder: (_, __) => ItemShimmer(),
                          itemCount: 6,
                        ),
                      )
                    : ListView.builder(
                        itemCount: list.length + 1,
                        itemBuilder: (context, index) {
                          if (index == list.length) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: defaultMargin / 2),
                              child: Center(child: Text("No more order")),
                            );
                          } else {
                            return ItemOrder(
                              isDone:
                                  state.listPrintOrder.contains(list[index]),
                              index: index,
                              orderModel: list[index],
                              onClick: () {
                                if (state.listPrintOrder
                                    .contains(list[index])) {
                                  state.removePrintOrder(list[index]);
                                } else {
                                  state.addPrintOrder(list[index]);
                                }
                              },
                            );
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
