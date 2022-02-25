import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/apis/api_services.dart';
import 'package:myapp/controller/authentication_controller.dart';
import 'package:myapp/screen/authentication_screen/signup_screen.dart';
import 'package:myapp/services/authentication/authentication.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:myapp/widgets/our_password_field.dart';
import 'package:myapp/widgets/our_shimmer_text.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:myapp/widgets/our_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  final _email_node = FocusNode();
  final _password_node = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Obx(
          () => ModalProgressHUD(
            progressIndicator: SpinKitFadingCircle(
              size: ScreenUtil().setSp(60),
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? logoColor : Colors.green,
                  ),
                );
              },
            ),
            inAsyncCall: Get.find<AuthenticationController>().processing.value,
            child: Scaffold(
              body: SafeArea(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setSp(20),
                    vertical: ScreenUtil().setSp(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.fitHeight,
                          height: ScreenUtil().setSp(300),
                          width: MediaQuery.of(context).size.width,
                        ),
                        const OurShimmerText(
                          title: "Login as a User",
                        ),
                        const OurSizedBox(),
                        const OurSizedBox(),
                        const OurSizedBox(),
                        CustomTextField(
                          start: _email_node,
                          end: _password_node,
                          icon: Icons.email,
                          controller: _email_controller,
                          validator: (value) {},
                          title: "User name",
                          type: TextInputType.emailAddress,
                          number: 0,
                        ),
                        const OurSizedBox(),
                        PasswordForm(
                          start: _password_node,
                          controller: _password_controller,
                          title: "Password",
                          validator: (value) {},
                          number: 1,
                        ),
                        const OurSizedBox(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: OurElevatedButton(
                            title: "Login",
                            function: () async {
                              if (_email_controller.text.trim().isEmpty ||
                                  _password_controller.text.trim().isEmpty) {
                                OurToast()
                                    .showErrorToast("Fields can't be empty");
                              } else {
                                // print({
                                //   'username': _email_controller.text.trim(),
                                //   'password': _password_controller.text.trim(),
                                // });
                                Get.find<AuthenticationController>()
                                    .toggle(true);
                                await APIService().login({
                                  'username': _email_controller.text.trim(),
                                  'password': _password_controller.text.trim(),
                                }, context);

                                // Auth().loginAccount(
                                //     _email_controller.text.trim(),
                                //     _password_controller.text.trim());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                alignment: Alignment.center,
                height: ScreenUtil().setSp(30),
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setSp(20),
                  vertical: ScreenUtil().setSp(10),
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: "Don't have an account?  ",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              // color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )
                            // style: paratext,
                            ),
                        TextSpan(
                          text: 'Sign up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignUpScreen();
                              }));
                            },
                          style: TextStyle(
                            color: logoColor,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
