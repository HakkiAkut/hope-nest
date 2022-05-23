import 'package:flutter/material.dart';
import 'package:hope_nest/models/report.dart';
import 'package:hope_nest/models/search.dart';
import 'package:hope_nest/repository/repository.dart';
import 'package:hope_nest/services/database/base/report_db_base.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/init/service_locator.dart';

class ReportVM with ChangeNotifier implements ReportMethods {
  AppState _state = AppState.IDLE;
  final Repository _repository = serviceLocator<Repository>();
  SearchReport _searchReport = SearchReport();

  SearchReport get searchReport => _searchReport;

  AppState get state => _state;

  set searchReport(SearchReport searchReport) {
    _searchReport = searchReport;
    notifyListeners();
  }

  set state(AppState value) {
    _state = value;
    notifyListeners();
  }

  bool isSearchReportNull() {
    return (_searchReport.isDone == null) ? true : false;
  }

  @override
  Future<bool?> setReport(
      {required Report report, required bool isSuspended}) async {
    try {
      state = AppState.BUSY;
      return await _repository.setReport(
          report: report, isSuspended: isSuspended);
    } finally {
      state = AppState.IDLE;
    }
  }

  @override
  Stream<List<Report>>? getReports() {
    return isSearchReportNull()
        ? _repository.getReports()
        : _repository.getFilteredReports(searchReport: _searchReport);
  }
}
