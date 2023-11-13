import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color=Colors.white70,
    this.radius =0,
    this.backImagePath,
    this.width=0,
    this.height=0,

  }) : super(key: key);
  Widget child;
   Color color;
  VoidCallback onPressed;
  String? backImagePath;
   double radius;
   double height;
   double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        image:backImagePath==null?null: DecorationImage(
          fit: BoxFit.cover,
          image:  AssetImage(backImagePath
          !)
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: ElevatedButton(

        style: ElevatedButton.styleFrom(

            elevation: 0,

            side: const BorderSide(width: 0, color: Colors.white),
            backgroundColor: color,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
