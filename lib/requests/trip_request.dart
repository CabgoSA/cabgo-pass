import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class TripRequest {
  final Dio _dio = Dio();



  Future<dynamic> getServices() async {

    String accessToken = 'Bearer  eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjMwZGY4ZWQxYWNiYmRlMTY2ZmNlZDkyZjYxMDg2Yjg5ZDZkMDU4NzRkOGYyMmQ4NzZkYWQxODQ5MTE3ZWM4Y2ZjNWFjYmQwYzFmZjZhZjk4In0.eyJhdWQiOiIyIiwianRpIjoiMzBkZjhlZDFhY2JiZGUxNjZmY2VkOTJmNjEwODZiODlkNmQwNTg3NGQ4ZjIyZDg3NmRhZDE4NDkxMTdlYzhjZmM1YWNiZDBjMWZmNmFmOTgiLCJpYXQiOjE2NTQ2MDQ1MTEsIm5iZiI6MTY1NDYwNDUxMSwiZXhwIjoxNjU1OTAwNTExLCJzdWIiOiIyNjEiLCJzY29wZXMiOltdfQ.nFxYIB9VMDYb0W_Cbq1yAmIJSl3V-oJhq93kj4JbYIQES0KP5nsqvVfXLSdn9q8jAwJcxP3mJe4yYavX7ypXYSlX8uNaT2751ved-nLHukeX6E2CUvOFcbHy6n0wYjfk9ycWARRr3Nbcg1HOWYcUVSVAIuvGuV1x7EBaBdkd6wWIr3DkrjniYBI4SVHoCorTrjH6fdf8Z94BQBpQkwg6-uEicfJYvCkTakNb-rsSyQJARulhOJaJ4djTdE7DXGMYPEalIVvtgik_O3eyjJ-hJ8hJAXOrvze3urG8GQ5BFc6mbgbfjGIs01S-fWUXRYnrwSA0GFXMwVmFJ4AnkHfnKR-oEPxHdynhLrBn5-TcOhQFPa-BhWKplb6fDy11JUXBivgoW2UbmWDkkvvSvkcRHByu1SDzXxwn3KySE6NAl8MFUaFV9k95nFqWro2KhD7CKewLsc7nZDAfHtsoouZytVupufBWdkcskBfwR49Ksd-4KWnO9cKZmklJjZBuTtBPnn0--Y4OTb01xKcooJevA0phWXVQNC9-9W49pBP0tobCnAD6ezKqlVEa1eUSrdRZAVEnXZxIfUwFe1VImtANfiseWny2s5xOw40ncTS8bK9Kn6t_pJ7pX9YGZMa9yeHr0f0_NKalogliyRwOkoJCfotaMDRZZnkir-H5gO6jmws';
    _dio.options.headers["Authorization"] = accessToken;
    try {
      Response response = await _dio.get(
        dotenv.get('BASE_URL') + 'api/user/services'
      );

      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }


  Future<dynamic> sendRequest(LatLng source , LatLng destination, int serviceType , double distance) async {
    String accessToken = 'Bearer  eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjMwZGY4ZWQxYWNiYmRlMTY2ZmNlZDkyZjYxMDg2Yjg5ZDZkMDU4NzRkOGYyMmQ4NzZkYWQxODQ5MTE3ZWM4Y2ZjNWFjYmQwYzFmZjZhZjk4In0.eyJhdWQiOiIyIiwianRpIjoiMzBkZjhlZDFhY2JiZGUxNjZmY2VkOTJmNjEwODZiODlkNmQwNTg3NGQ4ZjIyZDg3NmRhZDE4NDkxMTdlYzhjZmM1YWNiZDBjMWZmNmFmOTgiLCJpYXQiOjE2NTQ2MDQ1MTEsIm5iZiI6MTY1NDYwNDUxMSwiZXhwIjoxNjU1OTAwNTExLCJzdWIiOiIyNjEiLCJzY29wZXMiOltdfQ.nFxYIB9VMDYb0W_Cbq1yAmIJSl3V-oJhq93kj4JbYIQES0KP5nsqvVfXLSdn9q8jAwJcxP3mJe4yYavX7ypXYSlX8uNaT2751ved-nLHukeX6E2CUvOFcbHy6n0wYjfk9ycWARRr3Nbcg1HOWYcUVSVAIuvGuV1x7EBaBdkd6wWIr3DkrjniYBI4SVHoCorTrjH6fdf8Z94BQBpQkwg6-uEicfJYvCkTakNb-rsSyQJARulhOJaJ4djTdE7DXGMYPEalIVvtgik_O3eyjJ-hJ8hJAXOrvze3urG8GQ5BFc6mbgbfjGIs01S-fWUXRYnrwSA0GFXMwVmFJ4AnkHfnKR-oEPxHdynhLrBn5-TcOhQFPa-BhWKplb6fDy11JUXBivgoW2UbmWDkkvvSvkcRHByu1SDzXxwn3KySE6NAl8MFUaFV9k95nFqWro2KhD7CKewLsc7nZDAfHtsoouZytVupufBWdkcskBfwR49Ksd-4KWnO9cKZmklJjZBuTtBPnn0--Y4OTb01xKcooJevA0phWXVQNC9-9W49pBP0tobCnAD6ezKqlVEa1eUSrdRZAVEnXZxIfUwFe1VImtANfiseWny2s5xOw40ncTS8bK9Kn6t_pJ7pX9YGZMa9yeHr0f0_NKalogliyRwOkoJCfotaMDRZZnkir-H5gO6jmws';
    _dio.options.headers["Authorization"] = accessToken;
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
      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

}