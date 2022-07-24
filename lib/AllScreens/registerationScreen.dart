import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_order_google_map/AllWidgets/progressDialog.dart';
import 'package:user_order_google_map/loginScreen.dart';
import 'package:user_order_google_map/main.dart';
import 'package:user_order_google_map/mainscreen.dart';

class registerationScreen extends StatelessWidget {
  static const String idScreen = "register";
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  //const registerationScreen({Key? key}) : super(key: key);

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
                height: 15,
                width: 20,
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameTextEditingController,
                      //obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          icon:
                              Icon(Icons.person, color: Colors.white, size: 30),
                          hintText: "Your Name",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: " Brand-Regular "),
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: 15,
                      width: 20,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      // obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          icon:
                              Icon(Icons.email, color: Colors.white, size: 30),
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
                      height: 15,
                      width: 20,
                    ),
                    TextField(
                      controller: phoneTextEditingController,
                      //obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          icon:
                              Icon(Icons.phone, color: Colors.white, size: 30),
                          hintText: "Phone Number",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: " Brand-Regular "),
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: 15,
                      width: 20,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          icon: Icon(Icons.lock, color: Colors.white, size: 30),
                          hintText: "Your Password",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: " Brand-Regular "),
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: 15,
                      width: 5,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (nameTextEditingController.text.length < 3) {
                          displayToastMessage(
                              "Name must be at least 3 characters.", context);
                        }
                        // ignore: non_constant_identifier_names
                        else if (!emailTextEditingController.text
                            .contains("@")) {
                          displayToastMessage(
                              "Email address is not Valid", context);
                        } else if (passwordTextEditingController.text.isEmpty) {
                          displayToastMessage(
                              "Phone number is mandatory", context);
                        } else if (passwordTextEditingController.text.length <
                            6) {
                          displayToastMessage(
                              "Password must be at least 6 Characters.",
                              context);
                        } else {
                          registerNewUser(context);
                        }
                      },
                      color: Colors.white,
                      child: Container(
                        height: 50,
                        width: 150,
                        child: Center(
                          child: Text("Submit",
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
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.idScreen, (route) => false);
                  },
                  child: Text(
                    "Already have an account? Sign in",
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
  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Please wait...");
        });
    final firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

//}

    // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    // void registerNewUser(BuildContext context) async {
    //   var emailTextEditingContoller;
    //   final User? firebaseUser = (await _firebaseAuth
    //           .createUserWithEmailAndPassword(
    //               email: emailTextEditingContoller.text,
    //               password: passwordTextEditingController.text)
    //           .catchError((errMsg) {
    //     displayToastMessage("Error: " + errMsg.toString(), context);
    //   }))
    //       .user;

    if (firebaseUser != null) {
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage(
          "Congratulations, Your Account has been created.", context);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, ((route) => false));
    } else {
      Navigator.pop(context);
      displayToastMessage("New user account has not been Created.", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
