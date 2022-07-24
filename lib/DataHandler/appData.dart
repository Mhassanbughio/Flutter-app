import 'package:flutter/cupertino.dart';
import 'package:user_order_google_map/Models/address.dart';
import 'package:user_order_google_map/Models/address.dart';

//import '../Models/address.dart';

class AppData extends ChangeNotifier {
  dynamic Address, pickUpLoaction;

  void updatePickUpLoactionAddress(pickUpAddress) {
    var pickUpLoaction = pickUpAddress;
    notifyListeners();
  }
}
