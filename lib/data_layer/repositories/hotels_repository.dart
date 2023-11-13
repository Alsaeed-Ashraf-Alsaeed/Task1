import 'package:task1/data_layer/models/hote_model.dart';
import 'package:task1/data_layer/web_services(APIs)/hotels_api.dart';

class HotelsRepository {


  static Future<List<HotelModel>> fetchHotelsFromDio() async {
    return (await HotelsAPI.fetchHotelsFromApi()).map((e) =>
       HotelModel.fromJson(e)
    ).toList();
  }


}