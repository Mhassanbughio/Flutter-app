import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_order_google_map/AllScreens/registerationScreen.dart';
import 'package:user_order_google_map/DataHandler/appData.dart';
//import 'package:user_order_google_map/AllScreens/userInformationScreen.dart';
import 'package:user_order_google_map/loginScreen.dart';
import 'package:user_order_google_map/mainscreen.dart';
import 'package:user_order_google_map/Models/address.dart';
import "package:user_order_google_map/configMaps.dart";
//import 'dart:html';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

DatabaseReference usersRef =
    // ignore: deprecated_member_use
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //create: (BuildContext context) {  },
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        //font Family("Signatra"),
        theme: ThemeData(
          fontFamily: 'Signatra',
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          //primarySwatch:Colors.fromRGB(255, 3, 51, 90)
        ),
        initialRoute: registerationScreen.idScreen,
        //MainScreen.idScreen,
        routes: {
          //registerationScreen.idScreen: (context)=>uregisterationScreen(),
          registerationScreen.idScreen: (context) => registerationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          MainScreen.idScreen: (context) => MainScreen(),
          registerationScreen.idScreen: (context) => registerationScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
