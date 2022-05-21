import 'package:flutter/material.dart';
import 'package:hope_nest/models/report.dart';
import 'package:hope_nest/repository/repository.dart';
import 'package:hope_nest/services/database/base/report_db_base.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/init/service_locator.dart';

class ReportVM with ChangeNotifier implements ReportMethods {
  AppState _state = AppState.IDLE;
  final Repository _repository = serviceLocator<Repository>();

  AppState get state => _state;

  set state(AppState value) {
    _state = value;
    notifyListeners();
  }

  @override
  Future<bool?> setReport({required Report report,required bool isSuspended}) async {
    try {
      state = AppState.BUSY;
      return _repository.setReport(report: report,isSuspended:isSuspended);
    } finally {
      state = AppState.IDLE;
    }
  }

  @override
  Stream<List<Report>>? getReports() {
    return _repository.getReports();
  }
}
