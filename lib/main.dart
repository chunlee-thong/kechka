import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kechka/constant/app_constant.dart';
import 'package:kechka/model/time_of_day_adapter.dart';
import 'package:kechka/pages/splash_page.dart';
import 'package:kechka/provider/task_provider.dart';
import 'package:provider/provider.dart';

import 'constant/color.dart';
import 'model/task_model.dart';

void main() async {
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: MaterialApp(
        title: 'KechKa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppColor.primaryColor,
          fontFamily: AppConstant.FONT_NAME,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashPage(),
      ),
    );
  }
}
