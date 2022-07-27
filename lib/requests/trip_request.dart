import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../exceptions/exceptions.dart';




class TripRequest {
  final Dio _dio = Dio();

  Future<dynamic> getServices(String accessToken) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["Authorization"] = 'Bearer $accessToken';
    try {
      Response response = await _dio.get(
        dotenv.get('BASE_URL') + 'api/user/services'
      );
      print(response);
      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }


  Future<dynamic> sendRequest(String accessToken, LatLng source , LatLng destination, int serviceType , double distance) async {
     _dio.options.headers["Authorization"] = 'Bearer $accessToken';
     _dio.options.headers['content-Type'] = 'application/json';
    try {
      Response response = await _dio.post(
        dotenv.get('BASE_URL') + 'api/user/send/request' ,
        data : {
          's_latitude': source.latitude,
          's_longitude': source.longitude,
          'd_latitude': destination.latitude,
          'd_longitude': destination.longitude,
          'service_type': serviceType,
          'distance': distance,
          'use_wallet': '0',
          'payment_mode': 'CASH'
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );

      print('sent');
      print(response);
      return response.data;
    } on DioError catch (e) {
      throw RequestError();
    }
  }

}