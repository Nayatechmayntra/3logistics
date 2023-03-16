// To parse this JSON data, do
//
//     final stopNavigation = stopNavigationFromJson(jsonString);

import 'dart:convert';

StopNavigation stopNavigationFromJson(String str) => StopNavigation.fromJson(json.decode(str));

String stopNavigationToJson(StopNavigation data) => json.encode(data.toJson());

class StopNavigation {
  StopNavigation({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory StopNavigation.fromJson(Map<String, dynamic> json) => StopNavigation(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
     this.id,
     this.empId,
     this.startDate,
     this.endDate,
     this.date,
  });

  int? id;
  int? empId;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? date;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    empId: json["emp_id"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_id": empId,
    "start_date": startDate!.toIso8601String(),
    "end_date": endDate!.toIso8601String(),
    "date": date!.toIso8601String(),
  };
}
