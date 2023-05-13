import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:neoloop/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

SizedBox smallerSizedBox = SizedBox(height: 1.h);
SizedBox smallSizedBox = SizedBox(height: 2.h);
SizedBox mediumSizedBox = SizedBox(height: 4.h);
SizedBox largeSizedBox = SizedBox(height: 8.h);
SizedBox extraLargeSizedBox = SizedBox(height: 10.h);

EdgeInsets paddingSymmetric(
        {required double horizontal, required double vertical}) =>
    EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);

EdgeInsets paddingAll({required double padding}) => EdgeInsets.all(padding);

class AppStyle {
  static TextStyle extraSmallTextStyle = TextStyle(
    fontSize: 11.sp,
    color: AppColor.lightGrey,
    fontFamily: 'TitilliumWeb-Regular',
    letterSpacing: 1,
  );

  static TextStyle smallTextStyle = TextStyle(
    fontSize: 12.sp,
    color: AppColor.lightGrey,
    fontFamily: 'TitilliumWeb-Regular',
    letterSpacing: 1,
  );

  static TextStyle mediumTextStyle = TextStyle(
    fontSize: 14.sp,
    color: AppColor.lightGrey,
    fontFamily: 'TitilliumWeb-Regular',
    letterSpacing: 1,
  );

  static TextStyle largeTextStyle = TextStyle(
    fontSize: 18.sp,
    color: Colors.black,
    fontFamily: 'TitilliumWeb-Regular',
  );

  static TextStyle extraLargeTextStyle = TextStyle(
    fontSize: 22.sp,
    color: Colors.black,
    fontFamily: 'TitilliumWeb-Regular',
  );
}
