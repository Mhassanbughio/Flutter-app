import 'dart:convert';
//import 'dart:html';
//import 'dart:html';
//import "dart.convert";

import 'package:http/http.dart' as http;
import 'package:user_order_google_map/configMaps.dart';

class RequestAssistant {
  //String
  static Future<dynamic> getRequest(url) async {
    // ignore: unused_local_variable
    //http.Response response = await http.get(url);

    // ignore: unnecessary_string_interpolations
    http.Response response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        String jSonData = response.body;
        var decodeData = jsonDecode(jSonData);
        return decodeData;
      } else {
        return "failed, no response from server";
      }
    } catch (exp) {
      return "failed";
    }
  }
}
