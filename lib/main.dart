import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task1/business_logic_layer/hotels_cubit/hotels_cubits.dart';
import 'package:task1/presentation_layer/pages/animation_page.dart';
import 'package:task1/presentation_layer/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(350, 700),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        home: child,
        title: 'Flutter task1',
        theme: ThemeData(
        ),
      ),
      child:const AnimationPage(),
    );
  }
}
