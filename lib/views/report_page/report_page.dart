import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/models/report.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/enum/report_type.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/view_models/report_vm.dart';
import 'package:hope_nest/views/components/app_bar/app_bar.dart';
import 'package:hope_nest/views/components/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:hope_nest/views/components/styles/background_style.dart';
import 'package:hope_nest/views/components/styles/input_style.dart';
import 'package:hope_nest/views/components/styles/text_style.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  final AppUser? reportUser;
  final Advert? reportAdvert;
  final Post? reportPost;

  const ReportPage({
    Key? key,
    this.reportAdvert,
    this.reportUser,
    this.reportPost,
  }) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late ReportType reportType;
  late Report _report;

  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    reportType = widget.reportUser != null
        ? ReportType.USER
        : (widget.reportAdvert != null ? ReportType.ADVERT : ReportType.POST);
    _report = Report(
        conclusion: "",
        reportType: reportType,
        reportedId: reportType == ReportType.USER
            ? widget.reportUser!.uid
            : (reportType == ReportType.ADVERT
                ? widget.reportAdvert!.id
                : widget.reportPost!.id),
        uid: "",
        id: "",
        date: Timestamp.now(),
        title: "",
        description: "");
  }

  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    final _reportVM = Provider.of<ReportVM>(context);
    return Container(
      decoration: backgroundStyle,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          text: "Cancel",
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomFloatingActionButton(
          text: "Report",
          onPressed: () async {
            _report.id = Timestamp.now().millisecondsSinceEpoch.toString() +
                _appUserVM.appUser!.uid;
            _report.uid = _appUserVM.appUser!.uid;
            print("pressed");
            if (key1.currentState!.validate() &&
                key2.currentState!.validate()) {
              key1.currentState!.save();
              key2.currentState!.save();
              print("validated");
              try {
                bool? x = await _reportVM.setReport(report: _report,isSuspended: false);
                if (x != null && x) {
                  print("reported");
                  Navigator.pop(context);
                }
              } catch (e) {
                debugPrint("hatalı");
                debugPrint(e.toString());
              }
            } else {
              print("hata var");
            }
          },
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Report Page",
                  style: TextStyle(fontSize: 24, color: Palette.BOLD_COLOR),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  reportType == ReportType.USER
                      ? "User Information "
                      : (reportType == ReportType.ADVERT
                          ? "Advert Information"
                          : "Post Information"),
                  style:
                      const TextStyle(fontSize: 18, color: Palette.INPUT_BOX),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      reportType == ReportType.USER ? "name: " : "title: ",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      reportType == ReportType.USER
                          ? "${widget.reportUser!.name}"
                          : (reportType == ReportType.ADVERT
                              ? "${widget.reportAdvert!.name}"
                              : "${widget.reportPost!.title}"),
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "ID: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      reportType == ReportType.USER
                          ? widget.reportUser!.uid
                          : (reportType == ReportType.ADVERT
                              ? widget.reportAdvert!.id
                              : widget.reportPost!.id),
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Report Information ",
                  style: TextStyle(fontSize: 18, color: Palette.INPUT_BOX),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DynamicSize.height(context, 0.02)),
                  child: TextFormField(
                    maxLines: 1,
                    key: key1,
                    onChanged: (String s) => _report.title = s,
                    style: normalTextStyle,
                    validator: (_value) {
                      if (_value == null || _value.length < 1) {
                        return "title can not be null!";
                      } else {
                        return null;
                      }
                    },
                    decoration: inputStyle.copyWith(
                      hintText: 'Title',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DynamicSize.height(context, 0.02)),
                  child: TextFormField(
                    maxLines: 6,
                    key: key2,
                    onChanged: (String s) => _report.description = s,
                    style: normalTextStyle,
                    validator: (_value) {
                      if (_value == null || _value.length < 1) {
                        return "description can not be null!";
                      } else {
                        return null;
                      }
                    },
                    decoration: inputStyle.copyWith(
                      hintText: 'Description',
                    ),
                  ),
                ),
                _reportVM.state == AppState.BUSY
                    ? const CircularProgressIndicator()
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
