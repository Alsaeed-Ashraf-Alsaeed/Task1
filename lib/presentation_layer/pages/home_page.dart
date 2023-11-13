import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:task1/business_logic_layer/hotels_cubit/hotels_cubits.dart';
import 'package:task1/business_logic_layer/hotels_cubit/hotels_state.dart';
import 'package:task1/data_layer/web_services(APIs)/hotels_api.dart';
import 'package:task1/presentation_layer/pages/animation_page.dart';
import 'package:task1/presentation_layer/pages/filter_page.dart';
import 'package:task1/presentation_layer/pages/map_page.dart';
import 'package:task1/presentation_layer/pages/sort_by_page.dart';
import 'package:task1/presentation_layer/widegts/custom_button.dart';
import 'package:task1/presentation_layer/widegts/custom_container%20.dart';
import 'package:task1/styles/text_styles.dart';

import '../../shared/methods.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  bool _showFilterBar = true;

// must be disposed when moving to another page but , as this is just a one page app no need for
// disposing this controller , as  I would dispose it at the same time of navigating to another page.
  final ScrollController _scrollController = ScrollController();

  void whenScroll(context) {
    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        _showFilterBar) {
      _showFilterBar = false;
      BlocProvider.of<HotelsCubit>(context).reloadHotelsFilterBar();
    }

    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        !_showFilterBar) {
      _showFilterBar = true;
      BlocProvider.of<HotelsCubit>(context).reloadHotelsFilterBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 30.h,
        ),
        color: Colors.white,
        child: Stack(
          children: [
            buildHotelsListView(context),
            buildFilterSortBar(context),
            buildMapButton(context),
          ],
        ),
      ),
    );
  }

  BlocBuilder<HotelsCubit, HotelsStates> buildHotelsListView(
      BuildContext context) {
    return BlocBuilder<HotelsCubit, HotelsStates>(
      buildWhen: (pre, curr) {
        if (curr is HotelsLoadedState || curr is HotelsInitialState) {
          return true;
        } else {
          return false;
        }
      },
      builder: (ctx, states) {
        if (states is HotelsInitialState) {
// listening to the scroll controller only one time when entering this page , so I add the
//listener here instead of making the whole page as a stateful and listen to the controller
// at the intestate methode.
          _scrollController.addListener(() {
            whenScroll(context);
          });
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        } else if (states is HotelsLoadedState) {
          return states.hotels.isEmpty
              ? Center(
                  child: Text(
                    " Oops..... \n\n No hotels found !",
                    style: MyTestStyles.styleSmall,
                  ),
                )
              : CustomContainer(
                  height: 700.h,
                  width: 350.w,
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: 70.h,
                    ),
                    itemCount: states.hotels.length,
                    itemBuilder: (ctx, idx) => Center(
                      child: buildEachHotelItemInListView(idx, states),
                    ),
                    separatorBuilder: (ctx, idx) => Container(
                      height: 16.h,
                    ),
                  ),
                );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  AnimatedContainer buildEachHotelItemInListView(
      int idx, HotelsLoadedState states) {
    return AnimatedContainer(
      duration: Duration(milliseconds: idx % 2 == 0 ? 700 : 1100),
      transform: Matrix4.translationValues(states.transition, 0, 0),
      width: 330.w,
      height: 390.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 8),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildHotelImage(states, idx),
          SizedBox(
            height: 7.h,
          ),
          buildHotelItemDetails(states, idx),
          SizedBox(
            height: 7.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "More Prices",
                textAlign: TextAlign.end,
                style: MyTestStyles.styleTiny.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 30.w),
            ],
          )
        ],
      ),
    );
  }

  CustomContainer buildHotelItemDetails(HotelsLoadedState states, int idx) {
    return CustomContainer(
      height: 180.h,
      width: 310.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ...List.generate(
                  states.hotels[idx].stars.toInt(),
                  (index) => Icon(
                        Icons.star,
                        size: 20.r,
                        color: Colors.black54,
                      )),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "Hotel",
                style: MyTestStyles.styleTiny.copyWith(color: Colors.black),
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            states.hotels[idx].name,
            style: MyTestStyles.styleSmall
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              CustomContainer(
                radius: 15.r,
                color: const Color.fromRGBO(29, 94, 32, 1.0),
                height: 25.h,
                width: 43.w,
                child: Center(
                    child: Text(
                  states.hotels[idx].reviewScore.toString(),
                  style: MyTestStyles.styleTiny
                      .copyWith(color: Colors.white, fontSize: 17.r),
                )),
              ),
              SizedBox(
                width: 7.w,
              ),
              Text(
                states.hotels[idx].review,
                style: MyTestStyles.styleTiny.copyWith(color: Colors.black),
              ),
              SizedBox(
                width: 5.w,
              ),
              Icon(
                Icons.location_on,
                size: 20.r,
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: Text(
                  states.hotels[idx].address,
                  overflow: TextOverflow.ellipsis,
                  style: MyTestStyles.styleTiny.copyWith(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
          SizedBox(
            height: 7.h,
          ),
          CustomContainer(
            topPad: 5.h,
            leftPad: 5.w,
            rightPad: 10.w,
            height: 90.h,
            width: 310.w,
            borderColor: Colors.black.withOpacity(0.3),
            borderWidth: 1.w,
            radius: 4.r,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomContainer(
                      height: 25.h,
                      topPad: 1.h,
                      bottomPad: 1.h,
                      rightPad: 1.h,
                      leftPad: 1.h,
                      width: 120.w,
                      radius: 6.r,
                      color: Colors.tealAccent.withOpacity(0.4),
                      child: Center(
                          child: Text(
                        "Our lowest price",
                        style: MyTestStyles.styleTiny
                            .copyWith(color: Colors.black),
                      )),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          states.hotels[idx].currency == "USD" ? "\$" : "EGP",
                          style: MyTestStyles.styleSmall.copyWith(
                            fontSize: 20.r,
                            color: const Color.fromRGBO(34, 131, 43, 1.0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          style: MyTestStyles.styleSmall.copyWith(
                            height: 1,
                            fontSize: 25.r,
                            color: const Color.fromRGBO(34, 131, 43, 1.0),
                            fontWeight: FontWeight.bold,
                          ),
                          states.hotels[idx].price.toString(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      states.hotels[idx].review,
                      style:
                          MyTestStyles.styleTiny.copyWith(color: Colors.black,fontSize: 13.spMin),
                    )
                  ],
                ),
                const Expanded(child: SizedBox()),
                Text(
                  "View Deal  > ",
                  style: MyTestStyles.styleSmall.copyWith(color: Colors.black),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  CustomContainer buildHotelImage(HotelsLoadedState states, int idx) {
    return CustomContainer(
      height: 160.h,
      width: 330.w,
      child: Stack(
        children: [
          InteractiveViewer(
            child: FadeInImage(
              image: NetworkImage(
                states.hotels[idx].image,
              ),
              fit: BoxFit.fitWidth,
              width: 330.w,
              placeholder: const AssetImage(
                "assets/images/loading.gif",
              ),
              placeholderFit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: 15.w,
            top: 15.h,
            child: CircleAvatar(
                backgroundColor: Colors.black38,
                child: Icon(
                  Icons.favorite_border,
                  size: 25.r,
                )),
          )
        ],
      ),
    );
  }

  BlocBuilder<HotelsCubit, HotelsStates> buildFilterSortBar(
      BuildContext context) {
    return BlocBuilder<HotelsCubit, HotelsStates>(
      buildWhen: (pre, curr) {
        if (curr is ReloadHotelsFilterBar) {
          return true;
        } else {
          return false;
        }
      },
      builder: (ctx, states) => Positioned(
        top: 0,
        left: 10,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          height: _showFilterBar ? 60.h : 0,
          width: 330.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10.r),
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black26,
                  offset: Offset(0, 5),
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  height: 60.h,
                  width: 162.5.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_alt_off,
                        size: 30.r,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Filter",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20.r,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    SharedMethods.showModalSheet(
                      context,
                      BlocProvider.value(
                          value: BlocProvider.of<HotelsCubit>(context),
                          child: FilterPage()),
                    );
                  }),
              CustomButton(
                  height: 60.h,
                  width: 162.5.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_list_outlined,
                        size: 35.r,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "sort",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20.r,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    SharedMethods.showModalSheet(
                      context,
                      BlocProvider.value(
                          value: BlocProvider.of<HotelsCubit>(context),
                          child: SortByPage()),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<HotelsCubit, HotelsStates> buildMapButton(context) {
    return BlocBuilder<HotelsCubit, HotelsStates>(
      buildWhen: (pre, curr) {
        if (curr is ReloadHotelsFilterBar) {
          return true;
        } else {
          return false;
        }
      },
      builder: (ctx, states) {
        if (states is HotelsInitialState) {}

        return Positioned(
          bottom: 15.h,
    left: (350.w-160.5.w)/2,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
            ),
            height: _showFilterBar ? 60 : 0,
            child: CustomButton(
              height: 60.h,
              width: 162.5.w,
              color: Colors.white.withOpacity(0),
              radius: 10.r,
              backImagePath: "assets/images/map.jpg",
              onPressed: () {
                SharedMethods.showModalSheet(
                  context,
// using a weak package Flutter_map to complete the task only , but actually I work with
//Flutter google maps package as it has a lot of functions apis properties  and much more.
                  MapPage(),
                );
              },
              child: CustomContainer(
                height: 26.h,
                color: Colors.blue,
                width: 60.w,
                radius: 20.r,
                child: Center(
                  child: Text(
                    "Map",
                    style: MyTestStyles.styleSmall
                        .copyWith(color: Colors.white, fontSize: 17.r),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
