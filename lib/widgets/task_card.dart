import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:kechka/constant/style.dart';
import 'package:kechka/model/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({Key key, this.task}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: task.topPosition),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: 0),
          Container(
            height: task.totalHeight,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Card(
              margin: EdgeInsets.zero,
              color: task.color ?? Color(0xFFFFEDE7),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(task.title, style: subtitleStyle.medium),
                    if (task.endTime != null && task.totalHour != 1) ...[
                      Divider(),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.purple, size: 18),
                          SpaceX(),
                          Text(task.startTime.format(context)),
                          Text(" - "),
                          Text(task.endTime.format(context)),
                        ],
                      )
                    ]
                  ],
                ),
              ),
            ),
          ),
          Divider(height: 0),
        ],
      ),
    );
  }
}
