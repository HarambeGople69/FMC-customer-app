// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:myapp/model/order_detail_model.dart';
// import 'package:myapp/services/open_map/open_map.dart';
// import 'package:myapp/utils/colors.dart';
// import 'package:myapp/widgets/our_elevated_button.dart';
// import 'package:myapp/widgets/our_shimmer_text.dart';
// import 'package:myapp/widgets/our_sized_box.dart';

// class OrderScreen extends StatefulWidget {
//   const OrderScreen({Key? key}) : super(key: key);

//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: logoColor,
//         centerTitle: true,
//         title: Text(
//           "My Orders",
//           style: TextStyle(
//             fontSize: ScreenUtil().setSp(25),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           margin: EdgeInsets.symmetric(
//             horizontal: ScreenUtil().setSp(10),
//             vertical: ScreenUtil().setSp(10),
//           ),
//           child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//             stream: FirebaseFirestore.instance
//                 .collection("Users")
//                 .doc(FirebaseAuth.instance.currentUser!.uid)
//                 .collection("MyOrders")
//                 .orderBy(
//                   "orderPlaced",
//                   descending: true,
//                 )
//                 .snapshots(),
//             builder: (BuildContext context,
//                 AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: const CircularProgressIndicator(),
//                 );
//               } else if (snapshot.hasData) {
//                 if (snapshot.data!.docs.length > 0) {
//                   return ListView.builder(
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         OrderDetaiModel orderDetaiModel =
//                             OrderDetaiModel.fromMap(
//                           snapshot.data!.docs[index],
//                         );
//                         return Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: lightlogoColor.withOpacity(0.2),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                             horizontal: ScreenUtil().setSp(7.5),
//                             vertical: ScreenUtil().setSp(15),
//                           ),
//                           margin: EdgeInsets.symmetric(
//                             horizontal: ScreenUtil().setSp(5),
//                             vertical: ScreenUtil().setSp(10),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       "Order id:",
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(20),
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       orderDetaiModel.orderUID!,
//                                       softWrap: true,
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(17.5),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const OurSizedBox(),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       "Name:",
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(20),
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       orderDetaiModel.name!,
//                                       softWrap: true,
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(17.5),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const OurSizedBox(),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       "Phone:",
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(20),
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       orderDetaiModel.phone!,
//                                       softWrap: true,
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(17.5),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const OurSizedBox(),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       "Email:",
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(20),
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       orderDetaiModel.email!,
//                                       softWrap: true,
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(17.5),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const OurSizedBox(),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       "Status:",
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(20),
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       orderDetaiModel.orderState!,
//                                       softWrap: true,
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(17.5),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const OurSizedBox(),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       "Verification code:",
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(20),
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       orderDetaiModel.verifyUID!,
//                                       softWrap: true,
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(17.5),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const OurSizedBox(),
//                               Center(
//                                 child: SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.75,
//                                   child: OurElevatedButton(
//                                     title: "View delivery location",
//                                     function: () {
//                                       OpenMap().viewLocation(
//                                         orderDetaiModel.latitude!,
//                                         orderDetaiModel.longitude!,
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               ExpansionTile(
//                                 expandedCrossAxisAlignment:
//                                     CrossAxisAlignment.end,
//                                 textColor: logoColor,
//                                 iconColor: logoColor,
//                                 title: const OurShimmerText(
//                                   title: "Items",
//                                 ),
//                                 children: orderDetaiModel.items!
//                                     .map(
//                                       (e) => Row(
//                                         children: [
//                                           CachedNetworkImage(
//                                             height: ScreenUtil().setSp(100),
//                                             width: ScreenUtil().setSp(100),
//                                             fit: BoxFit.contain,
//                                             imageUrl: e["url"],
//                                             placeholder: (context, url) =>
//                                                 Image.asset(
//                                               "assets/images/placeholder.png",
//                                               height: ScreenUtil().setSp(100),
//                                               width: ScreenUtil().setSp(100),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: ScreenUtil().setSp(10),
//                                           ),
//                                           Expanded(
//                                             flex: 3,
//                                             child: Text(
//                                               e["name"],
//                                               style: TextStyle(
//                                                 fontSize:
//                                                     ScreenUtil().setSp(17.5),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: ScreenUtil().setSp(10),
//                                           ),
//                                           Expanded(
//                                             flex: 2,
//                                             child: Text(
//                                               "Rs.${e["price"].toString()}",
//                                               style: TextStyle(
//                                                 fontSize:
//                                                     ScreenUtil().setSp(17.5),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: ScreenUtil().setSp(10),
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               "X ${e["quantity"].toString()}",
//                                               style: TextStyle(
//                                                 fontSize:
//                                                     ScreenUtil().setSp(17.5),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                     .toList(),
//                               ),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   const Expanded(
//                                     child: OurShimmerText(
//                                       title: "Total Price: ",
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       "Rs ${orderDetaiModel.price!.toString()}",
//                                       softWrap: true,
//                                       style: TextStyle(
//                                         fontSize: ScreenUtil().setSp(17.5),
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );
//                       });
//                 } else {}
//               }
//               return const Center(
//                 child: Text(
//                   "No data",
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
