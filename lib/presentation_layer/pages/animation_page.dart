import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task1/styles/text_styles.dart';

import '../../business_logic_layer/hotels_cubit/hotels_cubits.dart';
import 'home_page.dart';

//Note , this page is built so fast without any care of the performance...because
//each moving part should only rebuild without rebuilding the whole page.
// but as this page is very simple it wont affect the performance.
class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  double hContainerHeight = 300.h;
  double oContainerHeight = 300.h;
  double tContainerHeight = 300.h;
  double eContainerHeight = 300.h;
  double lContainerHeight = 300.h;
  double sContainerHeight = 300.h;
  double gContainerHeight = 0.h;
  double o2ContainerHeight = 0.h;

  double opacity = 0;
  double whiteContainerWidth = 0;

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  Future<void> wait700Mil() async {
    await Future.delayed(const Duration(milliseconds: 700));
  }

  Future<void> setVar(double h) async {
    await wait700Mil();
    h = h == 40 ? 400 : 40;
    setState(() {});
  }

  void startAnimation() async {
    await wait700Mil();
    hContainerHeight = hContainerHeight == 40 ? 400 : 40;
    setState(() {});
    await wait700Mil();
    oContainerHeight = oContainerHeight == 40 ? 400 : 40;
    setState(() {});
    await wait700Mil();
    tContainerHeight = tContainerHeight == 40 ? 400 : 40;
    setState(() {});
    await wait700Mil();
    eContainerHeight = eContainerHeight == 40 ? 400 : 40;
    setState(() {});
    await wait700Mil();
    lContainerHeight = lContainerHeight == 40 ? 400 : 40;
    setState(() {});
    await wait700Mil();
    sContainerHeight = sContainerHeight == 40 ? 400 : 40;
    setState(() {});
    await wait700Mil();
    gContainerHeight = gContainerHeight == 0 ? 50 : 0;
    setState(() {});
    await wait700Mil();
    o2ContainerHeight = o2ContainerHeight == 0 ? 50 : 0;
    setState(() {});
    await wait700Mil();
    opacity = 1;
    setState(() {});
    await wait700Mil();
    whiteContainerWidth = 350.w;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 800));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (ctx) => BlocProvider<HotelsCubit>(
          lazy: false,
          create: (ctx) => HotelsCubit()..fetchHotelsFromRepository(),
          child: HomePage()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(40, 99, 168, 1.0),
          height: 700.h,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(30.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildUpperWholeLettersRow(),
                    Divider(
                      height: 10.h,
                      thickness: 2.w,
                      color: Colors.white60,
                    ),
                    buildLowerHalfLettersRow(),
                  ],
                ),
              ),
              buildBlueOpacityContainer(),
              buildWhiteOpeningContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Center buildWhiteOpeningContainer() {
    return Center(
      child: AnimatedContainer(
        height: 700.h,
        width: whiteContainerWidth,
        duration: const Duration(
          milliseconds: 800,
        ),
        child: Container(
          height: 700.h,
          width: 350.w,
          color: Colors.white,
        ),
      ),
    );
  }

  AnimatedOpacity buildBlueOpacityContainer() {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(
        milliseconds: 600,
      ),
      child: Container(
        height: 700.h,
        width: 350.w,
        color: const Color.fromRGBO(40, 99, 168, 1.0),
      ),
    );
  }

  SizedBox buildLowerHalfLettersRow() {
    return SizedBox(
      height: 300.h,
      width: 320.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildAnimatedContainer("G", gContainerHeight),
          buildAnimatedContainer("O", o2ContainerHeight),
          SizedBox(
            width: 20.w,
          ),
        ],
      ),
    );
  }

  SizedBox buildUpperWholeLettersRow() {
    return SizedBox(
      height: 300.h,
      width: 320.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildAnimatedContainer("H", hContainerHeight),
          buildAnimatedContainer("O", oContainerHeight),
          buildAnimatedContainer("T", tContainerHeight),
          buildAnimatedContainer("E", eContainerHeight),
          buildAnimatedContainer("L", lContainerHeight),
          buildAnimatedContainer("S", sContainerHeight),
        ],
      ),
    );
  }

  AnimatedContainer buildAnimatedContainer(String letter, double height) {
    return AnimatedContainer(
      curve: Curves.bounceOut,
      duration: const Duration(milliseconds: 1000),
      height: height,
      child: Text(
        letter,
        style: MyTestStyles.styleMedium.copyWith(
            color: Colors.white70, fontSize: 32.r, fontFamily: "txt1"),
      ),
    );
  }
}
