import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task1/business_logic_layer/hotels_cubit/hotels_cubits.dart';
import 'package:task1/presentation_layer/widegts/custom_button.dart';
import 'package:task1/styles/colors.dart';

import '../../styles/text_styles.dart';
import '../widegts/custom_container .dart';

class FilterPage extends StatelessWidget {
  FilterPage({Key? key}) : super(key: key);
  double _sliderValue = 500;
  int? _rating;
  int? _stars;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        height: 650.h,
        width: 350.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.r),
            topLeft: Radius.circular(10.r),
          ),
        ),
        child: StatefulBuilder(builder: (context, setState) {
          return Column(
            children: [
              sizedBox15Height(),
              Row(
                children: [
                  Material(
                    child: InkWell(
                      splashColor: Colors.blue,
                      onTap: () {
                        _sliderValue = 500;
                        _rating = null;
                        _stars = null;
                        setState(() {});
                      },
                      child: Text(
                        "Reset",
                        style: MyTestStyles.styleSmall.copyWith(
                          color: Colors.black54,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    'Filters  ',
                    style: MyTestStyles.styleSmall,
                  ),
                  const Expanded(child: SizedBox()),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.clear, size: 25.r)),
                ],
              ),
              sizedBox15Height(),
// no need for a specific cubit to change the state of this slider , and no need to make the
// to make the whole screen a stateful so we will rebuild unwanted widgets , so the best
//option is using the statefulBuilder widget.....
              buildSliderBar(),
              sizedBox15Height(),
              sizedBox15Height(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Rating ",
                  style: MyTestStyles.styleSmall,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              buildRatingBar(),
              sizedBox15Height(),
              sizedBox15Height(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hotel Class ",
                  style: MyTestStyles.styleSmall,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              buildStarsBar(),
              sizedBox15Height(),
              sizedBox15Height(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Distance from",
                    style: MyTestStyles.styleSmall,
                  )),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Text(
                    "Location",
                    style:
                        MyTestStyles.styleSmall.copyWith(color: Colors.black54),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    "City center   >",
                    style:
                        MyTestStyles.styleSmall.copyWith(color: Colors.black54),
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              buildResultButton(context),
              sizedBox15Height(),
              sizedBox15Height(),
            ],
          );
        }),
      ),
    );
  }

  CustomButton buildResultButton(context) {
    return CustomButton(
      height: 40.h,
      width: 270.w,
      color: MyColors.darkBlue,
      child: Text(
        'Show results ',
        style: MyTestStyles.styleSmall.copyWith(color: Colors.white),
      ),
      onPressed: () {
        BlocProvider.of<HotelsCubit>(context).filterHotels(
            _sliderValue.toInt(),
            _rating == 0
                ? 0
                : _rating == 1
                    ? 7
                    : _rating == 2
                        ? 7.5
                        : _rating == 3
                            ? 8
                            : 8.5,
            _stars);

        Navigator.of(context).pop();
      },
    );
  }

//using stateful-builder to rebuild the the child widget (only) without complicating things
// using cubit and states ans so on , as there are no data coming from the cubit .
  StatefulBuilder buildStarsBar() {
    return StatefulBuilder(
      builder: (ctx, setState) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ...List.generate(
            5,
            (index) {
              return InkWell(
                onTap: () {
                  _stars = _stars == index ? null : index;
                  setState(() {});
                },
                child: Row(
                  children: [
                    hotelClassItem(index + 1, index == _stars ? true : false),
                    if (index != 4)
                      SizedBox(
                        width: 31.w,
                      ),
                  ],
                ),
              );
            },
          ),
        ]);
      },
    );
  }

  StatefulBuilder buildRatingBar() {
    return StatefulBuilder(
      builder: (ctx, setState) =>
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ...List.generate(
          5,
          (index) => Row(
            children: [
              InkWell(
                onTap: () {
                  _rating = _rating == index ? null : index;
                  setState(() {});
                },
                child: CustomContainer(
                  borderWidth: index == _rating ? 3 : 0,
                  borderColor: Colors.blue,
                  radius: 5.r,
                  color: index == 0
                      ? Colors.red
                      : index == 1
                          ? Colors.orange
                          : index == 2
                              ? MyColors.lightGreen
                              : index == 3
                                  ? MyColors.darkGreen
                                  : MyColors.darkerGreen,
                  height: 40.h,
                  width: 40.w,
                  child: Center(
                    child: Text(
                      index == 0
                          ? "0+"
                          : index == 1
                              ? "7+"
                              : index == 2
                                  ? "7.5+"
                                  : index == 3
                                      ? "8+"
                                      : "8.5+",
                      style: MyTestStyles.styleSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.r),
                    ),
                  ),
                ),
              ),
              if (index != 4)
                SizedBox(
                  width: 31.w,
                ),
            ],
          ),
        ),
      ]),
    );
  }

  StatefulBuilder buildSliderBar() {
    return StatefulBuilder(
      builder: (ctx, setState) => Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "PRICE PER NIGHT",
                style: MyTestStyles.styleTiny.copyWith(fontSize: 17.r),
              ),
              const Expanded(child: SizedBox()),
              CustomContainer(
                radius: 5.r,
                borderColor: Colors.black26,
                borderWidth: 2.w,
                height: 45.h,
                width: 70.h,
                child: Center(
                    child: Text(
                  "${_sliderValue.toInt()}+ \$",
                  style: MyTestStyles.styleSmall,
                )),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Slider(
              min: 20,
              max: 500,
              value: _sliderValue,
              activeColor: MyColors.darkBlue,
              onChanged: (val) {
                _sliderValue = val;
                setState(() {});
              }),
          Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Text(
                "\$20",
                style: MyTestStyles.styleTiny.copyWith(color: Colors.black54),
              ),
              const Expanded(child: SizedBox()),
              Text(
                '\$500+',
                style: MyTestStyles.styleTiny.copyWith(color: Colors.black54),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget sizedBox15Height() {
    return SizedBox(
      height: 15.h,
    );
  }

  Widget hotelClassItem(int n, bool chosen) {
    final Icon icon = Icon(
      Icons.star,
      size: 13.r,
      color: Colors.orange,
    );
    final Row twoIcons = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [icon, icon],
    );
    return CustomContainer(
      borderWidth: chosen ? 2 : 1.w,
      borderColor: chosen ? Colors.blue : Colors.orange,
      radius: 5.r,
      height: 40.h,
      width: 40.w,
      child: n == 1
          ? icon
          : n == 2
              ? Center(
                  child: twoIcons,
                )
              : n == 3
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon,
                        twoIcons,
                      ],
                    )
                  : n == 4
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            twoIcons,
                            twoIcons,
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            twoIcons,
                            icon,
                            twoIcons,
                          ],
                        ),
    );
  }
}
