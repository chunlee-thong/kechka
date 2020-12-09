import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:kechka/constant/color.dart';
import 'package:kechka/constant/style.dart';
import 'package:kechka/model/exception.dart';
import 'package:kechka/model/task_model.dart';
import 'package:kechka/provider/task_provider.dart';
import 'package:kechka/widgets/simple_text_field.dart';
import 'package:kechka/widgets/ui_helper.dart';

class AddNewTaskPage extends StatefulWidget {
  final TaskModel task;
  AddNewTaskPage({Key key, this.task}) : super(key: key);

  @override
  _AddNewTaskPageState createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage>
    with FormPageMixin, AfterBuildMixin {
  TextEditingController titleTC;
  TextEditingController dateTC;
  TextEditingController startTimeTC;
  TextEditingController endTimeTC;

  //
  DateTime selectedDate;
  TimeOfDay startTime;
  TimeOfDay endTime;

  bool get editMode => widget.task != null;

  Future<void> onSelectDate() async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      this.selectedDate = pickedDate;
      String dateTime = pickedDate.formatDate("EEEE,dd MMMM");
      dateTC.text = dateTime;
    }
  }

  Future<void> onSelectTime([bool isStartTime = true]) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 0),
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (selectedTime != null) {
      String time = selectedTime.format(context);
      if (isStartTime) {
        startTime = selectedTime;
        startTimeTC.text = time;
      } else {
        endTime = selectedTime;
        endTimeTC.text = time;
      }
    }
  }

  void onAddTask() async {
    if (isFormValidated) {
      try {
        TaskModel task = TaskModel(
          title: titleTC.text.trim(),
          dateTime: selectedDate,
          startTime: startTime,
          endTime: endTime ?? startTime,
        );
        await TaskProvider.getProvider(context)
            .onAddTask(task, isEdit: editMode, oldTask: widget.task);
        TaskProvider.getProvider(context).getTaskByDate();
        Navigator.of(context).pop();
      } on AddTaskException catch (e) {
        UIHelper.showErrorDialog(context, e.toString());
      }
    }
  }

  void onInit() {
    if (widget.task != null) {
      startTime = widget.task.startTime;
      endTime = widget.task.endTime;
    }
    titleTC = TextEditingController(text: widget.task?.title);
    startTimeTC = TextEditingController();
    endTimeTC = TextEditingController();
    dateTC = TextEditingController();
    selectedDate =
        widget.task?.dateTime ?? TaskProvider.getProvider(context).selectedDate;
    String dateTime = selectedDate.formatDate("EEEE,dd MMMM");
    dateTC.text = dateTime;
  }

  @override
  void afterBuild(BuildContext context) {
    startTimeTC.text = startTime?.format(context);
    endTimeTC.text = endTime?.format(context);
  }

  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  void dispose() {
    titleTC.dispose();
    dateTC.dispose();
    startTimeTC.dispose();
    endTimeTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(editMode ? "Edit task" : "Add new task"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SimpleTextField(
              controller: titleTC,
              hint: "title",
              suffix: Icon(Icons.edit, color: Colors.grey),
              prefix: Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.purple.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SpaceY(16),
            SimpleTextField(
              controller: dateTC,
              suffix: Icon(Icons.edit, color: Colors.grey),
              readOnly: true,
              onTap: onSelectDate,
              prefix: SmallIconButton(
                onTap: null,
                backgroundColor: AppColor.red.withOpacity(0.2),
                margin: EdgeInsets.all(8),
                icon: Icon(
                  Icons.calendar_today,
                  color: AppColor.red,
                  size: 18,
                ),
              ),
            ),
            SpaceY(16),
            buildTimeSelector(),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget buildSaveButton() {
    return ActionButton(
      onPressed: onAddTask,
      child: Text(editMode ? "Update" : "Save"),
      color: AppColor.primaryColor,
      textColor: Colors.white,
      shape: JinWidget.roundRect(),
    );
  }

  Widget buildTimeSelector() {
    return Row(
      children: [
        SimpleTextField(
          controller: startTimeTC,
          hint: "Start time",
          readOnly: true,
          onTap: () => onSelectTime(true),
          prefix: SmallIconButton(
            onTap: null,
            backgroundColor: AppColor.primaryColor.withOpacity(0.2),
            margin: EdgeInsets.all(8),
            icon: Icon(
              Icons.access_time,
              color: AppColor.primaryColor,
              size: 18,
            ),
          ),
        ).expanded,
        Text("-", style: subHeaderStyle).marginValue(horizontal: 12),
        SimpleTextField(
          controller: endTimeTC,
          doValidation: false,
          hint: "End time",
          readOnly: true,
          onTap: () => onSelectTime(false),
          prefix: SmallIconButton(
            onTap: null,
            backgroundColor: AppColor.primaryColor.withOpacity(0.2),
            margin: EdgeInsets.all(8),
            icon: Icon(
              Icons.access_time,
              color: AppColor.primaryColor,
              size: 18,
            ),
          ),
        ).expanded,
      ],
    );
  }
}
