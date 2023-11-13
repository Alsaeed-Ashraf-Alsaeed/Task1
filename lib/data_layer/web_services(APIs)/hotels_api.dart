import 'package:dio/dio.dart';

class HotelsAPI{


 static late Dio dio ;
  static const String _baseURL = "https://www.hotelsgo.co/test/";
  static const String _endpoint1 = "hotels";
 static void setHotelsDio(){

    dio= Dio(
      BaseOptions(
        baseUrl: _baseURL,
        receiveDataWhenStatusError: true,
      ),

    );
  }

  static Future<List<dynamic>> fetchHotelsFromApi() async {
    setHotelsDio();
    Response res = await dio.get(_endpoint1);


    return res.data;

  }



}