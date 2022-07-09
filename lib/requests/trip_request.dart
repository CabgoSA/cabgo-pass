import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class TripRequest {
  final Dio _dio = Dio();
  String accessToken = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjE1YmMyYjEyNWY2N2M0Y2ZlYTQ0ZWI5OTVjZGQxYmI4YjYyNjBjNzE4MzU0M2I0YmVjZGVjMTVkZmI4ZGNjNDUyYzhlYjUwYWU1ZjY1NDliIn0.eyJhdWQiOiIyIiwianRpIjoiMTViYzJiMTI1ZjY3YzRjZmVhNDRlYjk5NWNkZDFiYjhiNjI2MGM3MTgzNTQzYjRiZWNkZWMxNWRmYjhkY2M0NTJjOGViNTBhZTVmNjU0OWIiLCJpYXQiOjE2NTczMTQ0MjQsIm5iZiI6MTY1NzMxNDQyNCwiZXhwIjoxNjg4ODUwNDI0LCJzdWIiOiIyNjEiLCJzY29wZXMiOltdfQ.JS0DQ2dIoLFI7WoHJVA0pjb78hBl7Jhx29LNOC4d5NxAL6iPUAQ5xLHSsqzX7vVltqSiZS1jJLe6W84zKvWlThvca2g8qvJlUDwplyVn2pH1poXYI8Ew5c--2TLGdmSw092UKvU6xZ_fGUKuXQx7_S39AVX4CenzwK8epjdenD7pyDdJtnfMpe7nylmKfBGhVAe0rH7iXHE-OywbUmIb2Dvlk8UdlzHys9XV33bmjCt_69xhFOLiR-i9KbjYI4kkMXze2G_FZTbg8YXOIbTHHcY6T5hnWM74804nQWYK0IW0_5EeKBbSwMVY7LnlB0FNGgDTwh6aZ5bshSO1l3-eaUiE7h0keosRr05BALOcOnwj4g7XJy02O8nTLJT5E-k1M56hlo_iKTla3EXGUTJLfL8IzCjJU76lkexyic73pX6S3eZHaNbgc2r8hWXYLfRoUjJ3JBIrIkWIMX6d0GOvutcvIPE-M3G7BOCaWcCjFHfadB7HgaH8h19GKGLRLGJMugQcySpPMqp7RX14YyAje0eobLijIzIkqXbLzSK5rx2GihQeydEaCxRFUc8ogglUdYYj7_8Qj6oF12Z0aEEMtpIg3p5Yodf04HwJ9nCRg2HsLaTZbVgtSqFk_y9E-IB74-1P5HIG4z7UP5V20J2X5FuH9YCHiKp94hb0YVjwrsc';

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