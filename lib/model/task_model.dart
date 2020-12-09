import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kechka/constant/app_constant.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(1)
  final DateTime dateTime;
  @HiveField(2)
  final TimeOfDay startTime;
  @HiveField(3)
  final TimeOfDay endTime;
  @HiveField(4)
  final String title;
  @HiveField(5)
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
