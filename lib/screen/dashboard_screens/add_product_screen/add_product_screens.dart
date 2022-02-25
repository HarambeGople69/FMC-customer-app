// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:myapp/services/addImages/product_image.dart';
// import 'package:myapp/services/firestore/firestore.dart';
// import 'package:myapp/widgets/our_elevated_button.dart';
// import 'package:myapp/widgets/our_flutter_toast.dart';
// import 'package:myapp/widgets/our_sized_box.dart';
// import 'package:myapp/widgets/our_text_field.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({Key? key}) : super(key: key);

//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   File? file;
//   TextEditingController _name_Controller = TextEditingController();
//   TextEditingController _desc_Controller = TextEditingController();
//   TextEditingController _price_Controller = TextEditingController();
//   final _name_Node = FocusNode();
//   final _desc_Node = FocusNode();
//   final _price_Node = FocusNode();
//   pickImage() async {
//     try {
//       final picker = ImagePicker();

//       XFile? result = await picker.pickImage(source: ImageSource.gallery);
//       // FilePickerResult? result = await FilePicker.platform.pickFiles(
//       //   type: FileType.image,
//       // );

//       if (result != null) {
//         setState(() {});
//         file = File(result.path);
//       } else {
//         // User canceled the picker
//       }
//     } catch (e) {
//       print("$e =========");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: SafeArea(
//         child: Scaffold(
//           body: Container(
//             margin: EdgeInsets.symmetric(
//               horizontal: ScreenUtil().setSp(10),
//               vertical: ScreenUtil().setSp(10),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       pickImage();
//                     },
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(
//                         ScreenUtil().setSp(20),
//                       ),
//                       child: Container(
//                         child: file == null
//                             ? Image.asset(
//                                 "assets/images/user_icon.png",
//                                 height: ScreenUtil().setSp(200),
//                                 width: ScreenUtil().setSp(200),
//                               )
//                             : Image.file(
//                                 file!,
//                                 height: ScreenUtil().setSp(200),
//                                 width: ScreenUtil().setSp(200),
//                                 fit: BoxFit.fitWidth,
//                               ),
//                       ),
//                     ),
//                   ),
//                   const OurSizedBox(),
//                   CustomTextField(
//                     start: _name_Node,
//                     end: _desc_Node,
//                     icon: Icons.production_quantity_limits,
//                     controller: _name_Controller,
//                     validator: (value) {},
//                     title: "Name",
//                     type: TextInputType.name,
//                     number: 0,
//                   ),
//                   OurSizedBox(),
//                   CustomTextField(
//                     start: _desc_Node,
//                     end: _price_Node,
//                     icon: Icons.description,
//                     controller: _desc_Controller,
//                     validator: (value) {},
//                     title: "Description",
//                     type: TextInputType.name,
//                     number: 0,
//                   ),
//                   OurSizedBox(),
//                   CustomTextField(
//                     start: _price_Node,
//                     controller: _price_Controller,
//                     validator: (value) {},
//                     title: "Price",
//                     type: TextInputType.number,
//                     number: 1,
//                   ),
//                   OurSizedBox(),
//                   OurElevatedButton(
//                     title: "Add Product",
//                     function: () async {
//                       if (file == null) {
//                         OurToast().showErrorToast("Please select image");
//                       } else if (_name_Controller.text.trim().isEmpty ||
//                           _desc_Controller.text.trim().isEmpty ||
//                           _price_Controller.text.trim().isEmpty) {
//                         OurToast().showErrorToast("Fields can't be empty");
//                       } else {
//                         String? url = await AddProduct().uploadImage(file!);
//                         double price =
//                             double.parse(_price_Controller.text.trim());
//                         Firestore().addProduct(
//                           _name_Controller.text.trim(),
//                           _desc_Controller.text.trim(),
//                           price,
//                           url!,
//                         );

//                         OurToast().showSuccessToast("All right received");
//                       }
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
