import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/forgotpass_controller.dart';
import '../controller/login_controller.dart';
import '../controller/logout_controller.dart';
import 'LeaveListScreen.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  ForgotpassController forgotpassController = ForgotpassController();
  LoginController loginController = LoginController();
  LogoutController logoutController = LogoutController();

  SharedPreferences? preferences;
  String? token;
  String? username;

  @override
  void initState() {
    checktoken();
    super.initState();
  }

  checktoken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("login");
    // forgotpassController.changePasswordApi(context,preferences.getString("login")!);

    SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("username");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: SafeArea(
          child: Scaffold(
            drawerEnableOpenDragGesture: false,
            key: _scaffoldKey,
            backgroundColor: Color(0xff2b17d1),
        appBar: AppBar(
          backgroundColor: Color(0xffbf7edc),
          leading: Builder(
            builder: (context) => IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                ),
                onPressed: () => setState(() {
                  _scaffoldKey.currentState!.openDrawer();
                    })),
          ),
          actions: <Widget>[
            MaterialButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashboardScreen()),
                );
              },
              child: Text("Back"),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.transparent,
          child: ListView(
            padding: EdgeInsets.only(top: 80.0),
            children: [
              ListTile(
                title: Text(
                  "Hello ${username.toString()}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.white),
                ),
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                title: Container(
                    child: Row(
                  children: [
                    Image.asset(
                      'assets/leaveicon1.png',
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('Leave Applications',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white)),
                  ],
                )),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LeaveListScreen()));
                },
              ),
              ListTile(
                title: Container(
                    child: Row(
                  children: [
                    Image.asset(
                      'assets/changepassword.png',
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('Change Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white)),
                  ],
                )),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => ForgotPassScreen()));
                },
              ),
              // ListTile(
              //   title: Container(
              //       child: Row(
              //     children: [
              //       Icon(
              //         Icons.location_on_outlined,
              //         color: Colors.white,
              //       ),
              //       SizedBox(
              //         width: 10.0,
              //       ),
              //       Text('Driving Route',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 18.0,
              //               color: Colors.white)),
              //     ],
              //   )),
              //   onTap: () async {
              //     Navigator.of(context).pushReplacement(MaterialPageRoute(
              //         builder: (BuildContext context) => MapView(
              //               lat: checkInController.latitude.toString(),
              //               long: checkInController.longitude.toString(),
              //             )));
              //   },
              // ),
              ListTile(
                title: Container(
                    child: Row(
                  children: [
                    Image.asset(
                      'assets/logouticon1.png',
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white)),
                  ],
                )),
                onTap: () async {
                  showlogoutPopup();
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (BuildContext context) => LoginScreen()));
                },
              ),
            ],
          ),
        ),
        body: Stack(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/bgimg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // IconButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => DashboardScreen()),
                  //         );
                  //       });
                  //     },
                  //     icon: Icon(
                  //       Icons.arrow_back_ios,
                  //       color: Colors.white,
                  //     )),
                  SizedBox(
                    height: 60.0,
                  ),
                  Center(
                    child: Text(
                      "Change Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 40.h,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        obscureText: true,
                        controller: forgotpassController.currentController,
                        style: TextStyle(color: Colors.white),
                        maxLength: 100,
                        maxLines: 1,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30.0)),
                          counterText: "",
                          labelText: 'Current Password',
                          hintText: 'Enter Current Password',
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: myinputborder(),
                          focusedBorder: myfocusborder(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 40.h,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        obscureText: true,
                        controller: forgotpassController.newController,
                        style: TextStyle(color: Colors.white),
                        maxLength: 100,
                        maxLines: 1,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30.0)),
                          counterText: "",
                          labelText: 'New Password',
                          hintText: 'Enter new Password',
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: myinputborder(),
                          focusedBorder: myfocusborder(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 40.h,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        obscureText: true,
                        controller: forgotpassController.confrimController,
                        style: TextStyle(color: Colors.white),
                        maxLength: 100,
                        maxLines: 1,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30.0)),
                          counterText: "",
                          labelText: 'Confrim Password',
                          hintText: 'Enter Confrim Password',
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: myinputborder(),
                          focusedBorder: myfocusborder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        validation(context);
                        print("submit clicked...");
                      },
                      child: Container(
                        height: 35.h,
                        width: 90.h,
                        decoration: BoxDecoration(
                          color: Color(0xff41069D),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      )),
    );
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(
          color: Colors.white,
          width: 2,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(
          color: Colors.white,
          width: 2,
        ));
  }

  void validation(BuildContext context) async {
    if (forgotpassController.currentController.text.isEmpty) {
      showSnackBar(context,"Current Password is Required");

    } else if (forgotpassController.newController.text.isEmpty) {
      showSnackBar(context,"New Password is Required");

    } else if (forgotpassController.confrimController.text.isEmpty) {
      showSnackBar(context,"Confrim Password is Required");

    } else if (forgotpassController.newController.text !=
        forgotpassController.confrimController.text) {
      showSnackBar(context,"Password does not match.\nPlease re-type again");

    } else {
      bool isOnline = await hasNetwork();
      if (isOnline) {
        print("clicked");
        forgotpassController.changePasswordApi(token!, context);
      } else {
        forgotpassController.validationSnackbar(
            "Error", "Internet not available");
      }
    }
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Go Back'),
            content: Text('Do you want to Go Back?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('No'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff41069D),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => DashboardScreen()));
                },
                //return true when click on "Yes"
                child: Text('Yes'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff41069D),
                ),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  Future<bool> showlogoutPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Logout App'),
            content: Text('Do you want to Logout an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('No'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff41069D),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  bool isOnline = await hasNetwork();
                  if (isOnline) {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    logoutController.logoutApi(
                        preferences.getString("login")!, context);
                    await preferences.remove('login');
                  } else {
                    Get.snackbar("Error", "Internet not available");
                  }
                },
                //return true when click on "Yes"
                child: Text('Yes'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff41069D),
                ),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Color(0xff41069D),
      padding: EdgeInsets.all(20),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
