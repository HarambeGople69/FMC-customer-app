import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/search_text_controller.dart';
import 'package:myapp/model/firebase_user_model.dart';
import 'package:myapp/model/product_model.dart';
import 'package:myapp/screen/dashboard_screens/cart_screen/cart_screen.dart';
import 'package:myapp/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myapp/widgets/our_product_item_tile.dart';
import 'package:myapp/widgets/our_shimmer_text.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:badges/badges.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double value = 3.5;
  List items = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/5.png",
    "assets/images/6.png",
    "assets/images/7.png",
    "assets/images/8.png",
  ];
  String searchText = "";
  TextEditingController _search_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.menu,
            size: ScreenUtil().setSp(
              25,
            ),
          ),
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        backgroundColor: logoColor,
        title: Text(
          "FMC Cart",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(25),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(
              ScreenUtil().setSp(20),
            ),
            bottomLeft: Radius.circular(
              ScreenUtil().setSp(20),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: ScreenUtil().setSp(10),
            ),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Icon(
                    Icons.shopping_basket,
                    size: ScreenUtil().setSp(
                      25,
                    ),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.exists) {
                    FirebaseUserModel firebaseUserModel =
                        FirebaseUserModel.fromMap(snapshot.data!.data()!);
                    return InkWell(
                      onTap: () {
                        // Get.to(
                        //   CartScreen(),
                        //   transition: Transition.rightToLeft,
                        // );
                      },
                      child: Badge(
                        position: BadgePosition.topStart(),
                        badgeContent: Text(
                          firebaseUserModel.cartItemNo.toString(),
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: Icon(
                          Icons.shopping_basket,
                          size: ScreenUtil().setSp(
                            25,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: () {
                        // Get.to(
                        //   CartScreen(),
                        //   transition: Transition.rightToLeft,
                        // );
                      },
                      child: Icon(
                        Icons.shopping_basket,
                        size: ScreenUtil().setSp(
                          25,
                        ),
                      ),
                    );
                  }
                }
                return InkWell(
                  onTap: () {
                    // Get.to(
                    //   CartScreen(),
                    //   transition: Transition.rightToLeft,
                    // );
                  },
                  child: Icon(
                    Icons.shopping_basket,
                    size: ScreenUtil().setSp(
                      25,
                    ),
                  ),
                );
              },
            ),
          )
        ],
        bottom: PreferredSize(
          child: Obx(
            () => Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setSp(20),
                vertical: ScreenUtil().setSp(10),
              ),
              height: ScreenUtil().setSp(45),
              child: TextField(
                onChanged: (value) {
                  Get.find<SearchTextController>().changeValue(value);
                },
                style: TextStyle(
                  color: logoColor,
                  fontSize: ScreenUtil().setSp(17.5),
                ),
                controller:
                    Get.find<SearchTextController>().search_controller.value,
                decoration: InputDecoration(
                  focusColor: logoColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: lightlogoColor,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        ScreenUtil().setSp(10),
                      ),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: lightlogoColor,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        ScreenUtil().setSp(10),
                      ),
                    ),
                  ),
                  hintText: "Product Name",
                  hintStyle: TextStyle(
                    color: logoColor,
                    fontSize: ScreenUtil().setSp(17.5),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.search,
                    size: ScreenUtil().setSp(25),
                    color: logoColor,
                  ),
                  suffixIcon: Get.find<SearchTextController>()
                          .searchText
                          .trim()
                          .isEmpty
                      ? Icon(null)
                      : InkWell(
                          onTap: () {
                            Get.find<SearchTextController>().clearController();
                          },
                          child: Icon(
                            Icons.delete,
                            size: ScreenUtil().setSp(25),
                            color: logoColor,
                          ),
                        ),
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(
            ScreenUtil().setSp(75),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(10),
            vertical: ScreenUtil().setSp(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: ScreenUtil().setSp(150),
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    // onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    "assets/images/1.png",
                    "assets/images/2.png",
                    "assets/images/3.png",
                    "assets/images/4.png",
                    "assets/images/5.png",
                    "assets/images/6.png",
                    "assets/images/7.png",
                    "assets/images/8.png",
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Image.asset(
                            i,
                            height: ScreenUtil().setSp(100),
                            width: ScreenUtil().setSp(100),
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const OurSizedBox(),
                const OurShimmerText(
                  title: "Products",
                ),
                const OurSizedBox(),
                Obx(() => Get.find<SearchTextController>()
                        .searchText
                        .trim()
                        .isEmpty
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Products")
                            .orderBy("timestamp", descending: true)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            if (snapshot.data!.docs.length > 0) {
                              return StaggeredGridView.countBuilder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 4,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  ProductModel productModel =
                                      ProductModel.fromMap(
                                          snapshot.data!.docs[index]);
                                  return OurProductItemTile(
                                    productModel: productModel,
                                  );
                                },
                                staggeredTileBuilder: (int index) =>
                                    StaggeredTile.count(
                                        2, index.isEven ? 3.35 : 3.7),
                                mainAxisSpacing: ScreenUtil().setSp(10),
                                crossAxisSpacing: ScreenUtil().setSp(10),
                              );
                            } else {
                              return Text("No Data");
                            }
                          } else if (!snapshot.hasData) {
                            return Text("No Datasaiii");
                          }
                          return Text("data");

                          // return CircularProgressIndicator();
                          // rethrow
                        },
                      )
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Products")
                            .where("searchfrom",
                                arrayContains: Get.find<SearchTextController>()
                                    .search_controller
                                    .value
                                    .text
                                    .toLowerCase())
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.length > 0) {
                              return StaggeredGridView.countBuilder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 4,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  ProductModel productModel =
                                      ProductModel.fromMap(
                                          snapshot.data!.docs[index]);
                                  return OurProductItemTile(
                                    productModel: productModel,
                                  );
                                },
                                staggeredTileBuilder: (int index) =>
                                    StaggeredTile.count(
                                        2, index.isEven ? 3.75 : 3.5),
                                mainAxisSpacing: ScreenUtil().setSp(10),
                                crossAxisSpacing: ScreenUtil().setSp(10),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  "No Users",
                                ),
                              );
                            }
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
