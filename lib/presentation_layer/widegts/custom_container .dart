import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer({
    Key? key,
    required this.child,
    required this.height,
    required this.width,
    this.radius=0,
    this.color= Colors.white,
    this.shadowX=0,
    this.shadowColor=Colors.white,
    this.shadowY=0,
    this.shadowBlur=0,
    this.borderColor=Colors.white,
    this.borderWidth =0,
    this.topPad=0,
    this.bottomPad=0,
    this.leftPad=0,
    this.rightPad=0,
    this.backGroundImage,

  }) : super(key: key);
  Widget child;
  double radius = 0;
  String? backGroundImage;
 Color color;
 Color shadowColor;
 double shadowX;
 double shadowY;
 double shadowBlur ;
 double height;
 double width;
 double borderWidth;
 double topPad;
 double bottomPad;
 double leftPad;
 double rightPad;
 Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: height,
      width:  width,
      padding: EdgeInsets.only(
        top: topPad,
        bottom: bottomPad,
        left: leftPad,
        right: rightPad,
      ),
      decoration: BoxDecoration(
        image:backGroundImage==null?null :DecorationImage(
          image: AssetImage(backGroundImage!),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(radius),

        border: Border.all(
          width: borderWidth,
          color: borderColor,

        ),
        color: color,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(shadowX,shadowY),
             blurRadius: shadowBlur,
          ),
        ]
      ),
      child: child,
    );
  }
}
