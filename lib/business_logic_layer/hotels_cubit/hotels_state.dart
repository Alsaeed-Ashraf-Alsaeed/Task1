import '../../data_layer/models/hote_model.dart';

class HotelsStates {}

class HotelsInitialState extends HotelsStates {}

class HotelsLoadingState extends HotelsStates {}

class HotelsLoadedState extends HotelsStates {
  List<HotelModel> hotels;
  double transition;

  HotelsLoadedState({
    required this.transition,
    required this.hotels,
  });
}

class HotelsErrorState extends HotelsStates {}

class ReloadHotelsFilterBar extends HotelsStates {}

class ReloadHotelsCardsStates extends HotelsStates {}
