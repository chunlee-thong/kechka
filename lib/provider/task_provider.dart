import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:kechka/constant/app_constant.dart';
import 'package:kechka/model/exception.dart';
import 'package:kechka/model/task_model.dart';
import 'package:provider/provider.dart';

class TaskProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => this._selectedDate;

  static TaskProvider getProvider(BuildContext context) =>
      Provider.of<TaskProvider>(context, listen: false);

  List<TaskModel> _taskBydate = [];
  List<TaskModel> _allTask;
  List<TaskModel> get tasksByDate => _taskBydate;

  Box<TaskModel> taskBox;

  TaskProvider() {
    taskBox = Hive.box<TaskModel>(AppConstant.TASK_BOX_NAME);
    _allTask = taskBox.values.toList();
    getTaskByDate();
  }

  Future<void> getTaskByDate() async {
    if (taskBox.isNotEmpty) {
      _taskBydate = taskBox.values
          .where((task) => task.dateTime.isTheSameDay(selectedDate))
          .toList();
    }
    notifyListeners();
  }

  Future<void> onAddTask(TaskModel newTask,
      {bool isEdit = false, TaskModel oldTask}) async {
    print(newTask.dateTime);
    if (isEdit) {
      //Remove old task from ourlist
      _allTask.removeWhere((task) => task.key == oldTask.key);
    }

    if (newTask.startTime.hour < 8 ||
        newTask.endTime.hour > 23 ||
        newTask.startTime.hour > newTask.endTime.hour) {
      throw AddTaskException("Invalid hour");
    }

    List<TaskModel> todayTask = _allTask
        .where((element) => element.dateTime.isTheSameDay(newTask.dateTime))
        .toList();

    print(todayTask.length);

    for (var task in todayTask) {
      if (task.startTime.hour == newTask.startTime.hour) {
        throw AddTaskException("Already has a task at this start time");
      }

      bool startTimeIsBetween = newTask.startTime.hour > task.startTime.hour &&
          newTask.startTime.hour < task.endTime.hour;
      bool endTimeIsBetween = newTask.endTime.hour < task.endTime.hour &&
          newTask.endTime.hour > task.startTime.hour;

      bool isOverlap = newTask.startTime.hour < task.startTime.hour &&
          newTask.endTime.hour > task.endTime.hour;

      if (startTimeIsBetween || endTimeIsBetween || isOverlap) {
        throw AddTaskException("Already has a task at this start time");
      }
    }

    if (isEdit) {
      taskBox.put(oldTask.key, newTask);
    } else {
      await taskBox.add(newTask);
    }

    _allTask.add(newTask);
    notifyListeners();
  }

  void deleteTask(TaskModel task) {
    _allTask.removeWhere((element) => task.key == element.key);
    taskBox.delete(task.key);
  }

  void onSelectDate(DateTime dateTime) async {
    if (dateTime.isTheSameDay(_selectedDate)) return;
    this._selectedDate = dateTime;
    await getTaskByDate();
  }
}
