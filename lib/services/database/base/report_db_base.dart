import 'package:hope_nest/models/report.dart';

abstract class ReportMethods {
  Future<bool?> setReport({required Report report});
  Stream<List<Report>>? getReports();
}
