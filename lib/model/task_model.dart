import 'package:flutter/material.dart';
import 'package:kechka/constant/app_constant.dart';

class TaskModel {
  final DateTime dateTime;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String title;
  final Color color;

  int get totalHour => endTime != null ? endTime.hour - startTime.hour : 1;

  double get totalHeight => totalHour * AppConstant.CARD_HEIGHT;

  double get topPosition => getIndexByStartTime(startTime.hour) * AppConstant.CARD_HEIGHT;

  TaskModel({this.startTime, this.endTime, this.title, this.color, this.dateTime});

  int getIndexByStartTime(int hour) => hour - 8;
}

final List<TaskModel> tasks = [
  TaskModel(
    startTime: TimeOfDay(hour: 9, minute: 0),
    endTime: TimeOfDay(hour: 12, minute: 0),
    title: "Meeting with PR department",
    color: Color(0xFFEFE0FF),
  ),
  TaskModel(
    startTime: TimeOfDay(hour: 13, minute: 0),
    endTime: TimeOfDay(hour: 14, minute: 0),
    title: "Presentation for client",
    color: Color(0xFFD3F8FF),
  ),
  TaskModel(
    startTime: TimeOfDay(hour: 16, minute: 0),
    title: "Planning for next month",
  ),
];
