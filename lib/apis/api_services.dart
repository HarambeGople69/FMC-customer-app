import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/controller/authentication_controller.dart';
import 'package:myapp/model/login_response_model.dart';
import 'package:myapp/screen/authentication_screen/login_screen.dart';

import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  Future<void> signUp(Map<String, dynamic> toJson, BuildContext context) async {
    print("Inside signup");
    String url = "https://api.fmccart.com/client/signup";
    // String url = "https://api.fmccart.com/site/mobauth";
    try {
      final response = await http.post(Uri.parse(url), body: (toJson));
      if (response.statusCode == 200) {
        print("Inside 200 code");
        String responseJson = json.decode(response.body);
        print(responseJson);
        if (responseJson.contains("Data Saved")) {
          // Map map = {
          //   'username': toJson["username"],
          //   'password': toJson["password"],
          // };
          // await login(toJson, context);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }));
          OurToast().showSuccessToast("User signed in successfully");
          Get.find<AuthenticationController>().toggle(false);
        } else {
          OurToast().showErrorToast("Error Occured");
          Get.find<AuthenticationController>().toggle(false);
        }
        Get.find<AuthenticationController>().toggle(false);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      OurToast().showErrorToast(
        e.toString(),
      );
      Get.find<AuthenticationController>().toggle(false);
    }
  }

  Future<void> login(Map<String, dynamic> toJson, BuildContext context) async {
    print("Inside login");
    String url = "https://api.fmccart.com/client/mobauth";
    // String url = "https://api.fmccart.com/site/mobauth";
    Get.find<AuthenticationController>().toggle(true);
    try {
      final response = await http.post(Uri.parse(url), body: (toJson));
      if (response.statusCode == 200) {
        print("Inside 200 code");
        var responseJson = json.decode(response.body);
        print(response.body);
        loginResponse loginResponseModel = loginResponse.fromJson(responseJson);
        print(loginResponseModel);
        if (loginResponseModel.success == 1) {
          print("Success done");
        } else {
          OurToast().showErrorToast("Invalid user credentials");
          Get.find<AuthenticationController>().toggle(false);
        }
      } else {
        print(response.statusCode);
        Get.find<AuthenticationController>().toggle(false);
      }
    } catch (e) {
      Get.find<AuthenticationController>().toggle(false);

      OurToast().showErrorToast(
        e.toString(),
      );
      print(e.toString());
    }
    Get.find<AuthenticationController>().toggle(false);
  }

  // loggedUserProfile() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   try {
  //     String url = "https://api.fmccart.com/site/myprofile?accessToken=$token";

  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       UserModel userModel = UserModel.fromJson(jsonDecode(response.body));

  //       return userModel;
  //     } else {
  //       print(response.statusCode.toString());
  //     }
  //   } catch (e) {}
  // }

  // static Future<List<MyTaskModelResponse>?> mytask() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   List<MyTaskModelResponse> _responses = [];
  //   try {
  //     String url = "https://api.fmccart.com/site/mytask?accessToken=$token";
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       data.forEach(
  //         (e) => _responses.add(
  //           MyTaskModelResponse.fromJson(e),
  //         ),
  //       );
  //       print(_responses);
  //       return _responses;
  //     } else {
  //       print(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // static Future<List<MyTaskModelResponse>?> myclosedtask() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   List<MyTaskModelResponse> _responses = [];
  //   print("Inside closed task");
  //   try {
  //     String url =
  //         "https://api.fmccart.com/site/myclosedtask/?accessToken=$token";
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       data.forEach(
  //         (e) => _responses.add(
  //           MyTaskModelResponse.fromJson(e),
  //         ),
  //       );
  //       print(_responses);

  //       return _responses;
  //     } else {
  //       print(response.statusCode.toString());
  //       return _responses;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // static Future<List<AttandanceModel>?> myattandance(
  //     String year, String month) async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   String url =
  //       "https://api.fmccart.com/site/myattendance/?accessToken=$token&year=$year&month=$month";
  //   List<AttandanceModel> _responses = [];
  //   print("Inside attandance api");
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       print(data);
  //       data.forEach(
  //         (e) => _responses.add(
  //           AttandanceModel.fromJson(e),
  //         ),
  //       );
  //       print(_responses);
  //       return _responses;
  //     } else {
  //       return _responses;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // static Future<List<MyFinancialModelResponse>?> myfinancials(
  //     String year) async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   print("Inside My Finance api");
  //   String url =
  //       "https://api.fmccart.com/site/myfinancials/?accessToken=$token&year=$year";
  //   List<MyFinancialModelResponse> _responses = [];
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       data.forEach(
  //         (e) => _responses.add(
  //           MyFinancialModelResponse.fromJson(e),
  //         ),
  //       );
  //       print(_responses);
  //       return _responses;
  //     } else {
  //       print(response.statusCode.toString());
  //       return _responses;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // static Future<List<MyTrainingModelResponse>?> mytraining() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   print("Inside my training");
  //   List<MyTrainingModelResponse> _responses = [];
  //   String url = "https://api.fmccart.com/site/mytrainings/?accessToken=$token";

  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       data.forEach(
  //         (e) => _responses.add(
  //           MyTrainingModelResponse.fromJson(e),
  //         ),
  //       );
  //       print(_responses);
  //       return _responses;
  //     } else {
  //       print(response.statusCode.toString());
  //     }
  //   } catch (e) {}
  // }

  // static Future<List<MyLeaveModel>?> myleave() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   List<MyLeaveModel> _responses = [];
  //   String url = "https://api.fmccart.com/site/myleaves?accessToken=$token";
  //   print("Inside my leave ");
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       data.forEach(
  //         (e) => _responses.add(
  //           MyLeaveModel.fromJson(e),
  //         ),
  //       );
  //       print(_responses);
  //       return _responses;
  //     } else {
  //       print(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // myleaveType() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   String url = "https://api.fmccart.com/site/leavetype?accessToken=$token";
  //   final response = await http.get(Uri.parse(url));
  //   print("Inside leave type");
  //   print(token);
  //   if (response.statusCode == 200) {
  //     print(jsonDecode(response.body));
  //   } else {
  //     print(response.statusCode.toString());
  //     print("Error");
  //   }
  // }

  // mysalestarget(String id) async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   String url =
  //       "https://api.fmccart.com/site/mysalestarget?accessToken=$token&fiscalYear=$id";
  //   List<MySalesModel> _responses = [];
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     data.forEach((e) {
  //       _responses.add(
  //         MySalesModel.fromJson(e),
  //       );
  //     });
  //     print(data);
  //     print(_responses);
  //     return _responses;
  //   } else {
  //     print(response.statusCode);
  //     print("Failed");
  //   }
  // }

  // myfiscalYearList() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   String url = "https://api.fmccart.com/site/fiscalyears?accessToken=$token";
  //   List<FiscalYearModel> _responses = [];
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     data.forEach((e) {
  //       _responses.add(FiscalYearModel.fromJson(e));
  //     });
  //     print(jsonDecode(response.body));
  //     print(_responses);
  //     return _responses;
  //   } else {
  //     print(response.statusCode);
  //     print("Failed");
  //   }
  // }

  // //CRM

  // static Future<List<CustomerListModelResponse>?> customerList() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   List<CustomerListModelResponse> _responses = [];
  //   String token = await AppSharedPreference().getToken();
  //   String url = "https://api.fmccart.com/crm/customers?token=$token";

  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       data.forEach(
  //         (e) => _responses.add(
  //           CustomerListModelResponse.fromJson(e),
  //         ),
  //       );

  //       return _responses;
  //     } else {
  //       print(response.statusCode.toString());
  //     }
  //   } catch (e) {}
  // }

  // Future<List<CustomerViewModelResponse>> customerView(String clientid) async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   List<CustomerViewModelResponse> _responses = [];

  //   String url =
  //       "https://api.fmccart.com/crm/customerview?token=$token&clientid=$clientid";
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);

  //     data.forEach(
  //       (e) => _responses.add(
  //         CustomerViewModelResponse.fromJson(e),
  //       ),
  //     );
  //     return _responses;
  //   } else {
  //     return _responses;
  //   }
  // }

  // Future<List<ClientTypeModel>?> clientType() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   List<ClientTypeModel> _responses = [];
  //   try {
  //     String url = "https://api.fmccart.com/crm/clienttypes?token=$token";
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       data.forEach(
  //         (e) => _responses.add(
  //           ClientTypeModel.fromJson(e),
  //         ),
  //       );
  //       print(_responses);
  //       return _responses;
  //     } else {
  //       print(response.statusCode.toString());
  //     }
  //   } catch (e) {}
  // }

  // Future<List<CountryTypeModel>?> country() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   List<CountryTypeModel> _responses = [];
  //   String url = "https://api.fmccart.com/crm/countries?token=$token";
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       data.forEach(
  //         (e) => _responses.add(
  //           CountryTypeModel.fromJson(e),
  //         ),
  //       );

  //       return _responses;
  //     } else {
  //       print(response.statusCode.toString());
  //     }
  //   } catch (e) {}
  // }

  // Future<bool> addcustomer(
  //     Map<String, dynamic> toJson, BuildContext context) async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   String url = "https://api.fmccart.com/crm/clientpost?token=$token";
  //   try {
  //     final response = await http.post(Uri.parse(url), body: (toJson));

  //     if (response.statusCode == 200) {
  //       print("Inside 200 code");
  //       var responseJson = json.decode(response.body);

  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // //POS

  // posPost(String toJson, BuildContext context) async {
  //   print("Inside posPost");
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   String url = "https://api.fmccart.com/pos/entry?token=$token";
  //   try {
  //     final response = await http.post(Uri.parse(url),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json',
  //         },
  //         body: (toJson));

  //     if (response.statusCode == 200) {
  //       posPostResponse postResponse =
  //           posPostResponse.fromJson(jsonDecode(response.body));
  //       print(jsonDecode(response.body));
  //       return postResponse;
  //     } else {
  //       print(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future postokenview(int id) async {
  //   print("Inside pos token view");
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   String url = "https://api.fmccart.com/pos/view?token=$token&id=$id";
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       PrintBillModel printBillModel = PrintBillModel.fromJson(data);

  //       return data;
  //     } else {
  //       print(response.statusCode.toString());
  //     }
  //   } catch (e) {}
  // }

  // // Products API

  // Future<List<ProductListResponse>?> productList() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   List<ProductListResponse> _responses = [];
  //   String url = "https://api.fmccart.com/products/list?token=$token";
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       print(data);

  //       print("HI");
  //       data.forEach(
  //         (e) => _responses.add(
  //           ProductListResponse.fromJson(e),
  //         ),
  //       );
  //       print(_responses);
  //       return _responses;
  //     } else {
  //       return _responses;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // productDetail(String productId) async {
  //   print("Product details");
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   List<ProductListResponse> _responses = [];
  //   String url =
  //       "https://api.fmccart.com/products/productdetail?token=$token&id=$productId";
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       print("Inside 200 code");
  //       ProductDetailResponse productDetailResponse =
  //           ProductDetailResponse.fromJson(jsonDecode(response.body));

  //       return productDetailResponse;
  //     } else {
  //       print(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // clientNumber(String number) async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   String token = await AppSharedPreference().getToken();
  //   List<ProductListResponse> _responses = [];
  //   String url =
  //       "https://api.fmccart.com/pos/getclient?number=$number&token=$token";
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       print("Inside 200 code");

  //       return data;
  //     } else {
  //       print(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
