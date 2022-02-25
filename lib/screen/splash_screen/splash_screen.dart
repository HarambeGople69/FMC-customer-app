import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myapp/screen/outer_layer_screen/outer_layer_screen.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/widgets/our_shimmer_text.dart';
import 'package:myapp/widgets/our_sized_box.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void completed() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const OuterLayerScreen(),
      ),
    );
    print("=====================");
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), completed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.fitHeight,
            height: ScreenUtil().setSp(300),
            width: MediaQuery.of(context).size.width,
          ),
          const OurShimmerText(
            title: "FMC",
          ),
          const OurSizedBox(),
          const OurSizedBox(),
          const OurSizedBox(),
          SpinKitFadingCircle(
            size: ScreenUtil().setSp(60),
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? logoColor : Colors.green,
                ),
              );
            },
          )
        ],
      ),
    ));
  }
}
