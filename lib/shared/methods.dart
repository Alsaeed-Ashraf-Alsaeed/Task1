
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedMethods {

  static  void showModalSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
      backgroundColor: Colors.white.withOpacity(0),
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: 650.h),
      context: context,
      builder: (ctx) => widget,
    );
  }


}