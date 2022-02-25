// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:myapp/model/product_model.dart';
// import 'package:myapp/services/firestore/firestore.dart';
// import 'package:myapp/utils/colors.dart';
// import 'package:myapp/widgets/our_sized_box.dart';

// class FavoriteScreen extends StatefulWidget {
//   const FavoriteScreen({Key? key}) : super(key: key);

//   @override
//   _FavoriteScreenState createState() => _FavoriteScreenState();
// }

// class _FavoriteScreenState extends State<FavoriteScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: logoColor,
//         centerTitle: true,
//         title: Text(
//           "Favorite Items",
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
//           child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection("Users")
//                 .doc(FirebaseAuth.instance.currentUser!.uid)
//                 .collection("Favorites")
//                 .orderBy("timestamp", descending: true)
//                 .snapshots(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (snapshot.hasData) {
//                 if (snapshot.data!.docs.length > 0) {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       String uid = snapshot.data!.docs[index]["uid"];
//                       return StreamBuilder(
//                         stream: FirebaseFirestore.instance
//                             .collection("Products")
//                             .where("uid", isEqualTo: uid)
//                             .snapshots(),
//                         builder:
//                             (BuildContext context, AsyncSnapshot snapshot) {
//                           if (snapshot.hasData) {
//                             if (snapshot.data!.docs.length > 0) {
//                               ProductModel productModel =
//                                   ProductModel.fromMap(snapshot.data!.docs[0]);
//                               return Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   OurSizedBox(),
//                                   Row(
//                                     children: [
//                                       CachedNetworkImage(
//                                         height: ScreenUtil().setSp(150),
//                                         width: ScreenUtil().setSp(150),
//                                         fit: BoxFit.contain,
//                                         imageUrl: productModel.url,
//                                         placeholder: (context, url) =>
//                                             Image.asset(
//                                           "assets/images/placeholder.png",
//                                           height: ScreenUtil().setSp(150),
//                                           width: ScreenUtil().setSp(150),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: ScreenUtil().setSp(20),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             productModel.name,
//                                             style: TextStyle(
//                                               fontSize: ScreenUtil().setSp(15),
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             softWrap: true,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                           OurSizedBox(),
//                                           Text(
//                                             productModel.desc,
//                                             style: TextStyle(
//                                               fontSize: ScreenUtil().setSp(15),
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             softWrap: true,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                           OurSizedBox(),
//                                           Text(
//                                             "Rs. ${productModel.price.toString()}",
//                                             style: TextStyle(
//                                               fontSize: ScreenUtil().setSp(15),
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             softWrap: true,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ],
//                                       ),
//                                       Spacer(),
//                                       productModel.favorite.contains(
//                                               FirebaseAuth
//                                                   .instance.currentUser!.uid)
//                                           ? IconButton(
//                                               onPressed: () async {
//                                                 await Firestore()
//                                                     .removeFavorite(
//                                                         productModel);
//                                               },
//                                               icon: Icon(
//                                                 Icons.favorite,
//                                                 size: ScreenUtil().setSp(30),
//                                                 color: Colors.red,
//                                               ),
//                                             )
//                                           : IconButton(
//                                               onPressed: () async {
//                                                 await Firestore()
//                                                     .addFavorite(productModel);
//                                               },
//                                               icon: Icon(
//                                                 Icons.favorite_border_outlined,
//                                                 size: ScreenUtil().setSp(30),
//                                                 color: Colors.red,
//                                               ),
//                                             ),
//                                     ],
//                                   ),
//                                   OurSizedBox(),
//                                   Divider(),
//                                 ],
//                               );
//                             } else {
//                               return Center(
//                                 child: Text(
//                                   "No Data",
//                                 ),
//                               );
//                             }
//                           } else {
//                             return Center(child: CircularProgressIndicator());
//                           }
//                         },
//                       );
//                     },
//                   );
//                 } else {
//                   return Center(
//                     child: Text(
//                       "No Data",
//                     ),
//                   );
//                 }
//               } else {
//                 return Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
