import 'package:flutter/material.dart';
import 'package:hope_nest/models/report.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/enum/report_type.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/view_models/report_vm.dart';
import 'package:hope_nest/views/components/app_bar/app_bar.dart';
import 'package:hope_nest/views/components/appbar_action_widget/appbar_action_widget.dart';
import 'package:hope_nest/views/components/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:hope_nest/views/components/styles/background_style.dart';
import 'package:hope_nest/views/components/styles/input_style.dart';
import 'package:hope_nest/views/components/styles/text_style.dart';
import 'package:hope_nest/views/components/toast_message/toast_message.dart';
import 'package:provider/provider.dart';

class ReportAdminPage extends StatefulWidget {
  final Report report;

  const ReportAdminPage({
    Key? key,
    required this.report,
  }) : super(key: key);

  @override
  _ReportAdminPageState createState() => _ReportAdminPageState();
}

class _ReportAdminPageState extends State<ReportAdminPage> {
  late ReportType reportType;

  var key1 = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    reportType = widget.report.reportUser != null
        ? ReportType.USER
        : (widget.report.reportAdvert != null
            ? ReportType.ADVERT
            : ReportType.POST);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    final _reportVM = Provider.of<ReportVM>(context);
    return Container(
      decoration: backgroundStyle,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          actionWidget: widget.report.isDone != true
              ? AppBarActionWidget(
                  onPressed: () async {
                    if (key1.currentState!.validate()) {
                      key1.currentState!.save();
                      print("validated");
                      try {
                        widget.report.isDone = true;
                        bool? x = await _reportVM.setReport(
                            report: widget.report, isSuspended: false);
                        if (x != null && x) {
                          print("discarded");
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
                  text: "discard")
              : Container(),
          text: "Cancel",
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: widget.report.isDone != true
            ? CustomFloatingActionButton(
                text: "Suspend",
                onPressed: () async {
                  print("pressed");
                  if (key1.currentState!.validate()) {
                    key1.currentState!.save();
                    print("validated");
                    try {
                      widget.report.isDone = true;
                      bool? x = await _reportVM.setReport(
                          report: widget.report, isSuspended: true);
                      if (x != null && x) {
                        getDoneMessage( text: "successful");
                        Navigator.pop(context);
                      } else {
                        getErrorMessage(text: "an error occurred");
                      }
                    } catch (e) {
                      debugPrint("hatalı");
                      debugPrint(e.toString());
                    }
                  } else {
                    print("hata var");
                  }
                },
              )
            : Container(),
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
                          ? "${widget.report.reportUser!.name}"
                          : (reportType == ReportType.ADVERT
                              ? "${widget.report.reportAdvert!.name}"
                              : "${widget.report.reportPost!.title}"),
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
                          ? widget.report.reportUser!.uid
                          : (reportType == ReportType.ADVERT
                              ? widget.report.reportAdvert!.id
                              : widget.report.reportPost!.id),
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "description: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      widget.report.description,
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                widget.report.isDone != true
                    ? Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: DynamicSize.height(context, 0.02)),
                        child: TextFormField(
                          maxLines: 1,
                          key: key1,
                          onChanged: (String s) => widget.report.conclusion = s,
                          style: normalTextStyle,
                          validator: (_value) {
                            if (_value == null || _value.length < 1) {
                              return "conclusion can not be null!";
                            } else {
                              return null;
                            }
                          },
                          decoration: inputStyle.copyWith(
                            hintText: 'Conclusion',
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          const Text(
                            "Is Done: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            widget.report.isDone.toString(),
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                widget.report.isDone == true
                    ? Row(
                        children: [
                          const Text(
                            "conclusion: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            widget.report.conclusion,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
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
