import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:kechka/constant/style.dart';
import 'package:kechka/model/task_model.dart';
import 'package:kechka/pages/add_new_task_page.dart';
import 'package:kechka/provider/task_provider.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({Key key, this.task}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: task.totalHeight,
      margin: EdgeInsets.only(top: task.topPosition),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Dismissible(
        onDismissed: (dir) {
          TaskProvider.getProvider(context).deleteTask(task);
        },
        direction: DismissDirection.startToEnd,
        key: Key(task.key.toString()),
        child: Card(
          margin: EdgeInsets.zero,
          color: task.color ?? Color(0xFFFFEDE7),
          child: InkWell(
            onTap: () {
              PageNavigator.push(context, AddNewTaskPage(task: task));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${task.title}",
                    style: subtitleStyle.medium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (task.endTime != null && task.totalHour > 1) ...[
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
      ),
    );
  }
}
