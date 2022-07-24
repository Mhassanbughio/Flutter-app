import 'dart:async';
//import "dart:convert";
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:user_order_google_map/AllScreens/registerationScreen.dart';
import 'package:user_order_google_map/AllWidgets/Divider.dart';
import 'package:user_order_google_map/loginScreen.dart';

import 'Assistants/assistantMethods.dart';
import 'DataHandler/appData.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";

  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //Position currentPosition;
  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingofMap = 0;

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 15);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    //callAssistantclass
    Future<String>? address =
        await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your Adress :: " + address.toString());
  }

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  late GoogleMapController newGoogleMapController;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    // var pickUpLoaction;

    ///local veriable

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Welcome to Saman",
          style: TextStyle(fontFamily: "Bold-brand"),
        ),
      ),

      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "user_icon.png",
                        height: 10.0,
                        width: 5.0,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Profile Name",
                            style: TextStyle(
                                fontFamily: "Bold-Brand", fontSize: 5.0),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text("Visit Profile",
                              style: TextStyle(fontFamily: "Bold-Brand")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              DividerWidget(),
              SizedBox(
                height: 12.0,
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text("History",
                    style: TextStyle(fontFamily: "Bold-Brand", fontSize: 15.0)),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("visit profile",
                    style: TextStyle(fontFamily: "Bold-Brand", fontSize: 15.0)),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About",
                    style: TextStyle(fontFamily: "Bold-Brand", fontSize: 15.0)),
              ),
            ],
          ),
        ),
      ),

      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingofMap),
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingofMap = 300.0;
              });
              locatePosition();
            },
          ),
          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  radius: 20.0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Hi There!",
                      style:
                          TextStyle(fontSize: 12.0, fontFamily: "Bold-Brand"),
                    ),
                    Text("Where to go?",
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: "Bold-Brand")),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 16.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.black),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Search For place",
                            style: TextStyle(fontFamily: "Bold-Brand"),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        Icon(Icons.home, color: Colors.grey),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Provider.of<AppData>(context).pickUpLoaction !=
                                      null
                                  ? Provider.of<AppData>(context)
                                      .pickUpLoaction
                                      .placeName
                                  : "Add Home",
                              style: TextStyle(fontFamily: "Bold-Brand"),
                            ),
                            SizedBox(
                              height: 1.0,
                            ),
                            Text(
                              "Your Living Home adress",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12.0,
                                  fontFamily: "Bold-Brand"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DividerWidget(),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Icon(Icons.work, color: Colors.grey),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add",
                              style: TextStyle(fontFamily: "Bold-Brand"),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Your office adress",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12.0,
                                  fontFamily: "Bold-Brand"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          registerationScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 3, 51, 90)),
                            child: Text("Demage",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),
                        SizedBox(width: 65),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 3, 51, 90)),
                          child: Text(
                            "Missing Parts",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        SizedBox(width: 65),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 3, 51, 90)),
                          child: Text(
                            "Other",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // body: GoogleMap(initialCameraPosition:
      // CameraPosition(target: LatLng(22.5448131, 88.3403691),
      // zoom: 15,
      // )
      // ),
    );
  }

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties
  //       .add(DiagnosticsProperty<Position>('currentPosition', currentPosition));
  //}
}
