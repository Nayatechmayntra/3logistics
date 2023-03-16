import 'dart:io';

import 'package:erp_project/screen/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/leaveapply_controller.dart';
import '../controller/logout_controller.dart';
import '../modal/leavelist_model.dart';
import 'forgotpass_screen.dart';
import 'leaveapply_screen.dart';
import 'login_screen.dart';

class LeaveListScreen extends StatefulWidget {
  const LeaveListScreen({Key? key}) : super(key: key);

  @override
  State<LeaveListScreen> createState() => _LeaveListScreenState();
}

class _LeaveListScreenState extends State<LeaveListScreen> {
  String? username;
  LeaveApplyController leaveApplyController = LeaveApplyController();
  LogoutController logoutController = LogoutController();

  String? token;
  var formatter = new DateFormat('yyyy-MM-dd');
  List<Datum> dataleavelist = [];
  final DataTableSource _data = MyData();

  @override
  void initState() {
    checktoken();

    super.initState();
  }

  checktoken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("login");
    leaveApplyController.leavelistApi(token!);
    SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("username");
    print("datasize:::${leaveApplyController.LeaveDataList}");

    // forgotpassController.changePasswordApi(context,preferences.getString("login")!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: SafeArea(
          child: Scaffold(
            drawerEnableOpenDragGesture: false,
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
                            Image.asset('assets/leaveicon1.png',height: 30,width: 30,),
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
                            Image.asset('assets/changepassword.png',height: 30,width: 30,),
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
                            Image.asset('assets/logouticon1.png',height: 30,width: 30,),
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
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/bgimg.jpg",
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(child: Text("Leave List",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.white),)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Obx(
                            () => leaveApplyController.LeaveDataList.length > 0
                            ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.white, width: 2.0)),
                          child: SingleChildScrollView(
                            child:
                            DataTable(
                                headingRowColor: MaterialStateProperty.all(
                                    Colors.deepPurple[200]),
                                columnSpacing: 100,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                columns: [
                                  DataColumn(label: Text('Start Date',style: TextStyle(color:Colors.white),)),
                                  DataColumn(label: Text('End Date',style: TextStyle(color:Colors.white))),
                                  DataColumn(label: Text('Leave Type',style: TextStyle(color:Colors.white))),
                                  DataColumn(label: Text('Day Type',style: TextStyle(color:Colors.white))),
                                  DataColumn(
                                      label: Text('                      Reason',style: TextStyle(color:Colors.white))),
                                  DataColumn(label: Text('Status',style: TextStyle(color:Colors.white))),
                                ],
                                rows: [
                                  ...leaveApplyController.LeaveDataList.map(
                                          (team) => DataRow(
                                        cells: [
                                          DataCell(Container(
                                              alignment:
                                              AlignmentDirectional.center,
                                              child: Text(
                                                formatter
                                                    .format(team.startDate),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.normal),
                                              ))),
                                          DataCell(Container(

                                              alignment:
                                              AlignmentDirectional.center,
                                              child: Text(
                                                formatter.format(team.endDate),
                                                  style: TextStyle(color:Colors.white)
                                              ))),
                                          DataCell(Container(
                                              alignment:
                                              AlignmentDirectional.center,
                                              child: Text(team.leaveType,style: TextStyle(color:Colors.white)))),
                                          DataCell(Container(
                                              alignment:
                                              AlignmentDirectional.center,
                                              child: Text(team.dayType,style: TextStyle(color:Colors.white)))),
                                          DataCell(Container(
                                            width: 200.0,
                                              alignment:
                                              AlignmentDirectional.center,
                                              child: Text(team.reason,style: TextStyle(color:Colors.white)))),
                                          DataCell(Container(
                                              alignment:
                                              AlignmentDirectional.center,
                                              child: Text(
                                                  team.status.toString(),style: TextStyle(color:Colors.white)))),
                                        ],
                                      ))
                                ]),
                          ),
                        )
                            : leaveApplyController.loader.value
                            ? Center(
                            child: Container(
                                height: 250.0,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: Center(
                                  child: CupertinoActivityIndicator(
                                    radius: 25,
                                  ),
                                )))
                            : Center(
                            child: Container(
                                height: 100.0,
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text('                No Data Found',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => LeaveApplicationScreen()));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          backgroundColor: Color(0xff41069d), //<-- SEE HERE
        ),
      )),
    );
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
                      builder: (BuildContext context) => DashboardScreen()));                },
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

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}

class MyData extends DataTableSource{

  LeaveApplyController leaveApplyController = LeaveApplyController();


  



  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => leaveApplyController.LeaveDataList.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(leaveApplyController.LeaveDataList[index]['id'].toString())),
      DataCell(Text(leaveApplyController.LeaveDataList[index]["start_date"])),
      DataCell(Text(leaveApplyController.LeaveDataList[index]["end_date"].toString())),
      DataCell(Text(leaveApplyController.LeaveDataList[index]["leave_type"].toString())),
      DataCell(Text(leaveApplyController.LeaveDataList[index]["day_type"].toString())),
      DataCell(Text(leaveApplyController.LeaveDataList[index]["reason"].toString())),
      DataCell(Text(leaveApplyController.LeaveDataList[index]["status"].toString())),
    ]);
  }
}
