// To parse this JSON data, do
//
//     final homelistmodel = homelistmodelFromJson(jsonString);

import 'dart:convert';

Homelistmodel homelistmodelFromJson(String str) =>
    Homelistmodel.fromJson(json.decode(str));

String homelistmodelToJson(Homelistmodel data) => json.encode(data.toJson());

class Homelistmodel {
  Homelistmodel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<HomeList>? data;

  factory Homelistmodel.fromJson(Map<String, dynamic>? json) => Homelistmodel(
        status: json!["status"],
        message: json["message"],
        data: List<HomeList>.from(json["data"].map((x) => HomeList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HomeList {
  HomeList({
    this.totalTime,
    this.totalTimeArray,
    this.breakTime,
    this.breakTimeArray,
    this.productiveTime,
    this.productiveTimeArr,
    this.attendanceData,
    this.breakData,
  });

  String? totalTime;
  BreakTimeArray? totalTimeArray;
  String? breakTime;
  BreakTimeArray? breakTimeArray;
  String? productiveTime;
  BreakTimeArray? productiveTimeArr;
  AttendanceData? attendanceData;
  dynamic breakData;

  factory HomeList.fromJson(Map<String, dynamic> json) => HomeList(
        totalTime: json["total_time"],
        totalTimeArray: BreakTimeArray.fromJson(json["total_time_array"]),
        breakTime: json["break_time"],
        breakTimeArray: BreakTimeArray.fromJson(json["break_time_array"]),
        productiveTime: json["productive_time"],
        productiveTimeArr: BreakTimeArray.fromJson(json["productive_time_arr"]),
        attendanceData: AttendanceData.fromJson(json["attendance_data"]),
        breakData: json["break_data"],
      );

  Map<String, dynamic> toJson() => {
        "total_time": totalTime,
        "total_time_array": totalTimeArray!.toJson(),
        "break_time": breakTime,
        "break_time_array": breakTimeArray!.toJson(),
        "productive_time": productiveTime,
        "productive_time_arr": productiveTimeArr!.toJson(),
        "attendance_data": attendanceData!.toJson(),
        "break_data": breakData,
      };
}

class AttendanceData {
  AttendanceData({
    this.id,
    this.empId,
    this.workIn,
    this.workOut,
    this.guest,
    this.purpose,
    this.contact,
    this.inLatitude,
    this.inLongitude,
    this.inAddress,
    this.outLatitude,
    this.outLongitude,
    this.outAddress,
  });

  int? id;
  int? empId;
  DateTime? workIn;
  DateTime? workOut;
  String? guest;
  String? purpose;
  String? contact;
  String? inLatitude;
  String? inLongitude;
  dynamic inAddress;
  String ?outLatitude;
  String? outLongitude;
  dynamic outAddress;

  factory AttendanceData.fromJson(Map<String, dynamic> json) => AttendanceData(
        id: json["id"],
        empId: json["emp_id"],
        workIn: DateTime.parse(json["work_in"]),
        workOut: DateTime.parse(json["work_out"]),
        guest: json["guest"],
        purpose: json["purpose"],
        contact: json["contact"],
        inLatitude: json["in_latitude"],
        inLongitude: json["in_longitude"],
        inAddress: json["in_address"],
        outLatitude: json["out_latitude"],
        outLongitude: json["out_longitude"],
        outAddress: json["out_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emp_id": empId,
        "work_in": workIn!.toIso8601String(),
        "work_out": workOut!.toIso8601String(),
        "guest": guest,
        "purpose": purpose,
        "contact": contact,
        "in_latitude": inLatitude,
        "in_longitude": inLongitude,
        "in_address": inAddress,
        "out_latitude": outLatitude,
        "out_longitude": outLongitude,
        "out_address": outAddress,
      };
}

class BreakTimeArray {
  BreakTimeArray({
     this.h,
     this.i,
     this.s,
  });

  dynamic? h;
  dynamic? i;
  dynamic? s;

  factory BreakTimeArray.fromJson(Map<String, dynamic> json) => BreakTimeArray(
        h: json["h"],
        i: json["i"],
        s: json["s"],
      );

  Map<String, dynamic> toJson() => {
        "h": h,
        "i": i,
        "s": s,
      };
}
