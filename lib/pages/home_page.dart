import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:kechka/constant/app_constant.dart';
import 'package:kechka/constant/color.dart';
import 'package:kechka/constant/style.dart';
import 'package:kechka/pages/add_new_task_page.dart';
import 'package:kechka/provider/task_provider.dart';
import 'package:kechka/widgets/calendar_day_item.dart';
import 'package:kechka/widgets/hour_row.dart';
import 'package:kechka/widgets/task_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TaskProvider taskProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTodayDate(),
            SpaceY(16),
            buildCalendarDayList(),
            SpaceY(16),
            buildHourAndTaskList(),
            buildAddTaskButton(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showTimePicker(context: context, initialTime: TimeOfDay(hour: 4, minute: 0));
      //   },
      //   child: Icon(Icons.access_time),
      // ),
    );
  }

  Widget buildHourAndTaskList() {
    return Expanded(
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: HOURS.map((time) => HourRow(time: time)).toList(),
                ),
                SpaceX(12),
                Expanded(
                  child: Stack(
                    children: [
                      generateDivider(),
                      ...taskProvider.tasksByDate
                          .map((task) => TaskCard(task: task))
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (taskProvider.tasksByDate.isEmpty)
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  borderRadius: JinWidget.radius(),
                  color: AppColor.blue,
                ),
                child: Text("No task today"),
              ),
            ),
        ],
      ),
    );
  }

  Widget generateDivider() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        16,
        (index) {
          return Container(
            margin: EdgeInsets.only(top: 64.0),
            child: Divider(height: 0),
          );
        },
      ),
    );
  }

  Widget buildAddTaskButton() {
    return ActionButton(
      onPressed: () {
        PageNavigator.push(context, AddNewTaskPage());
      },
      color: AppColor.primaryColor,
      textColor: Colors.white,
      icon: Icon(Icons.add),
      shape: JinWidget.roundRect(),
      child: Text("Add new task"),
    );
  }

  Widget buildTodayDate() {
    return SafeArea(
      bottom: false,
      child: Text(
        taskProvider.selectedDate.formatDate("MMMM dd"),
        style: headerStyle.bold,
      ),
    );
  }

  Widget buildCalendarDayList() {
    return Container(
      height: 100,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final DateTime dateTime = DateTime.now().add(Duration(days: index));
          return CalendarDayItem(
            dateTime: dateTime,
            isSelected: taskProvider.selectedDate.isTheSameDay(dateTime),
          );
        },
      ),
    );
  }
}
