import 'package:cabgo/exceptions/exceptions.dart';
import 'package:cabgo/requests/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';




class ApiClient {
  final Dio _dio = Dio();


  Future<dynamic> registerUser({@required String email, @required String firstName,
                                @required  String lastName,@required  String phone,
                                @required  String password,@required  String passwordConfirmation,
                                @required deviceToken,@required String deviceType,
                                @required String deviceId
                              }) async {
    try {
      String trimmedPhone = phone.replaceAll(' ', '');
      if(trimmedPhone.startsWith('0')){
        trimmedPhone = trimmedPhone.substring(1);
      }

      Response response = await _dio.post(
          dotenv.get('BASE_URL') + 'api/user/signup' ,
            data : {
              'first_name': firstName,
              'last_name': lastName,
              'email': email,
              'password': password,
              'password_confirmation': passwordConfirmation,
              'device_token': deviceToken,
              'mobile': '+27$trimmedPhone',
              'dial_code': '+27',
              'device_type': deviceType,
              'login_by': 'manual',
              'device_id': deviceId
            },
        options: Options(headers: {'Accept': 'application/json'}),
      );

        return response.data;

    } on DioError catch (e) {
      throw UserRegistrationError();
    }
  }

  Future<dynamic> verifyOtp(String phone, String otp) async {
    try {
      Response response = await _dio.post(
        dotenv.get('BASE_URL') + 'api/user/verify/otp',
        data: {
          'mobile': phone,
          'otp': otp
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );

      print(response);
      return;
    } on DioError catch (e) {
      return e.response.data;
    }

  }

  Future<dynamic> login(String email, String password,String deviceToken, String deviceId ) async {
    try {
      Response response = await _dio.post(
        dotenv.get('BASE_URL') + '/oauth/token',
        data: {
          'username': email,
          'password': password,
          'grant_type': 'password',
          'client_id': '2',
          'client_secret': 'bSB7ha4gWUFG6IZCNdxBHVwoAh1W87ZUtBVSKBjd',
          'device_token': deviceToken,
          'device_id': deviceId
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );




      return response.data;
    } catch(e){
      throw InvalidCredentials();
    }
  }


Future<dynamic> delete(String accessToken) async {

    try {
       _dio.options.headers["Authorization"] = 'Bearer $accessToken';
       Response response = await _dio.post(
        dotenv.get('BASE_URL') + 'api/user/delete',

        options: Options(headers: {'Accept': 'application/json'}),
      );

      return response;

    } catch(e){
      
    }
  }


  Future<dynamic> logout(String accessToken) async {
    try {
      _dio.options.headers["Authorization"] = 'Bearer $accessToken';
      Response response = await _dio.post(
        dotenv.get('BASE_URL') + '/api/user/logout',
        options: Options(headers: {'Accept': 'application/json'}),
      );

      return response.data;
    } catch(e){
      throw InvalidCredentials();
    }
  }

  Future<void> callDriver(String accessToken,String userPhone,String driverPhone ) async{

    try {
      _dio.options.headers["Authorization"] = 'Bearer $accessToken';
      await _dio.post(
        dotenv.get('BASE_URL') + 'api/user/call/user',
        data: {
          'phone_number': userPhone,
          'phone_number2': driverPhone,
        },

        options: Options(headers: {'Accept': 'application/json'}),
      );

    } on DioError catch (e) {
      throw ErrorCallingDriver;
    }
  }



  Future<void> setFcmToken(String accessToken,token) async{
    try{
      _dio.options.headers["Authorization"] = 'Bearer $accessToken';
      _dio.options.headers['content-Type'] = 'application/json';
      Response response = await _dio.get(
        dotenv.get('BASE_URL') + '/api/user/setFcmToken/$token',

        options: Options(headers: {'Accept': 'application/json'}),
      );
    }catch(e){

    }
  }

  Future<dynamic> requestResetOtp(String phone) async {
    try {
      String trimmedPhone = phone.replaceAll(' ', '');
      if(trimmedPhone.startsWith('0')){
        trimmedPhone = trimmedPhone.substring(1);
      }
      Response response = await _dio.post(
        dotenv.get('BASE_URL') + 'api/user/forgot/password',
        data: {
          'mobile': '+27$trimmedPhone',
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );
      return response;

    } on DioError catch (e) {
      throw ResetPasswordError();
    }
  }

  Future<dynamic> verifyOtpPasswordReset(String phone, String otp) async {
    try {
      String trimmedPhone = phone.replaceAll(' ', '');
      if(trimmedPhone.startsWith('0')){
        trimmedPhone = trimmedPhone.substring(1);
      }
      Response response = await _dio.post(
        dotenv.get('BASE_URL') + 'api/user/verify/otp/password',
        data: {
          'mobile': '+27$trimmedPhone',
          'otp': otp
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );


      return response;
    } on DioError catch (e) {
      throw ErrorVerifyingOtpPasswordReset();
    }
  }

  Future<dynamic> passwordReset(String phone, String newPassword, newPasswordConfirm) async {
      try {
        String trimmedPhone = phone.replaceAll(' ', '');
        if(trimmedPhone.startsWith('0')){
          trimmedPhone = trimmedPhone.substring(1);
        }
        Response response = await _dio.post(
          dotenv.get('BASE_URL') + 'api/user/reset/password',
          data: {
            'mobile': '+27$trimmedPhone',
            'password': newPassword,
            'password_confirmation': newPasswordConfirm,
          },
          options: Options(headers: {'Accept': 'application/json'}),
        );

        return response;
      }catch(e){
        throw ErrorPasswordReset();
      }
  }

  Future<Response> fetchRideDetails(String requestID,String accessToken) async {

    int id = int.parse(requestID);

    _dio.options.headers["Authorization"] = 'Bearer $accessToken';
    try {
      var response = await _dio.get(
          dotenv.get('BASE_URL') + 'api/user/trip/details/$id'
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<dynamic> getUser(String accessToken) async {

    try {
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers["Authorization"] = 'Bearer $accessToken';
      dynamic response = await _dio.get(
          dotenv.get('BASE_URL') + 'api/user/details'
      );

      return response.data;
    } on DioError catch (e) {
      throw ErrorGettingUser();
    }
  }



}

