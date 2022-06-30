import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class TripRequest {
  final Dio _dio = Dio();
  String accessToken = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImE5ZjA1ZGZjYWQ5NWZlMzY3MjA0YzNjNGQwNjExYzM0OWIxZWYwMDNlNGQ5MzQxNzY1NjAxNjNjMjc2NTAxODZlZWE1YWFiMmFlYThhMjU3In0.eyJhdWQiOiIyIiwianRpIjoiYTlmMDVkZmNhZDk1ZmUzNjcyMDRjM2M0ZDA2MTFjMzQ5YjFlZjAwM2U0ZDkzNDE3NjU2MDE2M2MyNzY1MDE4NmVlYTVhYWIyYWVhOGEyNTciLCJpYXQiOjE2NTUxOTg0NTksIm5iZiI6MTY1NTE5ODQ1OSwiZXhwIjoxNjU2NDk0NDU5LCJzdWIiOiIyNjEiLCJzY29wZXMiOltdfQ.NZBAdo_I7cf_qMPjpH3CYLXFmsxPCxNLYk_aN9lVgU1g_tUSm29X2YAS5JRkq9BY_GEiARqdB9Wy2GfTxCKHt63d1NfG7AKOs4JRFjWYaR19uzFxhNI4O9vNhlxD9esj0VYNWuMiJDikispLnSZW3ny42X9FYmfiiB4zbKKtn19g54vcOkEYVnDjPrQ-CgTv3-JCAIx772VeW_4JCxN6XD7EZB2g2J_1YB_2iQgPYBgWHRswxFDlNXzOMIuge-iFzTwJ5Tw5nwWhdUTNPOwbzTQGbvjas9uDSIetPOovodDSpQEdlho0Zk4tZ69Xhtbv6yx4cxmbVtBgqRCxy2vjSh-VrgY29SjabIEKnsP9TWICacyMA_SUQQ_aoAD5OTv0se989Wz4EMalY6Sry5090WDUIgmGHQESKzu7N1tihz8W-OqejnqGOs_GWobzNvH8G2R3yPdHKLFBnEMWzfp13BuU46aOYrbgy53oYP-Z7J3IVWHtgjmGNdPlBFDiDwy_mKcQ6IinvZ81mhz6hh4z05A-x4gowvJ86cFXHzCP5Z0o4u0-csVAhqDxu4ld77uRFrSrfB5iStGwg58IW6c1xpz7WLCeUYgHiCGRmmE-dJt-xMQbm336mNcyWQt4z38E8ptwN_S7pgfu6wS8UYGGegQZoJ-VBZEU5D6HQAbhkmo';

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