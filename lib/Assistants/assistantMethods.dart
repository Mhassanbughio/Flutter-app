//import 'package:geolocator/geolocator.dart';
//import 'package:geolocator/geolocator.dart';
// ignore_for_file: non_constant_identifier_names
//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:user_order_google_map/Assistants/requestAssistant.dart';
import 'package:user_order_google_map/DataHandler/appData.dart';
import 'package:user_order_google_map/Models/address.dart';
import "package:user_order_google_map/configMaps.dart";

class AssistantMethods {
  static Future<String>? get placeAdress => null;

  static Future<Future<String>?> searchCoordinateAddress(
      Position position, context) async {
    String st1, st2, st3, st4;
    String plcaeAdress = "";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapkey";

    var response = await RequestAssistant.getRequest(url);
    if (response != "failed") {
      //var placeAdress = response["results"][0]["formatted_adress"];
      st1 = response["results"][0]["address_components"][0]["long_name"];
      st2 = response["results"][0]["address_components"][1]["long_name"];
      st3 = response["results"][0]["address_components"][5]["long_name"];
      st4 = response["results"][0]["address_components"][6]["long_name"];
      var placeAdress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

      // Address userPickUpAddress = new Address(
      //     latitude: '',
      //     placeFormattedAddress: '',
      //     placeName: '',
      //     Longitude: 0.333,
      //     PlaceId: '');
      Address userPickUpAddress = new Address(
          latitude: position.latitude.toString(),
          placeFormattedAddress: placeAdress,
          placeName: st1 + ", " + st2 + ", " + st3 + ", " + st4,
          Longitude: position.longitude,
          PlaceId: response["results"][0]["place_id"]);
      userPickUpAddress.Longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude as String;
      userPickUpAddress.placeName = placeAdress;
      // Provider.of<AppData>(context: false).updatePickUpLocationAdress(userPickUpAddress);

      Provider.of<AppData>(context, listen: false)
          .updatePickUpLoactionAddress(userPickUpAddress);
    }
    return placeAdress;
  }
}
