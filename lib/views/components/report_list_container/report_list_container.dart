import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/models/chatroom.dart';
import 'package:hope_nest/models/report.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/enum/report_type.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/view_models/advert_vm.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/view_models/blog_vm.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportListContainer extends StatelessWidget {
  final Report report;

  const ReportListContainer({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          margin: EdgeInsets.only(bottom: DynamicSize.height(context, 0.036)),
          height: DynamicSize.height(context, 0.097),
          decoration: BoxDecoration(
            color: report.isDone == true ? Palette.DONE : Palette.BACKGROUND,
            border: Border.all(width: 1, color: Colors.orangeAccent),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(width: 1, color: Colors.orangeAccent),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${report.title}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(report.date.toDate()),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        onTap: () async {
          if (report.reportType == ReportType.USER) {
            final _appUserVM = Provider.of<AppUserVM>(context, listen: false);
            report.reportUser =
                await _appUserVM.getUserByID(id: report.reportedId);
          } else if (report.reportType == ReportType.ADVERT) {
            final _advertVM = Provider.of<AdvertVM>(context, listen: false);
            report.reportAdvert =
                await _advertVM.getAdvertByID(id: report.reportedId);
          } else {
            final _postsVM = Provider.of<BlogVM>(context, listen: false);
            report.reportPost =
                await _postsVM.getPostByID(id: report.reportedId);
          }
          Navigator.pushNamed(context, NavigationConstants.REPORT_ADMIN,
              arguments: report);
        });
  }
}
