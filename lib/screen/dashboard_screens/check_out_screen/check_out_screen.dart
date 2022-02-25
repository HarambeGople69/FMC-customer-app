// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:myapp/controller/authentication_controller.dart';
// import 'package:myapp/controller/order_cart_controller.dart';
// import 'package:myapp/screen/dashboard_screens/dashboard_screen.dart';
// import 'package:myapp/services/firestore/firestore.dart';
// import 'package:myapp/utils/colors.dart';
// import 'package:myapp/utils/utils.dart';
// import 'package:myapp/widgets/our_elevated_button.dart';
// import 'package:myapp/widgets/our_flutter_toast.dart';
// import 'package:myapp/widgets/our_shimmer_text.dart';
// import 'package:myapp/widgets/our_sized_box.dart';
// import 'package:myapp/widgets/our_text_field.dart';

// class CheckOutScreen extends StatefulWidget {
//   final Position userPosition;

//   const CheckOutScreen({Key? key, required this.userPosition})
//       : super(key: key);
//   @override
//   State<StatefulWidget> createState() => _CheckOutScreenState();
// }

// class _CheckOutScreenState extends State<CheckOutScreen> {
//   Position? position;
//   double? longitude = 0.69;
//   double? latitude = 0.69;
//   List<Placemark>? placeMarks;
//   AuthenticationController authenticationController =
//       Get.put(AuthenticationController());
//   OrderCartController orderCartController = Get.put(OrderCartController());
//   ValueNotifier<GeoPoint?> notifier = ValueNotifier(null);
//   final fromEventController = TextEditingController();

//   TextEditingController _name_controller = TextEditingController();
//   TextEditingController _phone_controller = TextEditingController();
//   TextEditingController _email_controller = TextEditingController();
//   TextEditingController _country_controller = TextEditingController();
//   TextEditingController _postal_code_controller = TextEditingController();
//   TextEditingController _administrative_area_controller =
//       TextEditingController();
//   TextEditingController _subministrative_area_controller =
//       TextEditingController();
//   TextEditingController _locality_controller = TextEditingController();
//   TextEditingController _sublocality_controller = TextEditingController();
//   late DateTime fromdate;
//   late DateTime todate;

//   Future<void> _showMyDialog(String? date) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Delivery Timing'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 date!.isEmpty
//                     ? Text('Your product will be delivered within 90 min')
//                     : Text("Your product will be delivereds at $date"),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Get.off(DashBoardScreen());
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Obx(
//           () => ModalProgressHUD(
//               progressIndicator: SpinKitFadingCircle(
//                 size: ScreenUtil().setSp(60),
//                 itemBuilder: (BuildContext context, int index) {
//                   return DecoratedBox(
//                     decoration: BoxDecoration(
//                       color: index.isEven ? logoColor : Colors.green,
//                     ),
//                   );
//                 },
//               ),
//               inAsyncCall:
//                   Get.find<AuthenticationController>().processing.value,
//               child: Scaffold(
//                 appBar: AppBar(
//                   leading: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.arrow_back,
//                       size: ScreenUtil().setSp(25),
//                     ),
//                   ),
//                   centerTitle: true,
//                   title: Text(
//                     "Check Out",
//                     style: TextStyle(
//                       fontSize: ScreenUtil().setSp(25),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   backgroundColor: logoColor,
//                 ),
//                 body: Center(
//                   child: Container(
//                     margin: EdgeInsets.symmetric(
//                       horizontal: ScreenUtil().setSp(20),
//                       vertical: ScreenUtil().setSp(10),
//                     ),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           CustomTextField(
//                             controller: _name_controller,
//                             validator: (value) {},
//                             title: "Name",
//                             type: TextInputType.name,
//                             number: 1,
//                           ),
//                           OurSizedBox(),
//                           CustomTextField(
//                             controller: _phone_controller,
//                             validator: (value) {},
//                             title: "Phone ",
//                             type: TextInputType.number,
//                             number: 1,
//                           ),
//                           OurSizedBox(),
//                           CustomTextField(
//                             controller: _email_controller,
//                             validator: (value) {},
//                             title: "Email",
//                             type: TextInputType.emailAddress,
//                             number: 1,
//                           ),
//                           OurSizedBox(),
//                           CustomTextField(
//                             readonly: true,
//                             controller: _country_controller,
//                             validator: (value) {},
//                             title: "Country",
//                             type: TextInputType.emailAddress,
//                             number: 1,
//                           ),
//                           OurSizedBox(),
//                           CustomTextField(
//                             readonly: true,
//                             controller: _postal_code_controller,
//                             validator: (value) {},
//                             title: "Postal code",
//                             type: TextInputType.name,
//                             number: 1,
//                           ),
//                           OurSizedBox(),
//                           CustomTextField(
//                             readonly: true,
//                             controller: _administrative_area_controller,
//                             validator: (value) {},
//                             title: "Administrative area",
//                             type: TextInputType.name,
//                             number: 1,
//                           ),
//                           OurSizedBox(),
//                           CustomTextField(
//                             readonly: true,
//                             controller: _subministrative_area_controller,
//                             validator: (value) {},
//                             title: "Sub administrative area",
//                             type: TextInputType.emailAddress,
//                             number: 1,
//                           ),
//                           OurSizedBox(),
//                           CustomTextField(
//                             readonly: true,
//                             controller: _locality_controller,
//                             validator: (value) {},
//                             title: "Locality",
//                             type: TextInputType.emailAddress,
//                             number: 1,
//                           ),
//                           OurSizedBox(),
//                           CustomTextField(
//                             readonly: true,
//                             controller: _sublocality_controller,
//                             validator: (value) {},
//                             title: "Sub locality",
//                             type: TextInputType.emailAddress,
//                             number: 1,
//                           ),
//                           OurSizedBox(),
//                           TextFormField(
//                             // focusNode: toNode,

//                             controller: fromEventController,
//                             decoration: InputDecoration(
//                               contentPadding: EdgeInsets.symmetric(
//                                 vertical: ScreenUtil().setSp(2),
//                                 horizontal: ScreenUtil().setSp(2),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                   color: logoColor,
//                                 ),
//                                 borderRadius: BorderRadius.circular(
//                                   ScreenUtil().setSp(
//                                     10,
//                                   ),
//                                 ),
//                               ),
//                               isDense: true,
//                               labelText: "Delivery Date",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(
//                                   ScreenUtil().setSp(
//                                     10,
//                                   ),
//                                 ),
//                               ),
//                               labelStyle: TextStyle(
//                                 color: logoColor,
//                                 fontSize: ScreenUtil().setSp(
//                                   17.5,
//                                 ),
//                               ),
//                               prefixIcon: Icon(
//                                 null,
//                                 size: ScreenUtil().setSp(20),
//                                 color: logoColor,
//                               ),
//                               errorStyle: TextStyle(
//                                 fontSize: ScreenUtil().setSp(
//                                   13.5,
//                                 ),
//                               ),
//                             ),
//                             readOnly: true,
//                             onTap: () async {
//                               DateTime initialTime = DateTime.now();
//                               DateTime? date = await showDatePicker(
//                                 context: context,
//                                 // helpText:"Help",

//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime.now(),
//                                 lastDate: DateTime(2052),
//                               );
//                               if (date == null) {
//                                 return null;
//                               }
//                               final time = await showTimePicker(
//                                 context: context,
//                                 initialTime: TimeOfDay(
//                                     hour: initialTime.hour,
//                                     minute: initialTime.minute),
//                               );
//                               if (time == null) {
//                                 return null;
//                               }
//                               setState(() {
//                                 fromdate = DateTime(
//                                   date.year,
//                                   date.month,
//                                   date.day,
//                                   time.hour,
//                                   time.minute,
//                                 );
//                                 fromEventController.text =
//                                     Utils().customDate(fromdate);
//                               });
//                             },
//                           ),
//                           OurSizedBox(),
//                           OurElevatedButton(
//                             title: "Select current location",
//                             function: () async {
//                               placeMarks = await placemarkFromCoordinates(
//                                 widget.userPosition.latitude,
//                                 widget.userPosition.longitude,
//                               );

//                               setState(() {
//                                 latitude = widget.userPosition.latitude;
//                                 longitude = widget.userPosition.longitude;
//                                 _country_controller.text =
//                                     placeMarks![1].country ?? " ";
//                                 _postal_code_controller.text =
//                                     placeMarks![1].postalCode ?? " ";
//                                 _administrative_area_controller.text =
//                                     placeMarks![1].administrativeArea ?? " ";
//                                 _subministrative_area_controller.text =
//                                     placeMarks![1].subAdministrativeArea ?? " ";
//                                 _locality_controller.text =
//                                     placeMarks![1].locality ?? " ";
//                                 _sublocality_controller.text =
//                                     placeMarks![1].subLocality ?? " ";
//                               });
//                             },
//                           ),
//                           OurElevatedButton(
//                             title: "Pick From Map",
//                             function: () async {
//                               var p = await showSimplePickerLocation(
//                                 contentPadding: EdgeInsets.symmetric(
//                                   vertical: ScreenUtil().setSp(5),
//                                 ),
//                                 context: context,
//                                 isDismissible: true,
//                                 titleWidget: OurShimmerText(
//                                   title: "Pick Location",
//                                 ),
//                                 textConfirmPicker: "pick",
//                                 initCurrentUserPosition: false,
//                                 initZoom: 10,
//                                 initPosition: GeoPoint(
//                                   latitude: widget.userPosition.latitude,
//                                   longitude: widget.userPosition.longitude,
//                                 ),
//                                 radius: 8.0,
//                               );
//                               if (p != null) {
//                                 notifier.value = p;
//                                 placeMarks = await placemarkFromCoordinates(
//                                   p.latitude,
//                                   p.longitude,
//                                 );
//                                 print(placeMarks![1]);
//                                 setState(() {
//                                   latitude = p.latitude;
//                                   longitude = p.longitude;
//                                   _country_controller.text =
//                                       placeMarks![1].country ?? " ";
//                                   _postal_code_controller.text =
//                                       placeMarks![1].postalCode ?? " ";
//                                   _administrative_area_controller.text =
//                                       placeMarks![1].administrativeArea ?? " ";
//                                   _subministrative_area_controller.text =
//                                       placeMarks![1].subAdministrativeArea ??
//                                           " ";
//                                   _locality_controller.text =
//                                       placeMarks![1].locality ?? " ";
//                                   _sublocality_controller.text =
//                                       placeMarks![1].subLocality ?? " ";
//                                 });
//                               }
//                             },
//                           ),
//                           OurElevatedButton(
//                             title: "Submit",
//                             function: () async {
//                               if (_name_controller.text.trim().isEmpty ||
//                                   _phone_controller.text.trim().isEmpty ||
//                                   _email_controller.text.trim().isEmpty ||
//                                   longitude == 0.69 ||
//                                   latitude == 0.69) {
//                                 OurToast()
//                                     .showErrorToast("Fields can't be empty");
//                               } else {
//                                 Get.find<AuthenticationController>()
//                                     .toggle(true);
//                                 // print(fromEventController.text);
//                                 if (fromEventController.text
//                                     .trim()
//                                     .isNotEmpty) {
//                                   _showMyDialog(fromEventController.text);
//                                 } else {
//                                   _showMyDialog(fromEventController.text);
//                                 }
//                                 await Firestore().placeOrder(
//                                   _name_controller.text.trim(),
//                                   _phone_controller.text.trim(),
//                                   _email_controller.text.trim(),
//                                   _country_controller.text.trim(),
//                                   _postal_code_controller.text.trim(),
//                                   _administrative_area_controller.text.trim(),
//                                   _subministrative_area_controller.text.trim(),
//                                   _locality_controller.text.trim(),
//                                   _sublocality_controller.text.trim(),
//                                   longitude!,
//                                   latitude!,
//                                 );
//                                 Get.find<AuthenticationController>()
//                                     .toggle(false);
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )),
//         ));
//   }
// }

// // 