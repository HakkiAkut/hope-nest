import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/views/components/advert_info_container/info_texts.dart';

class AdvertInfoContainer extends StatelessWidget {
  final Advert advert;

  const AdvertInfoContainer({Key? key, required this.advert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoTexts(title: "Kind", info: advert.kind!),
            InfoTexts(title: "Race", info: advert.race!),
            InfoTexts(title: "Age", info: "${advert.age}")
          ],
        ),
        SizedBox(
          height: DynamicSize.height(context, 0.04),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoTexts(title: "Weight", info: "${advert.weight}"),
            InfoTexts(title: "Vaccines", info: isDone(advert.vaccines!)),
            InfoTexts(title: "Training", info: isDone(advert.training!))
          ],
        )
      ],
    );
  }

  String isDone(bool value) => value ? "done" : "not done";
}
