import 'package:flutter/material.dart';
import 'package:kechka/provider/task_provider.dart';
import 'package:provider/provider.dart';

import 'constant/color.dart';
import 'pages/home_page.dart';

void main() {
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
          fontFamily: "Space Mono",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
