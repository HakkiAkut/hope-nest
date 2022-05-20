import 'package:flutter/material.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/models/report.dart';
import 'package:hope_nest/view_models/blog_vm.dart';
import 'package:hope_nest/view_models/report_vm.dart';
import 'package:hope_nest/views/home_page/blog/blog_view.dart';
import 'package:hope_nest/views/home_page/report_list_page/report_list_view.dart';
import 'package:provider/provider.dart';

class ReportListProvider extends StatelessWidget {
  const ReportListProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _reportVM = Provider.of<ReportVM>(context);
    return StreamProvider<List<Report>>.value(
      value: _reportVM.getReports(),
      initialData: const [],
      child: const ReportListView(),
      updateShouldNotify: (prev, now) => true,
    );

  }
}