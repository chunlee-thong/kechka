import 'package:flutter/material.dart';
import 'package:kechka/constant/app_constant.dart';
import 'package:kechka/constant/style.dart';

class HourRow extends StatelessWidget {
  final TimeOfDay time;

  const HourRow({Key key, this.time}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstant.CARD_HEIGHT,
      alignment: Alignment.center,
      child: Text(
        "${time.format(context)}",
        style: subtitleStyle.apply(color: Colors.black54),
      ),
    );
  }
}
