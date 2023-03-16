import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:erp_project/controller/leaveapply_controller.dart';
import 'package:erp_project/controller/login_controller.dart';
import 'package:erp_project/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/logout_controller.dart';
import 'LeaveListScreen.dart';
import 'forgotpass_screen.dart';
import 'login_screen.dart';

class LeaveApplicationScreen extends StatefulWidget {
  const LeaveApplicationScreen({Key? key}) : super(key: key);

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  LeaveApplyController leaveApplyController = LeaveApplyController();
  LogoutController logoutController = LogoutController();

  String? token;
  String? username;
  LoginController loginController = LoginController();
  DateTime? startDate, endData;

  @override
  void initState() {
    checktoken();
    super.initState();
  }

  checktoken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("login");

    SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("username");

    // forgotpassController.changePasswordApi(context,preferences.getString("login")!);
  }

  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );
  }

  // String? startDateValidator(value) {
  //   if (startDate == null) return "select the date";
  // }
  //
  // String? endDateValidator(value) {
  //   if (startDate != null && endData == null) {
  //     return "select Both data";
  //   }
  //   if (endData == null) return "select the date";
  //   if (endData!.isBefore(startDate!)) {
  //     return "End date must be after startDate";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: SafeArea(
          child: Scaffold(
            drawerEnableOpenDragGesture: false,
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
                      Scaffold.of(context).openDrawer();
                    })),
          ),
          actions: <Widget>[
            MaterialButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LeaveListScreen()),
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
                  //               builder: (context) => LeaveListScreen()),
                  //         );
                  //       });
                  //     },
                  //     icon: Icon(
                  //       Icons.arrow_back_ios,
                  //       color: Colors.white,
                  //     )),
                  SizedBox(
                    height: 50.0,
                  ),
                  Center(
                    child: Text(
                      "Leave Application",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //         color: Colors.black,
                  //         width: 3,
                  //       ),
                  //     ),
                  //     child: Center(
                  //         child: TextField(
                  //           showCursor: false,
                  //           readOnly: true,
                  //
                  //           controller: leaveApplyController.startdateController,
                  //           decoration: new InputDecoration(
                  //
                  //             hintText: ' Start Date',
                  //             suffixIcon: Icon(Icons.calendar_month)
                  //           ),
                  //
                  //           onTap: () async {
                  //             DateTime? pickedDate = await showDatePicker(
                  //                 context: context,
                  //                 initialDate: DateTime.now(),
                  //                 firstDate: DateTime(1950),
                  //                 //DateTime.now() - not to allow to choose before today.
                  //                 lastDate: DateTime(2100));
                  //
                  //             if (pickedDate != null) {
                  //               print(
                  //                   pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  //               String formattedDate =
                  //               DateFormat('yyyy-MM-dd')
                  //                   .format(pickedDate);
                  //               print(
                  //                   formattedDate); //formatted date output using intl package =>  2021-03-16
                  //               setState(() {
                  //                 leaveApplyController.startdateController.text =
                  //                     formattedDate; //set output date to TextField value.
                  //               });
                  //             } else {}
                  //           },
                  //
                  //         ),
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Types of Leaves :",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        DropdownButton<String>(
                          focusColor: Colors.white,
                          value: leaveApplyController.chosenValue,
                          dropdownColor: Color(0xffb476db),
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.white,
                          items: <String>['Casual Leave', 'Leave Without Pay']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,

                              child: Text(
                                value,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Select Leave type",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              leaveApplyController.chosenValue = value!;
                            });
                          },

                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: leaveApplyController.radioButtonid,
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        onChanged: (val) {
                          setState(() {
                            leaveApplyController.radioButtonItem = 'Full Day';
                            leaveApplyController.radioButtonid = 1;
                          });
                        },
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            leaveApplyController.radioButtonItem = 'Full Day';
                            leaveApplyController.radioButtonid = 1;
                          });
                        },
                        child: Text(
                          'Full Day',
                          style: new TextStyle(
                              fontSize: 17.0, color: Colors.white),
                        ),
                      ),
                      Radio(
                        value: 2,
                        groupValue: leaveApplyController.radioButtonid,
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        onChanged: (val) {
                          setState(() {
                            leaveApplyController.radioButtonItem = 'Half Day';
                            leaveApplyController.radioButtonid = 2;
                          });
                        },
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            leaveApplyController.radioButtonItem = 'Half Day';
                            leaveApplyController.radioButtonid = 2;
                          });
                        },
                        child: Text(
                          'Half Day',
                          style: new TextStyle(
                              fontSize: 17.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 75,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        showCursor: false,
                        readOnly: true,
                        autocorrect: true,
                        controller: leaveApplyController.startdateController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Start Date',
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.transparent,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        onTap: () async {
                          startDate = await pickDate();

                          if (startDate != null) {
                            print(
                                startDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(startDate!);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              leaveApplyController.startdateController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 75,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        showCursor: false,
                        readOnly: true,
                        autocorrect: true,
                        controller: leaveApplyController.enddateController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'End Date',
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.transparent,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        onTap: () async {
                          endData = await pickDate();

                          if (endData != null) {
                            print(
                                endData); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(endData!);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16

                            setState(() {
                              leaveApplyController.enddateController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      )),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //         color: Colors.black,
                  //         width: 3,
                  //       ),
                  //     ),
                  //     child: Center(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: TextField(
                  //             showCursor: true,
                  //             readOnly: true,
                  //             controller: leaveApplyController.enddateController,
                  //             decoration: new InputDecoration.collapsed(
                  //                 hintText: 'End Date'
                  //             ),
                  //             onTap: () async {
                  //               DateTime? pickedDate = await showDatePicker(
                  //                   context: context,
                  //                   initialDate: DateTime.now(),
                  //                   firstDate: DateTime(1950),
                  //                   //DateTime.now() - not to allow to choose before today.
                  //                   lastDate: DateTime(2100));
                  //
                  //               if (pickedDate != null) {
                  //                 print(
                  //                     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  //                 String formattedDate =
                  //                 DateFormat('yyyy-MM-dd')
                  //                     .format(pickedDate);
                  //                 print(
                  //                     formattedDate); //formatted date output using intl package =>  2021-03-16
                  //                 setState(() {
                  //                   leaveApplyController.enddateController.text =
                  //                       formattedDate; //set output date to TextField value.
                  //                 });
                  //               } else {}
                  //             },
                  //
                  //           ),
                  //         ),
                  //     ),
                  //   ),
                  // ),

                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: TextField(
                            controller: leaveApplyController.reasonController,
                            keyboardType: TextInputType.multiline,
                            minLines:
                                1, // Normal textInputField will be displayed
                            maxLines:
                                10, // When user presses enter it will adapt to it
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0)),
                              hintText: 'Reason',
                              hintStyle: TextStyle(color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10,
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

  void validation(BuildContext context) async {
    if (leaveApplyController.chosenValue==null) {
      showSnackBar(context, "Select type of leave");
    } else if (leaveApplyController.startdateController.text.isEmpty) {
      showSnackBar(context, "Start Date is Required");
    } else if (leaveApplyController.enddateController.text.isEmpty) {
      showSnackBar(context, "End Date is Required");
    } else if (leaveApplyController.reasonController.text.isEmpty) {
      showSnackBar(context, "Reason is Required");
    } else if (leaveApplyController.enddateController.text.isNotEmpty) {
      if (endData!.isBefore(startDate!)) {
        showSnackBar(context, "End date must be after Start Date");
      } else {
        bool isOnline = await hasNetwork();
        if (isOnline) {
          print("clicked");
          leaveApplyController.takeleaveApi(token!, context);

          // controller.loader.value = true;
        } else {
          leaveApplyController.validationSnackbar(
              "Error", "Internet not available");
        }
      }
    } else {
      // nextScreen(context,  DashboardScreen());
      bool isOnline = await hasNetwork();
      if (isOnline) {
        print("clicked");
        leaveApplyController.takeleaveApi(token!, context);

        // controller.loader.value = true;
      } else {
        leaveApplyController.validationSnackbar(
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
                      builder: (BuildContext context) => LeaveListScreen()));
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
