import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:kechka/constant/app_constant.dart';
import 'package:kechka/constant/style.dart';
import 'package:kechka/model/task_model.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void onSplash() async {
    await Future.delayed(Duration(seconds: 2));
    await Hive.openBox<TaskModel>(AppConstant.TASK_BOX_NAME);
    PageNavigator.pushReplacement(context, HomePage());
  }

  @override
  void initState() {
    onSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/taking-note.png"),
            SpaceY(16),
            Text("Manage your task", style: headerStyle),
            SpaceY(),
            Text(
              "With a time tracker, you can effectively manage your time.",
              style: subtitleStyle,
            )
          ],
        ),
      ),
    );
  }
}
