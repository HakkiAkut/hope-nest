import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/util/enum/report_type.dart';

class Report {
  String id;
  String uid;
  ReportType reportType;
  String reportedId;
  String title;
  String description;
  String conclusion;
  Timestamp date;
  bool? isDone;
  AppUser? reportUser;
  Advert? reportAdvert;
  Post? reportPost;

  Report(
      {required this.id,
      required this.uid,
      required this.title,
      required this.description,
      required this.conclusion,
      required this.reportType,
      required this.reportedId,
      required this.date,
      this.isDone});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": uid,
      "reportedId": reportedId,
      "reportType": reportType == ReportType.USER
          ? "user"
          : (reportType == ReportType.ADVERT ? "advert" : "post"),
      "title": title,
      "description": description,
      "conclusion": conclusion,
      "date": date,
      "isDone": isDone ?? false,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] as String,
      uid: map['userId'] as String,
      reportedId: map['reportedId'] as String,
      reportType: (map['reportType'] as String) == "user"
          ? ReportType.USER
          : ((map['reportType'] as String) == "advert"
              ? ReportType.ADVERT
              : ReportType.POST),
      title: map['title'] as String,
      description: map['description'] as String,
      conclusion: map['conclusion'] as String,
      date: map['date'] as Timestamp,
      isDone: map['isDone'] as bool,
    );
  }
}
