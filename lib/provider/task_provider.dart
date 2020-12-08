import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:kechka/model/task_model.dart';
import 'package:provider/provider.dart';

class TaskProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => this._selectedDate;

  static TaskProvider getProvider(BuildContext context) =>
      Provider.of<TaskProvider>(context, listen: false);

  List<TaskModel> tasks = [];

  TaskProvider() {
    tasks.addAll([
      TaskModel(
        dateTime: DateTime.now(),
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 12, minute: 0),
        title: "Meeting with PR department",
        color: Color(0xFFEFE0FF),
      ),
      TaskModel(
        dateTime: DateTime.now(),
        startTime: TimeOfDay(hour: 13, minute: 0),
        endTime: TimeOfDay(hour: 14, minute: 0),
        title: "Presentation for client",
        color: Color(0xFFD3F8FF),
      ),
      TaskModel(
        dateTime: DateTime.now(),
        startTime: TimeOfDay(hour: 17, minute: 0),
        endTime: TimeOfDay(hour: 17, minute: 0),
        title: "Planning for next month",
      ),
    ]);
  }

  void onAddTask(TaskModel newTask) {
    if (newTask.startTime.hour < 8 ||
        newTask.endTime.hour > 23 ||
        newTask.startTime.hour > newTask.endTime.hour) {
      throw "Invalid hour";
    }

    List<TaskModel> todayTask = tasks
        .where((element) => element.dateTime.isTheSameDay(newTask.dateTime))
        .toList();
    print("Today task is :${todayTask.length}");

    for (var task in todayTask) {
      if (task.startTime.hour == newTask.startTime.hour) {
        throw "Already has a task at this start time";
      }

      bool startTimeIsBetween = newTask.startTime.hour > task.startTime.hour &&
          newTask.startTime.hour < task.endTime.hour;
      bool endTimeIsBetween = newTask.endTime.hour < task.endTime.hour &&
          newTask.endTime.hour > task.startTime.hour;

      bool isOverlap = newTask.startTime.hour < task.startTime.hour &&
          newTask.endTime.hour > task.endTime.hour;

      if (startTimeIsBetween || endTimeIsBetween || isOverlap) {
        throw "Already has a task at this start time";
      }
    }
    tasks.add(newTask);
    notifyListeners();
  }

  void onSelectDate(DateTime dateTime) {
    this._selectedDate = dateTime;
    notifyListeners();
  }
}
