// To parse this JSON data, do
//
//     final startNavigation = startNavigationFromJson(jsonString);

import 'dart:convert';

StartNavigation startNavigationFromJson(String str) => StartNavigation.fromJson(json.decode(str));

String startNavigationToJson(StartNavigation data) => json.encode(data.toJson());

class StartNavigation {
  StartNavigation({
     this.status,
     this.message,
     this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory StartNavigation.fromJson(Map<String, dynamic> json) => StartNavigation(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    required this.empId,
    required this.startDate,
    required this.endDate,
    required this.date,
    required this.id,
  });

  int empId;
  DateTime startDate;
  DateTime endDate;
  DateTime date;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    empId: json["emp_id"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    date: DateTime.parse(json["date"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "emp_id": empId,
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "date": date.toIso8601String(),
    "id": id,
  };
}
