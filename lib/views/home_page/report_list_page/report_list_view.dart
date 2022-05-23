import 'package:flutter/material.dart';
import 'package:hope_nest/models/report.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/report_list_container/report_list_container.dart';
import 'package:provider/provider.dart';

class ReportListView extends StatefulWidget {
  const ReportListView({Key? key}) : super(key: key);

  @override
  _ReportListViewState createState() => _ReportListViewState();
}

class _ReportListViewState extends State<ReportListView> {
  @override
  Widget build(BuildContext context) {
    final _reportVM = Provider.of<List<Report>>(context);
    final _appUserVM = Provider.of<AppUserVM>(context);
    _appUserVM.currentIndex=2;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: _reportVM.length,
          itemBuilder: (BuildContext context, int index) {
            return ReportListContainer(report: _reportVM[index]);
          }),
    );
  }
}
