// import 'dart:io';

// import 'package:email_auth/email_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:myapp/controller/authentication_controller.dart';
// import 'package:myapp/model/user_model.dart';
// import 'package:myapp/services/authentication/authentication.dart';
// import 'package:myapp/services/compress%20image/compress_image.dart';
// import 'package:myapp/utils/colors.dart';
// import 'package:myapp/widgets/our_elevated_button.dart';
// import 'package:myapp/widgets/our_flutter_toast.dart';
// import 'package:myapp/widgets/our_sized_box.dart';
// import 'package:pin_code_text_field/pin_code_text_field.dart';

// class VerificationOtpScreen extends StatefulWidget {
//   final UserModel usermodel;
//   final File file;
//   const VerificationOtpScreen({
//     Key? key,
//     required this.usermodel,required this.file,
//   }) : super(key: key);

//   @override
//   _VerificationOtpScreenState createState() => _VerificationOtpScreenState();
// }

// class _VerificationOtpScreenState extends State<VerificationOtpScreen> {
//   TextEditingController controller = TextEditingController(text: "");
//   verifyOTP() async {
//     print("Inside send OTP screen");
//     Get.find<AuthenticationController>().toggle(true);

//     EmailAuth emailAuth = EmailAuth(sessionName: "Sample session");
//     bool result = await emailAuth.validateOtp(
//         recipientMail: widget.usermodel.email, userOtp: controller.text);
//     if (result) {
//       Auth().createAccount(widget.usermodel,widget.file);
//     } else {
//       OurToast().showSuccessToast("Oops, OTP didn't match");
//       Get.find<AuthenticationController>().toggle(false);
//     }
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
//               child: Container(
//                 margin: EdgeInsets.symmetric(
//                   horizontal: ScreenUtil().setSp(20),
//                   vertical: ScreenUtil().setSp(10),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Container(
//                           height: ScreenUtil().setSp(50),
//                           width: ScreenUtil().setSp(50),
//                           decoration: BoxDecoration(
//                               color: Colors.white, shape: BoxShape.circle),
//                           child: IconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: Icon(
//                               Icons.arrow_back,
//                               color: Colors.black,
//                               size: ScreenUtil().setSp(30),
//                             ),
//                           ),
//                         ),
//                       ),
//                       OurSizedBox(),
//                       Lottie.asset(
//                         "assets/animations/otp_verification.json",
//                         height: ScreenUtil().setSp(200),
//                         width: ScreenUtil().setSp(200),
//                       ),
//                       OurSizedBox(),
//                       Text(
//                         "OTP sent to : ${widget.usermodel.email}",
//                         style: TextStyle(
//                           fontSize: ScreenUtil().setSp(17.5),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       OurSizedBox(),
//                       PinCodeTextField(
//                         // autofocus: true,
//                         controller: controller,
//                         hideCharacter: false,
//                         highlight: true,
//                         highlightColor: Colors.black,
//                         defaultBorderColor: Colors.black,
//                         hasTextBorderColor: lightlogoColor,
//                         highlightPinBoxColor: logoColor,
//                         maxLength: 6,

//                         pinBoxWidth: ScreenUtil().setSp(50),
//                         pinBoxHeight: ScreenUtil().setSp(65),
//                         hasUnderline: true,
//                         wrapAlignment: WrapAlignment.spaceAround,
//                         pinBoxDecoration:
//                             ProvidedPinBoxDecoration.defaultPinBoxDecoration,
//                         pinTextStyle: TextStyle(
//                           fontSize: ScreenUtil().setSp(20),
//                         ),
//                         pinTextAnimatedSwitcherTransition:
//                             ProvidedPinBoxTextAnimation.scalingTransition,
//                         //                    pinBoxColor: Colors.green[100],
//                         pinTextAnimatedSwitcherDuration:
//                             Duration(milliseconds: 300),
//                         //                    highlightAnimation: true,
//                         highlightAnimationBeginColor: Colors.black,
//                         highlightAnimationEndColor: Colors.white12,

//                         keyboardType: TextInputType.number,
//                       ),
//                       OurSizedBox(),
//                       OurElevatedButton(
//                         title: "Verify",
//                         function: () {
//                           verifyOTP();
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
