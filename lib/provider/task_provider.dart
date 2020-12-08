import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => this._selectedDate;

  static TaskProvider getProvider(BuildContext context) => Provider.of<TaskProvider>(context, listen: false);

  void onSelectDate(DateTime dateTime) {
    this._selectedDate = dateTime;
    notifyListeners();
  }
}
