// import 'package:app_settings/app_settings.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:myapp/controller/order_cart_controller.dart';
// import 'package:myapp/model/cart_product_model.dart';
// import 'package:myapp/model/firebase_user_model.dart';
// import 'package:myapp/screen/dashboard_screens/check_out_screen/check_out_screen.dart';
// import 'package:myapp/services/firestore/firestore.dart';
// import 'package:myapp/utils/colors.dart';
// import 'package:myapp/widgets/our_elevated_button.dart';
// import 'package:myapp/widgets/our_flutter_toast.dart';
// import 'package:myapp/widgets/our_shimmer_text.dart';
// import 'package:myapp/widgets/our_sized_box.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:timeago/timeago.dart' as timeago;

// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);

//   @override
//   _CartScreenState createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             size: ScreenUtil().setSp(25),
//           ),
//         ),
//         backgroundColor: logoColor,
//         centerTitle: true,
//         title: Text(
//           "My Cart",
//           style: TextStyle(
//             fontSize: ScreenUtil().setSp(25),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           margin: EdgeInsets.symmetric(
//             horizontal: ScreenUtil().setSp(20),
//             vertical: ScreenUtil().setSp(10),
//           ),
//           child: Column(
//             children: [
//               Expanded(
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection("Carts")
//                       .doc(FirebaseAuth.instance.currentUser!.uid)
//                       .collection("Products")
//                       .orderBy(
//                         "addedOn",
//                         descending: true,
//                       )
//                       .snapshots(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                         child: const CircularProgressIndicator(),
//                       );
//                     } else if (snapshot.hasData) {
//                       if (snapshot.data!.docs.length > 0) {
//                         return ListView.builder(
//                             // shrinkWrap: true,
//                             // physics: NeverScrollableScrollPhysics(),
//                             itemCount: snapshot.data!.docs.length,
//                             itemBuilder: (context, index) {
//                               CartProductModel cartProductModel =
//                                   CartProductModel.fromMap(
//                                       snapshot.data!.docs[index]);
//                               return Column(
//                                 children: [
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Expanded(
//                                         flex: 3,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Center(
//                                               child: CachedNetworkImage(
//                                                 height: ScreenUtil().setSp(150),
//                                                 width: ScreenUtil().setSp(150),
//                                                 fit: BoxFit.fitWidth,
//                                                 imageUrl: cartProductModel.url,
//                                                 placeholder: (context, url) =>
//                                                     Image.asset(
//                                                   "assets/images/placeholder.png",
//                                                   height:
//                                                       ScreenUtil().setSp(150),
//                                                   width:
//                                                       ScreenUtil().setSp(150),
//                                                 ),
//                                               ),
//                                             ),
//                                             const OurSizedBox(),
//                                             Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   "Name:",
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize:
//                                                         ScreenUtil().setSp(20),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   width:
//                                                       ScreenUtil().setSp(17.5),
//                                                 ),
//                                                 Expanded(
//                                                   child: Text(
//                                                     cartProductModel.name,
//                                                     style: TextStyle(
//                                                       fontSize: ScreenUtil()
//                                                           .setSp(17.5),
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                             const OurSizedBox(),
//                                             Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   "Price:",
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize:
//                                                         ScreenUtil().setSp(20),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   width:
//                                                       ScreenUtil().setSp(17.5),
//                                                 ),
//                                                 Expanded(
//                                                   child: Text(
//                                                     "Rs. ${cartProductModel.price.toString()}",
//                                                     style: TextStyle(
//                                                       fontSize: ScreenUtil()
//                                                           .setSp(17.5),
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 IconButton(
//                                                   color: logoColor,
//                                                   onPressed: () async {
//                                                     if (cartProductModel
//                                                             .quantity >
//                                                         1) {
//                                                       await Firestore()
//                                                           .decreaseProductCount(
//                                                               cartProductModel);
//                                                     }
//                                                   },
//                                                   icon: Icon(
//                                                     Icons.remove,
//                                                     size:
//                                                         ScreenUtil().setSp(25),
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   cartProductModel.quantity
//                                                       .toString(),
//                                                   style: TextStyle(
//                                                     fontSize:
//                                                         ScreenUtil().setSp(20),
//                                                   ),
//                                                 ),
//                                                 IconButton(
//                                                   onPressed: () async {
//                                                     await Firestore()
//                                                         .increaseProductCount(
//                                                             cartProductModel);
//                                                   },
//                                                   icon: Icon(
//                                                     Icons.add,
//                                                     size:
//                                                         ScreenUtil().setSp(25),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             IconButton(
//                                               onPressed: () async {
//                                                 await Firestore()
//                                                     .deleteItemFromCart(
//                                                         cartProductModel);
//                                               },
//                                               icon: Icon(
//                                                 Icons.delete,
//                                                 color: Colors.red,
//                                                 size: ScreenUtil().setSp(
//                                                   25,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const OurSizedBox(),
//                                   const Divider(),
//                                   const OurSizedBox(),
//                                 ],
//                               );
//                             });
//                       } else {
//                         return const Center(child: const Text("No Data"));
//                       }
//                     }
//                     return const Text("data");
//                   },
//                 ),
//               ),
//               StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//                 stream: FirebaseFirestore.instance
//                     .collection("Users")
//                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
//                         snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   } else if (snapshot.hasData) {
//                     if (snapshot.data!.exists) {
//                       FirebaseUserModel firebaseUserModel =
//                           FirebaseUserModel.fromMap(snapshot.data!.data()!);
//                       return Row(
//                         children: [
//                           const Expanded(
//                             child: OurShimmerText(title: "Total Price:"),
//                           ),
//                           Expanded(
//                             child: Text(
//                               firebaseUserModel.currentCartPrice.toString(),
//                               style: TextStyle(
//                                 fontSize: ScreenUtil().setSp(20),
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           )
//                         ],
//                       );
//                     }
//                   }
//                   return const Text("data");
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         margin: EdgeInsets.symmetric(
//           horizontal: ScreenUtil().setSp(20),
//           vertical: ScreenUtil().setSp(10),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: OurElevatedButton(
//                 title: "Clear Cart",
//                 function: () async {
//                   await Firestore().clearCart();
//                   // print(Get.find<OrderCartController>().orderCart);
//                 },
//               ),
//             ),
//             SizedBox(
//               width: ScreenUtil().setSp(20),
//             ),
//             Expanded(
//               child: OurElevatedButton(
//                 title: "Check Out",
//                 function: () async {
//                   // await Firestore().orderProductDetail();
//                   var abc = await FirebaseFirestore.instance
//                       .collection("Users")
//                       .doc(FirebaseAuth.instance.currentUser!.uid)
//                       .get();
//                   int def = abc.data()!["cartItemNo"];
//                   if (def == 0) {
//                     OurToast().showErrorToast("Oops, cart is empty");
//                   } else {
//                     PermissionStatus _status =
//                         await Permission.location.request();

//                     if (_status.isPermanentlyDenied) {
//                       AppSettings.openAppSettings();
//                     }
//                     if (!_status.isGranted) {
//                       await Permission.location.request();
//                     } else {
//                       try {
//                         Position newPosition =
//                             await Geolocator.getCurrentPosition(
//                                 desiredAccuracy: LocationAccuracy.high);
//                         Get.to(
//                           CheckOutScreen(
//                             userPosition: newPosition,
//                           ),
//                           // LocationAppExample(),
//                           transition: Transition.rightToLeft,
//                         );
//                         OurToast().showSuccessToast("Cart has Item");
//                       } catch (e) {
//                         print(e.toString());
//                       }
//                     }
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
