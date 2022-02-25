import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/model/product_model.dart';
import 'package:myapp/screen/dashboard_screens/product_detail_screen/our_detail_product.dart';
import 'package:myapp/services/firestore/firestore.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/widgets/our_sized_box.dart';

class OurProductItemTile extends StatefulWidget {
  final ProductModel productModel;
  const OurProductItemTile({Key? key, required this.productModel})
      : super(key: key);

  @override
  _OurProductItemTileState createState() => _OurProductItemTileState();
}

class _OurProductItemTileState extends State<OurProductItemTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(
        //     OurDetailProductScreen(
        //       productModelUID: widget.productModel,
        //     ),
        //     transition: Transition.rightToLeft);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            ScreenUtil().setSp(20),
          ),
          color: logoColor.withOpacity(0.3),
        ),
        padding: EdgeInsets.symmetric(
          // horizontal: ScreenUtil().setSp(10),
          vertical: ScreenUtil().setSp(5),
        ),
        child: Stack(
          children: [
            Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.productModel.favorite
                        .contains(FirebaseAuth.instance.currentUser!.uid)
                    ? IconButton(
                        onPressed: () async {
                          // await Firestore().removeFavorite(widget.productModel);
                        },
                        icon: Icon(
                          Icons.favorite,
                          size: ScreenUtil().setSp(30),
                          color: Colors.red,
                        ),
                      )
                    : IconButton(
                        onPressed: () async {
                          // await Firestore().addFavorite(widget.productModel);
                        },
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          size: ScreenUtil().setSp(30),
                          color: Colors.red,
                        ),
                      ),
                Center(
                  child: CachedNetworkImage(
                    height: ScreenUtil().setSp(100),
                    width: double.infinity,
                    fit: BoxFit.contain,
                    imageUrl: widget.productModel.url,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/placeholder.png",
                      height: ScreenUtil().setSp(100),
                      width: ScreenUtil().setSp(150),
                    ),
                  ),
                ),
                const OurSizedBox(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setSp(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name:",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(17.5),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setSp(
                          15,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.productModel.name,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.w400,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                const OurSizedBox(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setSp(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price:",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(17.5),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setSp(
                          15,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Rs. ${widget.productModel.price.toString()}",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.w400,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setSp(10),
                    right: ScreenUtil().setSp(10),
                    bottom: ScreenUtil().setSp(5),
                  ),
                  child: RatingStars(
                    value: widget.productModel.rating.toDouble(),
                    starBuilder: (index, color) => Icon(
                      Icons.star,
                      color: color,
                      size: ScreenUtil().setSp(17),
                    ),
                    starCount: 5,
                    starSize: ScreenUtil().setSp(17),
                    valueLabelColor: const Color(0xff9b9b9b),
                    valueLabelTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: ScreenUtil().setSp(12),
                    ),
                    valueLabelRadius: ScreenUtil().setSp(20),
                    maxValue: 5,
                    starSpacing: 1,
                    maxValueVisibility: true,
                    valueLabelVisibility: true,
                    animationDuration: const Duration(milliseconds: 1000),
                    valueLabelPadding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setSp(5),
                      horizontal: ScreenUtil().setSp(5),
                    ),
                    valueLabelMargin: EdgeInsets.only(
                      right: ScreenUtil().setSp(3),
                    ),
                    starOffColor: const Color(0xffe7e8ea),
                    starColor: Colors.yellow,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
