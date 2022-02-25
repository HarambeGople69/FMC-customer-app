// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_stars/flutter_rating_stars.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:myapp/controller/authentication_controller.dart';
// import 'package:myapp/model/firebase_user_model.dart';
// import 'package:myapp/model/product_model.dart';
// import 'package:myapp/model/review_model.dart';
// import 'package:myapp/services/firestore/firestore.dart';
// import 'package:myapp/utils/colors.dart';
// import 'package:myapp/widgets/our_elevated_button.dart';
// import 'package:myapp/widgets/our_flutter_toast.dart';
// import 'package:myapp/widgets/our_shimmer_text.dart';
// import 'package:myapp/widgets/our_sized_box.dart';
// import 'package:myapp/widgets/our_text_field.dart';
// import 'package:timeago/timeago.dart' as timeago;

// class OurDetailProductScreen extends StatefulWidget {
//   final ProductModel productModelUID;
//   const OurDetailProductScreen({
//     Key? key,
//     required this.productModelUID,
//   }) : super(key: key);

//   @override
//   _OurDetailProductScreenState createState() => _OurDetailProductScreenState();
// }

// class _OurDetailProductScreenState extends State<OurDetailProductScreen> {
//   AuthenticationController authenticationController =
//       Get.put(AuthenticationController());
//   TextEditingController _review_Controller = TextEditingController();
//   void GiveRatingSheet(context) {
//     showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (context) {
//           return Container(
//             height: MediaQuery.of(context).size.height * 0.75,
//             margin: EdgeInsets.symmetric(
//               horizontal: ScreenUtil().setSp(20),
//               vertical: ScreenUtil().setSp(15),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const OurShimmerText(
//                   title: "Reviews",
//                 ),
//                 const OurSizedBox(),
//                 Expanded(
//                   child: StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection("Products")
//                         .doc(widget.productModelUID.uid)
//                         .collection("Reviews")
//                         .orderBy(
//                           "timestamp",
//                           descending: true,
//                         )
//                         .snapshots(),
//                     builder: (BuildContext context, AsyncSnapshot snapshot) {
//                       if (snapshot.hasData) {
//                         if (snapshot.data!.docs.length > 0) {
//                           return ListView.builder(
//                               itemCount: snapshot.data!.docs.length,
//                               itemBuilder: (context, index) {
//                                 ReviewModel reviewModel = ReviewModel.fromMap(
//                                     snapshot.data!.docs[index]);
//                                 return InkWell(
//                                   onLongPress: () async {
//                                     if (reviewModel.senderId ==
//                                         FirebaseAuth
//                                             .instance.currentUser!.uid) {
//                                       await FirebaseFirestore.instance
//                                           .collection("Products")
//                                           .doc(widget.productModelUID.uid)
//                                           .collection("Reviews")
//                                           .doc(reviewModel.uid)
//                                           .delete();
//                                       OurToast()
//                                           .showErrorToast("Review Deleted");
//                                     }
//                                   },
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Expanded(
//                                             flex: 3,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   reviewModel.senderName,
//                                                   style: TextStyle(
//                                                     fontSize: ScreenUtil()
//                                                         .setSp(17.5),
//                                                     fontWeight: FontWeight.w600,
//                                                   ),
//                                                 ),
//                                                 const OurSizedBox(),
//                                                 Text(
//                                                   reviewModel.review,
//                                                   style: TextStyle(
//                                                     fontSize:
//                                                         ScreenUtil().setSp(15),
//                                                     fontWeight: FontWeight.w400,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               timeago.format(
//                                                 reviewModel.timestamp.toDate(),
//                                               ),
//                                               style: TextStyle(
//                                                 fontSize:
//                                                     ScreenUtil().setSp(12.5),
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const OurSizedBox(),
//                                       const Divider(),
//                                       const OurSizedBox(),
//                                     ],
//                                   ),
//                                 );
//                               });
//                         } else {
//                           return const Text("No Reviews yet");
//                         }
//                       } else if (snapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       return const CircularProgressIndicator();
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: MediaQuery.of(context).viewInsets.bottom),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: CustomTextField(
//                           icon: Icons.reviews,
//                           controller: _review_Controller,
//                           validator: (value) {},
//                           title: "Give Review",
//                           type: TextInputType.name,
//                           number: 1,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () async {
//                           if (_review_Controller.text.trim().isNotEmpty) {
//                             Get.find<AuthenticationController>().toggle(true);
//                             var data = await FirebaseFirestore.instance
//                                 .collection("Users")
//                                 .doc(FirebaseAuth.instance.currentUser!.uid)
//                                 .get();

//                             var name = data.data()!["name"];
//                             await Firestore().addReview(
//                               _review_Controller.text.trim(),
//                               widget.productModelUID.uid,
//                               name,
//                             );
//                             _review_Controller.clear();
//                             FocusManager.instance.primaryFocus?.unfocus();
//                             Get.find<AuthenticationController>().toggle(false);
//                           } else {
//                             OurToast().showErrorToast("Review can't be empty");
//                           }
//                         },
//                         icon: Icon(
//                           Icons.send,
//                           color: logoColor,
//                           size: ScreenUtil().setSp(30),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   Future<void> _showMyDialog(double rate, bool exists) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: true, // user must tap button!
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: OurShimmerText(
//                 title: "Give Rating",
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   RatingStars(
//                     onValueChanged: (value) {
//                       setState(() {
//                         rate = value;
//                       });
//                     },
//                     value: rate,
//                     starBuilder: (index, color) => Icon(
//                       Icons.star,
//                       color: color,
//                       size: ScreenUtil().setSp(25),
//                     ),
//                     starCount: 5,
//                     starSize: ScreenUtil().setSp(20),
//                     valueLabelColor: const Color(0xff9b9b9b),
//                     valueLabelTextStyle: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w400,
//                       fontStyle: FontStyle.normal,
//                       fontSize: ScreenUtil().setSp(15),
//                     ),
//                     valueLabelRadius: ScreenUtil().setSp(20),
//                     maxValue: 5,
//                     starSpacing: ScreenUtil().setSp(10),
//                     maxValueVisibility: true,
//                     valueLabelVisibility: true,
//                     animationDuration: const Duration(milliseconds: 1000),
//                     valueLabelPadding: EdgeInsets.symmetric(
//                       vertical: ScreenUtil().setSp(5),
//                       horizontal: ScreenUtil().setSp(5),
//                     ),
//                     valueLabelMargin: EdgeInsets.only(
//                       right: ScreenUtil().setSp(3),
//                     ),
//                     starOffColor: const Color(0xffe7e8ea),
//                     starColor: Colors.yellow,
//                   ),
//                 ],
//               ),
//               actions: <Widget>[
//                 OurElevatedButton(
//                     title: "Submit",
//                     function: () async {
//                       await Firestore().addRating(widget.productModelUID, rate);
//                       if (!exists) {
//                         await Firestore()
//                             .updateRatingNo(widget.productModelUID);
//                       }
//                       await Firestore()
//                           .updateProductRating(widget.productModelUID);
//                       Navigator.pop(context);
//                     }),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Obx(
//         () => ModalProgressHUD(
//           progressIndicator: SpinKitFadingCircle(
//             size: ScreenUtil().setSp(60),
//             itemBuilder: (BuildContext context, int index) {
//               return DecoratedBox(
//                 decoration: BoxDecoration(
//                   color: index.isEven ? logoColor : Colors.green,
//                 ),
//               );
//             },
//           ),
//           inAsyncCall: Get.find<AuthenticationController>().processing.value,
//           child: Scaffold(
//             body: SafeArea(
//               child: SingleChildScrollView(
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection("Products")
//                       .where("uid", isEqualTo: widget.productModelUID.uid)
//                       .snapshots(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (snapshot.hasData) {
//                       if (snapshot.data!.docs.length > 0) {
//                         ProductModel productModel =
//                             ProductModel.fromMap(snapshot.data!.docs[0]);
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Stack(
//                               children: [
//                                 Container(
//                                   color: Colors.grey.withOpacity(0.3),
//                                   width: MediaQuery.of(context).size.width,
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.3,
//                                   child: Container(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.2,
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.7,
//                                     child: CachedNetworkImage(
//                                       height: ScreenUtil().setSp(150),
//                                       width: ScreenUtil().setSp(150),
//                                       fit: BoxFit.fitWidth,
//                                       imageUrl: productModel.url,
//                                       placeholder: (context, url) =>
//                                           Image.asset(
//                                         "assets/images/placeholder.png",
//                                         height: ScreenUtil().setSp(150),
//                                         width: ScreenUtil().setSp(150),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.symmetric(
//                                     horizontal: ScreenUtil().setSp(10),
//                                     vertical: ScreenUtil().setSp(10),
//                                   ),
//                                   height: ScreenUtil().setSp(40),
//                                   width: ScreenUtil().setSp(40),
//                                   decoration: BoxDecoration(
//                                       color: Theme.of(context)
//                                           .scaffoldBackgroundColor,
//                                       shape: BoxShape.circle),
//                                   child: IconButton(
//                                     onPressed: () {
//                                       Get.back();
//                                     },
//                                     icon: Icon(
//                                       Icons.arrow_back,
//                                       size: ScreenUtil().setSp(25),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const OurSizedBox(),
//                             Container(
//                               margin: EdgeInsets.symmetric(
//                                 horizontal: ScreenUtil().setSp(20),
//                                 vertical: ScreenUtil().setSp(10),
//                               ),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Name:",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: ScreenUtil().setSp(20),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: ScreenUtil().setSp(17.5),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           productModel.name,
//                                           style: TextStyle(
//                                             fontSize: ScreenUtil().setSp(17.5),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   const OurSizedBox(),
//                                   const Divider(),
//                                   const OurSizedBox(),
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Description:",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: ScreenUtil().setSp(20),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: ScreenUtil().setSp(17.5),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           productModel.desc,
//                                           style: TextStyle(
//                                             fontSize: ScreenUtil().setSp(17.5),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   const OurSizedBox(),
//                                   const Divider(),
//                                   const OurSizedBox(),
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Price:",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: ScreenUtil().setSp(20),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: ScreenUtil().setSp(17.5),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           "Rs. ${productModel.price.toString()}",
//                                           style: TextStyle(
//                                             fontSize: ScreenUtil().setSp(17.5),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   const OurSizedBox(),
//                                   const Divider(),
//                                   const OurSizedBox(),
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Rating:",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: ScreenUtil().setSp(20),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: ScreenUtil().setSp(17.5),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           productModel.rating.toString(),
//                                           style: TextStyle(
//                                             fontSize: ScreenUtil().setSp(17.5),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   const OurSizedBox(),
//                                   const Divider(),
//                                   const OurSizedBox(),
//                                   Row(
//                                     children: [
//                                       RatingStars(
//                                         value: productModel.rating.toDouble(),
//                                         starBuilder: (index, color) => Icon(
//                                           Icons.star,
//                                           color: color,
//                                           size: ScreenUtil().setSp(20),
//                                         ),
//                                         starCount: 5,
//                                         starSize: ScreenUtil().setSp(17),
//                                         valueLabelColor:
//                                             const Color(0xff9b9b9b),
//                                         valueLabelTextStyle: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w400,
//                                           fontStyle: FontStyle.normal,
//                                           fontSize: ScreenUtil().setSp(17),
//                                         ),
//                                         valueLabelRadius:
//                                             ScreenUtil().setSp(20),
//                                         maxValue: 5,
//                                         starSpacing: 1,
//                                         maxValueVisibility: true,
//                                         valueLabelVisibility: true,
//                                         animationDuration:
//                                             const Duration(milliseconds: 1000),
//                                         valueLabelPadding: EdgeInsets.symmetric(
//                                           vertical: ScreenUtil().setSp(5),
//                                           horizontal: ScreenUtil().setSp(5),
//                                         ),
//                                         valueLabelMargin: EdgeInsets.only(
//                                           right: ScreenUtil().setSp(3),
//                                         ),
//                                         starOffColor: const Color(0xffe7e8ea),
//                                         starColor: Colors.yellow,
//                                       ),
//                                       const Spacer(),
//                                       OurElevatedButton(
//                                         title: "Give Rating",
//                                         function: () async {
//                                           if (productModel.ratingUID.contains(
//                                               FirebaseAuth
//                                                   .instance.currentUser!.uid)) {
//                                             var a = await FirebaseFirestore
//                                                 .instance
//                                                 .collection("Rating")
//                                                 .doc(productModel.uid)
//                                                 .collection("Ratings")
//                                                 .doc(FirebaseAuth
//                                                     .instance.currentUser!.uid)
//                                                 .get();

//                                             var rate = a.data()!["rating"];
//                                             _showMyDialog(rate, true);

//                                             OurToast().showSuccessToast(
//                                                 "UID Contains");
//                                           } else {
//                                             OurToast().showErrorToast(
//                                                 "UID Doesn't contains");
//                                             _showMyDialog(0.0, false);
//                                           }
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   const OurSizedBox(),
//                                   const Divider(),
//                                   const OurSizedBox(),
//                                   OurElevatedButton(
//                                     title: "Give Review",
//                                     function: () {
//                                       GiveRatingSheet(context);
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         );
//                       } else {}
//                     }
//                     return Text("data");
//                   },
//                 ),
//               ),
//             ),
//             bottomNavigationBar: Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: ScreenUtil().setSp(20),
//                 vertical: ScreenUtil().setSp(10),
//               ),
//               child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//                 stream: FirebaseFirestore.instance
//                     .collection("Users")
//                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
//                         snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator();
//                   } else if (snapshot.hasData) {
//                     if (snapshot.data!.exists) {
//                       FirebaseUserModel firebaseUserModel =
//                           FirebaseUserModel.fromMap(snapshot.data!.data()!);
//                       if (firebaseUserModel.cartItems
//                           .contains(widget.productModelUID.uid)) {
//                         return OurElevatedButton(
//                           title: "Remove from cart",
//                           function: () async {
//                             await Firestore().removeItemFromCart(
//                                 firebaseUserModel, widget.productModelUID);
//                           },
//                         );
//                       } else {
//                         return OurElevatedButton(
//                           title: "Add to cart",
//                           function: () async {
//                             await Firestore().addItemToCart(
//                                 firebaseUserModel, widget.productModelUID);
//                           },
//                         );
//                       }
//                     }
//                   }
//                   return const Text("data");
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
