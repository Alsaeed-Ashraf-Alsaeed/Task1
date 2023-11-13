import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task1/business_logic_layer/hotels_cubit/hotels_state.dart';
import 'package:task1/data_layer/models/hote_model.dart';
import 'package:task1/data_layer/repositories/hotels_repository.dart';

class HotelsCubit extends Cubit<HotelsStates> {
  HotelsCubit() : super(HotelsInitialState());
  late List<HotelModel> _hotels;
  late List<HotelModel> _filtredHotels;
  late List<HotelModel> _sortedHotels;

  Future<void> fetchHotelsFromRepository() async {
    _hotels = await HotelsRepository.fetchHotelsFromDio();
//emitting two states after getting the data to reload the widget for animation
    emit(HotelsLoadedState(hotels: _hotels, transition: 400.w));
    await Future.delayed(const Duration(milliseconds: 300));
    emit(HotelsLoadedState(hotels: _hotels, transition: 0));
  }

  Future<void> filterHotels(int? price, double? rating, int? stars) async {
    // by logic customer seeks lower price at highest stars and rating , so we take the price
    // as the max and the stars and rate as the min .

    if (price != null) {
      _filtredHotels = _hotels.where((e) => e.price <= price).toList();
    }
    if (rating != null) {
      _filtredHotels =
          _filtredHotels.where((e) => e.reviewScore >= rating).toList();
    }
    if (stars != null) {
      _filtredHotels =
          _filtredHotels.where((e) => e.stars >= (stars + 1)).toList();
    }

    emit(HotelsLoadedState(hotels: _hotels, transition: 700.w));
    await Future.delayed(const Duration(milliseconds: 700));
    emit(HotelsLoadedState(hotels: _filtredHotels, transition: 0));
  }

  //sorting is going to be only by rating and price , as the api contains data that can be
  // sorted only by price and rating , no distance data no time etc....

  // logically , the sorting is going to be from the from the lowest price to the highest and
  //the rating is going to from the highest to the lowest

  Future<void> sortHotel(int? idx) async {
    _sortedHotels = _hotels;

    if (idx == 5) {
      _sortedHotels.sort((a, b) => a.price.compareTo(b.price));
    }
    if (idx == 4) {
      _sortedHotels.sort((b, a) => a.reviewScore.compareTo(b.reviewScore));
    }

    emit(HotelsLoadedState(hotels: _hotels, transition: 700.w));
    await Future.delayed(const Duration(milliseconds: 600));
    emit(HotelsLoadedState(hotels: _sortedHotels, transition: 0));
  }
  void reloadHotelsFilterBar() {
    emit(ReloadHotelsFilterBar());
  }
}
