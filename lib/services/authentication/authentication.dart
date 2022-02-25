// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:myapp/controller/authentication_controller.dart';
// import 'package:myapp/db/db_helper.dart';
// import 'package:myapp/model/user_model.dart';
// import 'package:myapp/screen/authentication_screen/login_screen.dart';
// import 'package:myapp/screen/dashboard_screens/dashboard_screen.dart';
// import 'package:myapp/services/addImages/profile_image..dart';
// import 'package:myapp/services/firestore/firestore.dart';
// import 'package:myapp/widgets/our_flutter_toast.dart';

// class Auth {
//   createAccount(UserModel userModel, File file) async {
//     try {
//       await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//         email: userModel.email,
//         password: userModel.password,
//       )
//           .then((value) async {
//         String? url = await AddProfile().uploadImage(file);
//         Firestore().addUser(userModel, url!);
//         OurToast().showSuccessToast("User signed successfully");
//       });
//     } on FirebaseAuthException catch (e) {
//       Get.find<AuthenticationController>().toggle(false);

//       OurToast().showErrorToast(e.message!);
//     }
//   }

//   loginAccount(String email, String password) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password)
//           .then((value) {
//         Get.find<AuthenticationController>().toggle(false);

//         OurToast().showSuccessToast("User signed successfully");
//         Get.off(
//           const DashBoardScreen(),
//         );

//         Hive.box<int>(authenticationDB).put("state", 1);
//       });
//     } on FirebaseAuthException catch (e) {
//       Get.find<AuthenticationController>().toggle(false);

//       OurToast().showErrorToast(e.message!);
//     }
//   }

//   logout() async {
//     try {
//       await FirebaseAuth.instance.signOut().then((value) {
//         OurToast().showSuccessToast("User logged out successfully");
//         Hive.box<int>(authenticationDB).put("state", 0);
//         Get.off(
//           const LoginScreen(),
//         );
//         Get.find<AuthenticationController>().toggle(false);
//       });
//     } on FirebaseAuthException catch (e) {
//       Get.find<AuthenticationController>().toggle(false);

//       OurToast().showErrorToast(e.message!);
//     }
//   }
// }
