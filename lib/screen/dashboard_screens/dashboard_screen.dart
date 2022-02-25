import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/dashboard_controller.dart';
import 'package:myapp/screen/dashboard_screens/add_product_screen/add_product_screens.dart';
import 'package:myapp/screen/dashboard_screens/favorite_screen/favorite_screen.dart';
import 'package:myapp/screen/dashboard_screens/main_screen/home_screen.dart';
import 'package:myapp/screen/dashboard_screens/order_screens/order_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List screens = [
    const HomeScreen(),
    // const FavoriteScreen(),
    Text("data"),
    Text("data"),
    Text("data"),
    // const OrderScreen(),
    // const AddProductScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          body: screens[Get.find<DashboardController>().indexs.value],
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: Get.find<DashboardController>().indexs.value,
            showElevation: true, // use this to remove appBar's elevation
            onItemSelected: (index) =>
                Get.find<DashboardController>().changeIndexs(index),
            items: [
              BottomNavyBarItem(
                icon: const Icon(Icons.apps),
                title: const Text('Home'),
                activeColor: Colors.red,
              ),
              BottomNavyBarItem(
                  icon: const Icon(Icons.favorite_border_outlined),
                  title: const Text('Favorite'),
                  activeColor: Colors.purpleAccent),
              BottomNavyBarItem(
                  icon: const Icon(Icons.shopping_bag),
                  title: const Text('Orders'),
                  activeColor: Colors.pink),
              BottomNavyBarItem(
                  icon: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  activeColor: Colors.blue),
            ],
          ));
    });
  }
}
