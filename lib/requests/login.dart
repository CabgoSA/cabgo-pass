import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';




class ApiClient {
  final Dio _dio = Dio();


  Future<dynamic> registerUser(String email, String firstName,  String lastName,  String phone,  String password ) async {
    try {
      Response response = await _dio.post(
          dotenv.get('BASE_URL') + 'api/user/signup' ,
            data : {
              'first_name': firstName,
              'last_name': lastName,
              'email': email,
              'password': password,
              'password_confirmation': password,
              'device_token': 'e6AH-mhp_0I:APA91bFyRFlzohXy7wLP0TwvIKMg3RzZG1UhaAVkljUu3_J84bgllg1wQQqkklK1v1LxLjx0P0Krz0XeajW4-750p6tq3nm0vjknGjQ3rJOvY-ATeeVxU3BX_zzF5Ip9p66IzcB0BngL',
              'mobile': '+27'+phone,
              'dial_code': '0027',
              'device_type': 'android',
              'login_by': 'manual',
              'device_id': 'bbf811a3d948e70a'
            },
        options: Options(headers: {'Accept': 'application/json'}),
      );

        return response.data;

    } on DioError catch (e) {
      return e.response.data;
    }
  }

  Future<dynamic> otp(String phone) async {
    try {
      Response response = await _dio.post(
        dotenv.get('BASE_URL') + 'api/user/otp' ,
        data : {
          'mobile': phone,
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }



  Future<dynamic> login(String username, String password) async {
    try {
      Response response = await _dio.post(
        dotenv.get('BASE_URL') + 'oauth/token',
        data: {
          'username': username,
          'password': password,
          'grant_type': 'password',
          'client_secret': 'bSB7ha4gWUFG6IZCNdxBHVwoAh1W87ZUtBVSKBjd',
          'client_id': '2',
          'device_token': 'e6AH-mhp_0I:APA91bFyRFlzohXy7wLP0TwvIKMg3RzZG1UhaAVkljUu3_J84bgllg1wQQqkklK1v1LxLjx0P0Krz0XeajW4-750p6tq3nm0vjknGjQ3rJOvY-ATeeVxU3BX_zzF5Ip9p66IzcB0BngL',
          'device_id': 'bbf811a3d948e70a'
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );


      return response.data;
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  // Future<dynamic> getUserProfileData(String accessToken) async {
  //   try {
  //     Response response = await _dio.get(
  //       'https://api.loginradius.com/identity/v2/auth/account',
  //       queryParameters: {'apikey': ApiSecret.apiKey},
  //       options: Options(
  //         headers: {'Authorization': 'Bearer $accessToken'},
  //       ),
  //     );
  //     return response.data;
  //   } on DioError catch (e) {
  //     return e.response!.data;
  //   }
  // }
  //
  // Future<dynamic> updateUserProfile({
  //   required String accessToken,
  //   required Map<String, dynamic> data,
  // }) async {
  //   try {
  //     Response response = await _dio.put(
  //       'https://api.loginradius.com/identity/v2/auth/account',
  //       data: data,
  //       queryParameters: {'apikey': ApiSecret.apiKey},
  //       options: Options(
  //         headers: {'Authorization': 'Bearer $accessToken'},
  //       ),
  //     );
  //     return response.data;
  //   } on DioError catch (e) {
  //     return e.response!.data;
  //   }
  // }
  //
  // Future<dynamic> logout(String accessToken) async {
  //   try {
  //     Response response = await _dio.get(
  //       'https://api.loginradius.com/identity/v2/auth/access_token/InValidate',
  //       queryParameters: {'apikey': ApiSecret.apiKey},
  //       options: Options(
  //         headers: {'Authorization': 'Bearer $accessToken'},
  //       ),
  //     );
  //     return response.data;
  //   } on DioError catch (e) {
  //     return e.response!.data;
  //   }
  // }
}