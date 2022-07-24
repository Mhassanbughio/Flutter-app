// ignore_for_file: prefer_interpolation_to_compose_strings

//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:user_order_google_map/AllScreens/registerationScreen.dart';
import 'package:user_order_google_map/AllWidgets/progressDialog.dart';
import 'package:user_order_google_map/main.dart';
import 'package:user_order_google_map/mainscreen.dart';
//import 'package:user_order_google_map/AllScreens/userInformationScreen.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "loginScreen";
  TextEditingController EmailTextEdiingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  //const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff154c79),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo.png',
                  //fit: BoxFit.cover,
                  height: 280,
                  width: 300,
                ),
              ),
              // Image(
              //   image: AssetImage('assets/images/logo.png'),
              //   height: 250.0,
              //   width: 400.0,
              //   alignment: Alignment.center,
              // ),
              SizedBox(height: 0),
              Text("Welcome to Saman",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Brand Bold", fontSize: 24.0,
                    color: Colors.white,
                    //textAlign: TextAlign.center
                  )),
              SizedBox(
                height: 20,
                width: 20,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: EmailTextEdiingController,
                      //obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          icon:
                              Icon(Icons.person, color: Colors.white, size: 30),
                          hintText: "Enter Email",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: " Brand-Regular "),
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          icon:
                              Icon(Icons.email, color: Colors.white, size: 30),
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: " Brand-Regular "),
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: 40,
                      width: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, MainScreen.idScreen, (route) => false);
                        // print("You Sign In");
                        if (!EmailTextEdiingController.text.contains("@")) {
                          displayToastMessage(
                              "Email address is not Valid", context);
                        } else if (passwordTextEditingController.text.isEmpty) {
                          displayToastMessage(
                              "password is mandatory.", context);
                        } else {
                          loginAndAuthenticateUser(context);
                        }
                      },
                      color: Colors.white,
                      child: Container(
                        height: 50,
                        width: 150,
                        child: Center(
                          child: Text("Login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: " Brand-Regular ")),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ],
                ),
              ),
              FlatButton(
                  onPressed: () {
                    // Navigator.pushAndRemoveUntil(context, userInformationScreen.idScreen, (route) => false);
                    // print("Forgot password button paressed");
                    Navigator.pushNamedAndRemoveUntil(context,
                        registerationScreen.idScreen, (route) => false);
                  },
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Brand-Regular"),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Please wait...");
        });

    //var emailTextEdiingController;
    final firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: EmailTextEdiingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      usersRef
          .child(firebaseUser.uid)
          .once()
          .then((value) => (DataSnapshot snap) {
                if (snap.value != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainScreen.idScreen, ((route) => false));
                  displayToastMessage("you are logged-in now.", context);
                } else {
                  Navigator.pop(context);
                  _firebaseAuth.signOut();
                  displayToastMessage(
                      "No record exists for this user. Please create new account.",
                      context);
                }
              });
      //usersRef.child(firebaseUser.uid).then((value) => (DataSnapshot snap) {});
    } else {
      Navigator.pop(context);
      displayToastMessage("Eror Ocurred, can not signined", context);
    }
  }
}
