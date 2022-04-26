import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String id;
  String uid;
  String reportType;
  String reportedId;
  String title;
  String description;
  Timestamp date;
  bool? isDone;

  Report(
      {required this.id,
      required this.uid,
      required this.title,
      required this.description,
      required this.reportType,
      required this.reportedId,
      required this.date,
      this.isDone});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": uid,
      "reportedId": reportedId,
      "reportType": reportType,
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone ?? false,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] as String,
      uid: map['userId'] as String,
      reportedId: map['reportedId'] as String,
      reportType: map['reportType'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      date: map['date'] as Timestamp,
      isDone: map['isDone'] as bool,
    );
  }
}
