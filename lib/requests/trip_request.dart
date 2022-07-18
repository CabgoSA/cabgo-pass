import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class TripRequest {
  final Dio _dio = Dio();
  String accessToken = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImI0ZTFjMTU4ZmNkMGUwMjk3NDM5ZGJmYjI4MDA1Mzk2NjhlNTgzYTJiMTk5ZjUxM2ZmM2I5YzJmODFiMjA4OTYxMWNlM2QzMzZjM2UzNWRhIn0.eyJhdWQiOiIyIiwianRpIjoiYjRlMWMxNThmY2QwZTAyOTc0MzlkYmZiMjgwMDUzOTY2OGU1ODNhMmIxOTlmNTEzZmYzYjljMmY4MWIyMDg5NjExY2UzZDMzNmMzZTM1ZGEiLCJpYXQiOjE2NTc2MTIwOTYsIm5iZiI6MTY1NzYxMjA5NiwiZXhwIjoxNjg5MTQ4MDk2LCJzdWIiOiIyNjEiLCJzY29wZXMiOltdfQ.c67xr9HiBUvIwWg7NekRFFIdrwi69PkjmYaRJOZazYcPfydmqlhv6lcmcZhOyO6wKGaYiP4dTDqnv5SmYOdT6hZmM9ZWxGcOpzPcilEJSDSrulCQN7DKQ9VMHWdETGIhReNDBQKMCVCbx8ocj5MOhy399b3xOFYRX9CdLHz1F8FXFAu_Lsb3MYy3KblAS3bfg-PmnW-LLDqhiy648LXMy8aAH0-izdTu1uHFT5ZSYe4DnbuLch3jjLfzBLfu5Nm8fHXwltT6m0kDXLJAXjKe4AW78A3HLHgxAj0yKD3XCXYWjVrclu5_mZ90tBSlKtKLsIRcUL6pZ12bdUqIPyeAA3Mi-EiKG1E0Tu51gdwl_zcDu6LZxiWgQtp19KdRJOy-wY7VRmVZb9bnOt38ZuT--rFENEauCM62HW_8AR4tU1psLQaIO56oIbf3cvSGwKkQoNdq8xVIDWcOzRLM5dLTUOoTh-W2rsAx6vbnBrVjoGkfL4hjZ8J1UdtsYeZrc-hli9MSLM8_y9re_1UrFSpU9YO5-z3r7lr5qp7Cu3ETu2uva4Ryz6VS2OvqS01q71WE21SxYkFkejxnB2YcnS8zj0kSac5vWUjnufsJ57MsEDDFN7-FKFvZO0JsLQ4G6-jYjHAwUHEA04COM7TrVPaF83-cH7PxgyyCvt4gEw3lzZ4';

  Future<dynamic> getServices() async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["Authorization"] = accessToken;
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


  Future<dynamic> sendRequest(LatLng source , LatLng destination, int serviceType , double distance) async {
     _dio.options.headers["Authorization"] = accessToken;
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
      return e.response.data;
    }
  }

}