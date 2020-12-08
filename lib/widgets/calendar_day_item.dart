import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:kechka/constant/color.dart';
import 'package:kechka/constant/style.dart';
import 'package:kechka/provider/task_provider.dart';
import 'package:kechka/utils/app_utils.dart';

class CalendarDayItem extends StatelessWidget {
  final DateTime dateTime;
  final bool isSelected;
  const CalendarDayItem({Key key, this.dateTime, this.isSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: isSelected ? primaryColor : Color(0xFFF6F6F6),
          shape: JinWidget.roundRect(12),
          child: InkWell(
            onTap: () {
              TaskProvider.getProvider(context).onSelectDate(dateTime);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "${dateTime.day}",
                    style: titleStyle.applyColor(isSelected ? Colors.white : Colors.black),
                  ),
                  Text(
                    "${AppUtils.getWeekDayString(dateTime.weekday)}",
                    style: subtitleStyle.applyColor(isSelected ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isSelected)
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
          )
      ],
    );
  }
}
