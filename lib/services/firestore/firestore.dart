// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:intl/intl.dart';
// import 'package:myapp/controller/authentication_controller.dart';
// import 'package:myapp/controller/order_cart_controller.dart';
// import 'package:myapp/db/db_helper.dart';
// import 'package:myapp/model/cart_product_model.dart';
// import 'package:myapp/model/firebase_user_model.dart';
// import 'package:myapp/model/order_product_detail.dart';
// import 'package:myapp/model/product_model.dart';
// import 'package:myapp/model/user_model.dart';
// import 'package:myapp/screen/dashboard_screens/dashboard_screen.dart';
// import 'package:myapp/widgets/our_flutter_toast.dart';
// import 'package:uuid/uuid.dart';

// class Firestore {
//   addUser(UserModel userModel, String url) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("Users")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .set({
//         "uid": FirebaseAuth.instance.currentUser!.uid,
//         "email": userModel.email,
//         "name": userModel.name,
//         "AddedOn": DateFormat('yyy-MM-dd').format(
//           DateTime.now(),
//         ),
//         "password": userModel.password,
//         "imageUrl": url,
//         "phone": userModel.phone,
//         "location": userModel.location,
//         "cartItems": [],
//         "favorite": [],
//         "cartItemNo": 0,
//         "currentCartPrice": 0.0,
//       }).then((value) {
//         print("Done ==========================");
//         Get.find<AuthenticationController>().toggle(false);
//         Hive.box<int>(authenticationDB).put("state", 1);
//         Get.off(const DashBoardScreen());
//       });
//     } catch (e) {
//       print(e);
//       OurToast().showErrorToast(e.toString());
//       Get.find<AuthenticationController>().toggle(false);
//     }
//   }

//   addProduct(String name, String desc, double price, String url) async {
//     List<String> searchList = [];
//     for (int i = 0; i <= name.length; i++) {
//       searchList.add(
//         name.substring(0, i).toLowerCase(),
//       );
//     }
//     String uid = const Uuid().v4();
//     try {
//       await FirebaseFirestore.instance.collection("Products").doc(uid).set({
//         "uid": uid,
//         "name": name,
//         "desc": desc,
//         "price": price,
//         "rating": 0.0,
//         "url": url,
//         "addedOn": DateFormat('yyy-MM-dd').format(
//           DateTime.now(),
//         ),
//         "ratingUID": [],
//         "ratingNo": 0,
//         "timestamp": Timestamp.now(),
//         "favorite": [],
//         "searchfrom": searchList,
//       }).then((value) {
//         OurToast().showSuccessToast("Product added");
//       });
//     } catch (e) {
//       OurToast().showErrorToast(e.toString());
//     }
//   }

//   addReview(String review, String productId, String name) async {
//     String uid = const Uuid().v4();
//     try {
//       await FirebaseFirestore.instance
//           .collection("Products")
//           .doc(productId)
//           .collection("Reviews")
//           .doc(uid)
//           .set({
//         "uid": uid,
//         "senderName": name,
//         "senderId": FirebaseAuth.instance.currentUser!.uid,
//         "review": review,
//         "timestamp": Timestamp.now(),
//       });
//     } catch (e) {
//       OurToast().showErrorToast(
//         e.toString(),
//       );
//     }
//   }

//   addRating(ProductModel product, double rating) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("Rating")
//           .doc(product.uid)
//           .collection("Ratings")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .set({"rating": rating}).then(
//         (value) => print("Inside Add rating function done"),
//       );
//     } catch (e) {}
//   }

//   updateRatingNo(ProductModel product) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("Products")
//           .doc(product.uid)
//           .update({
//         "ratingUID":
//             FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
//         "ratingNo": product.ratingNo + 1,
//       }).then((value) => print("Inside UpdateRatingNo done"));
//     } catch (e) {}
//   }

//   updateProductRating(ProductModel product) async {
//     double finalRating = 0.0;
//     int totalNum = 0;
//     QuerySnapshot abc = await FirebaseFirestore.instance
//         .collection("Rating")
//         .doc(product.uid)
//         .collection("Ratings")
//         .get();

//     abc.docs.forEach((element) {
//       finalRating = finalRating + element["rating"];
//     });

//     var b = await FirebaseFirestore.instance
//         .collection("Products")
//         .doc(product.uid)
//         .get();
//     totalNum = b["ratingNo"];
//     try {
//       await FirebaseFirestore.instance
//           .collection("Products")
//           .doc(product.uid)
//           .update({"rating": finalRating / totalNum}).then(
//               (value) => print("Inside UpdateRatingNo done"));
//     } catch (e) {}
//   }

//   addItemToCart(
//       FirebaseUserModel firebaseUserModel, ProductModel product) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("Users")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .update({
//         "cartItems": FieldValue.arrayUnion([product.uid]),
//         "cartItemNo": firebaseUserModel.cartItemNo + 1,
//         "currentCartPrice": firebaseUserModel.currentCartPrice + product.price
//       }).then((value) async {
//         await FirebaseFirestore.instance
//             .collection("Carts")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection("Products")
//             .doc(product.uid)
//             .set({
//           "uid": product.uid,
//           "name": product.name,
//           "desc": product.desc,
//           "url": product.url,
//           "price": product.price,
//           "addedOn": Timestamp.now(),
//           "quantity": 1,
//         });

//         OurToast().showSuccessToast("Product Added to cart");
//       });
//     } catch (e) {
//       OurToast().showErrorToast(e.toString());
//     }
//   }

//   removeItemFromCart(
//       FirebaseUserModel firebaseUserModel, ProductModel product) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("Users")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .update({
//         "cartItems": FieldValue.arrayRemove([product.uid]),
//         "cartItemNo": firebaseUserModel.cartItemNo - 1,
//       }).then((value) async {
//         var abc = await FirebaseFirestore.instance
//             .collection("Carts")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection("Products")
//             .doc(product.uid)
//             .get();
//         CartProductModel cartProductModel = CartProductModel.fromMap(abc);
//         await FirebaseFirestore.instance
//             .collection("Users")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .update({
//           "currentCartPrice": firebaseUserModel.currentCartPrice -
//               cartProductModel.price * cartProductModel.quantity,
//         });
//         // await FirebaseFirestore.instance
//         //     .collection("Carts")
//         //     .doc(FirebaseAuth.instance.currentUser!.uid)
//         //     .collection("Products")
//         //     .doc(product.uid)
//         //     .delete();

//         OurToast().showSuccessToast("Product removed from cart");
//       });
//     } catch (e) {
//       OurToast().showErrorToast(e.toString());
//     }
//   }

//   increaseProductCount(CartProductModel cartProductModel) async {
//     double totalPrice = 0.0;
//     await FirebaseFirestore.instance
//         .collection("Carts")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection("Products")
//         .doc(cartProductModel.uid)
//         .update({
//       "quantity": cartProductModel.quantity + 1,
//     }).then((value) async {
//       var collection = await FirebaseFirestore.instance
//           .collection("Carts")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection("Products")
//           .get();
//       for (var doc in collection.docs) {
//         var abc = doc.data();
//         CartProductModel cartProductModel =
//             CartProductModel.toIncreaseorDecrease(doc.data());
//         totalPrice =
//             totalPrice + cartProductModel.price * cartProductModel.quantity;
//       }
//       await FirebaseFirestore.instance
//           .collection("Users")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .update({"currentCartPrice": totalPrice});
//     });
//   }

//   decreaseProductCount(CartProductModel cartProductModel) async {
//     double totalPrice = 0.0;

//     await FirebaseFirestore.instance
//         .collection("Carts")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection("Products")
//         .doc(cartProductModel.uid)
//         .update({
//       "quantity": cartProductModel.quantity - 1,
//     }).then((value) async {
//       var collection = await FirebaseFirestore.instance
//           .collection("Carts")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection("Products")
//           .get();
//       for (var doc in collection.docs) {
//         var abc = doc.data();
//         CartProductModel cartProductModel =
//             CartProductModel.toIncreaseorDecrease(doc.data());
//         totalPrice =
//             totalPrice + cartProductModel.price * cartProductModel.quantity;
//       }
//       await FirebaseFirestore.instance
//           .collection("Users")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .update(
//         {
//           "currentCartPrice": totalPrice,
//         },
//       );
//     });
//   }

//   deleteItemFromCart(CartProductModel cartProductModel) async {
//     try {
//       var data = await FirebaseFirestore.instance
//           .collection("Users")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .get();

//       var cartItemNo = data.data()!["cartItemNo"];
//       await FirebaseFirestore.instance
//           .collection("Users")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .update({
//         "cartItems": FieldValue.arrayRemove([cartProductModel.uid]),
//         "cartItemNo": cartItemNo - 1,
//       }).then((value) async {
//         await FirebaseFirestore.instance
//             .collection("Carts")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection("Products")
//             .doc(cartProductModel.uid)
//             .delete();
//         var data = await FirebaseFirestore.instance
//             .collection("Users")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .get();

//         var currentCartPrice = data.data()!["currentCartPrice"];
//         await FirebaseFirestore.instance
//             .collection("Users")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .update({
//           "currentCartPrice": currentCartPrice -
//               cartProductModel.price * cartProductModel.quantity,
//         });
//         OurToast().showSuccessToast("Product removed from cart");
//       });
//     } catch (e) {
//       OurToast().showErrorToast(e.toString());
//     }
//   }

//   clearCart() async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("Users")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .update({
//         "cartItems": [],
//         "cartItemNo": 0,
//       }).then((value) async {
//         var collection = await FirebaseFirestore.instance
//             .collection("Carts")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection("Products")
//             .get();
//         // .delete();

//         for (var doc in collection.docs) {
//           // FirebaseFirestore.instance.batch().delete(doc.reference);
//           await doc.reference.delete();
//           // .collection("Carts")
//           // .doc(FirebaseAuth.instance.currentUser!.uid).
//         }
//         await FirebaseFirestore.instance
//             .collection("Users")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .update({
//           "currentCartPrice": 0.0,
//         });
//         await FirebaseFirestore.instance
//             .collection("Carts")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .delete();
//         OurToast().showSuccessToast("Product removed from cart");
//       });
//     } catch (e) {
//       OurToast().showErrorToast(e.toString());
//     }
//   }

//   addFavorite(ProductModel productModel) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("Products")
//           .doc(productModel.uid)
//           .update({
//         "favorite": FieldValue.arrayUnion(
//           [FirebaseAuth.instance.currentUser!.uid],
//         ),
//       }).then((value) async {
//         await FirebaseFirestore.instance
//             .collection("Users")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection("Favorites")
//             .doc(productModel.uid)
//             .set(
//           {"uid": productModel.uid, "timestamp": Timestamp.now()},
//         );
//         OurToast().showSuccessToast("Added to favorite list");
//       });
//     } catch (e) {
//       OurToast().showErrorToast(e.toString());
//     }
//   }

//   removeFavorite(ProductModel productModel) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("Products")
//           .doc(productModel.uid)
//           .update({
//         "favorite": FieldValue.arrayRemove(
//           [FirebaseAuth.instance.currentUser!.uid],
//         ),
//       }).then((value) async {
//         await FirebaseFirestore.instance
//             .collection("Users")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection("Favorites")
//             .doc(productModel.uid)
//             .delete();
//         OurToast().showErrorToast("Removed from favotite list");
//       });
//     } catch (e) {
//       OurToast().showErrorToast(e.toString());
//     }
//   }

//   placeOrder(
//     String name,
//     String phone,
//     String email,
//     String? country,
//     String? postalCode,
//     String? adminArea,
//     String? subAdminArea,
//     String? locality,
//     String? subLocality,
//     double longitude,
//     double latitude,
//   ) async {
//     String orderUID = Uuid().v4();
//     String verifyUID = Uuid().v4().substring(0, 6);
//     var collection = await FirebaseFirestore.instance
//         .collection("Carts")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection("Products")
//         .get();

//     var data = await FirebaseFirestore.instance
//         .collection("Users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();

//     var price = data.data()!["currentCartPrice"];

//     for (var doc in collection.docs) {
//       var abc = doc.data();
//       OrderProductDetail orderProductDetail = OrderProductDetail(
//           name: abc["name"],
//           url: abc["url"],
//           price: abc["price"],
//           quantity: abc["quantity"]);
//       Get.find<OrderCartController>().addToCart(orderProductDetail);
//     }
//     await FirebaseFirestore.instance
//         .collection("Users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection("MyOrders")
//         .doc(orderUID)
//         .set({
//       "orderUID": orderUID,
//       "ownerUID": FirebaseAuth.instance.currentUser!.uid,
//       "name": name,
//       "phone": phone,
//       "email": email,
//       "country": country ?? "",
//       "postalCode": postalCode ?? "",
//       "adminArea": adminArea ?? "",
//       "subAdminArea": subAdminArea ?? "",
//       "locality": locality ?? "",
//       "subLocality": subLocality ?? "",
//       "longitude": longitude,
//       "latitude": latitude,
//       "verifyUID": verifyUID,
//       "riderUID": "",
//       "riderName": "",
//       "riderPhone": "",
//       "orderState": "processing",
//       "items": Get.find<OrderCartController>().orderCart,
//       "price": price,
//       "orderPlaced": DateTime.now(),
//       "timestamp": Timestamp.now()
//     });
//     await FirebaseFirestore.instance.collection("Orders").doc(orderUID).set({
//       "orderUID": orderUID,
//       "ownerUID": FirebaseAuth.instance.currentUser!.uid,
//       "name": name,
//       "phone": phone,
//       "email": email,
//       "country": country ?? "",
//       "postalCode": postalCode ?? "",
//       "adminArea": adminArea ?? "",
//       "subAdminArea": subAdminArea ?? "",
//       "locality": locality ?? "",
//       "subLocality": subLocality ?? "",
//       "longitude": longitude,
//       "latitude": latitude,
//       "verifyUID": verifyUID,
//       "riderUID": "",
//       "riderName": "",
//       "riderPhone": "",
//       "orderState": "processing",
//       "items": Get.find<OrderCartController>().orderCart,
//       "price": price,
//       "orderPlaced": DateTime.now(),
//       "timestamp": Timestamp.now()
//     });
//     clearCart();
//     Get.find<OrderCartController>().clearCart();
//     // Get.off(DashBoardScreen());
//     OurToast().showSuccessToast("Order placed successfully.");
//   }
// }
