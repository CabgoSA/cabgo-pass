import 'dart:js_util/js_util_wasm.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class Login {


  Future<Object> passangerLogin({
    @required String username,
    @required String password,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://cabgo.co.za/oauth/token'));
    request.fields.addAll({
      'username': username,
      'password': password,
      'grant_type': 'password',
      'client_secret': 'bSB7ha4gWUFG6IZCNdxBHVwoAh1W87ZUtBVSKBjd',
      'client_id': '2',
      'deveice_token': 'e6AH-mhp_0I:APA91bFyRFlzohXy7wLP0TwvIKMg3RzZG1UhaAVkljUu3_J84bgllg1wQQqkklK1v1LxLjx0P0Krz0XeajW4-750p6tq3nm0vjknGjQ3rJOvY-ATeeVxU3BX_zzF5Ip9p66IzcB0BngL',
      'device_id': 'bbf811a3d948e70a'
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final  token = response.toString();

      print(token);
    }
    else {
      print(response.reasonPhrase);
    }
  }
}