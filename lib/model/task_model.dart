import 'package:flutter/material.dart';
import 'package:kechka/constant/app_constant.dart';

class TaskModel {
  final DateTime dateTime;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String title;
  final Color color;

  int get totalHour =>
      endTime.hour != startTime.hour ? endTime.hour - startTime.hour : 1;

  double get totalHeight => totalHour * AppConstant.CARD_HEIGHT;

  double get topPosition =>
      getIndexByStartTime(startTime.hour) * AppConstant.CARD_HEIGHT;

  TaskModel(
      {this.startTime, this.endTime, this.title, this.color, this.dateTime});

  int getIndexByStartTime(int hour) => hour - 8;
}
