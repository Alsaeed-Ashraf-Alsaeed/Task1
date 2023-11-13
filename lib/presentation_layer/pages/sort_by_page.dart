import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task1/business_logic_layer/hotels_cubit/hotels_cubits.dart';
import 'package:task1/business_logic_layer/hotels_cubit/hotels_state.dart';
import 'package:task1/presentation_layer/widegts/custom_button.dart';

import '../../styles/text_styles.dart';

class SortByPage extends StatelessWidget {
  int? index;

  SortByPage({Key? key}) : super(key: key);
  List sorts = [
    'Our recommendation',
    'Rating & Recommended',
    'Price & Recommended',
    'Distance & Recommended',
    'Rating only ',
    'Price Only',
    'Distance only',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 20.h),
      height: 650.h,
      width: 350.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.r),
          topLeft: Radius.circular(10.r),
        ),
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTopBar(context),
              buildSizedBox(30.h),
              ...buildSortTypesBars(setState),
              const Expanded(child: SizedBox()),
              buildShowResultsButton(context),
              buildSizedBox(20.h)
            ],
          );
        },
      ),
    );
  }

  Center buildShowResultsButton(BuildContext context) {
    return Center(
      child: CustomButton(
        color: Colors.blue,
        width: 300.w,
        height: 40.h,
        child: Text(
          "Show results ",
          style: MyTestStyles.styleSmall,
        ),
        onPressed: () {
          BlocProvider.of<HotelsCubit>(context).sortHotel(index);
          Navigator.pop(context);
        },
      ),
    );
  }

  List<Widget> buildSortTypesBars(StateSetter setState) {
    return List.generate(
      sorts.length,
      (idx) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 1,
            color: Colors.black26,
            height: 1.h,
          ),
          SizedBox(
            height: 40.h,
            child: Material(
              color: Colors.white,
              child: InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  index = idx;
                  setState(() {});
                },
                child: Row(
                  children: [
                    Text(
                      sorts[idx],
                      style: MyTestStyles.styleSmall,
                    ),
                    const Expanded(child: SizedBox()),
                    if (index == idx)
                      Icon(
                        Icons.check,
                        size: 30.r,
                        color: Colors.blue,
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Row buildTopBar(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Text(
          "Sort by",
          style: MyTestStyles.styleSmall.copyWith(fontWeight: FontWeight.w500),
        ),
        const Expanded(child: SizedBox()),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.clear,
            size: 25.r,
          ),
        ),
      ],
    );
  }
}
