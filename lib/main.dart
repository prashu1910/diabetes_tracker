import 'package:diabetes_tracker/model/current_view.dart';
import 'package:diabetes_tracker/model/record_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CurrentView()),
          ChangeNotifierProvider(create: (_) => RecordProvider()),
          //FutureProvider(create: (_) => RecordProvider().getRecords())
        ],
        child: MyHomePage(
          title: 'Diabetes Tracker',
          formKey: _formKey,
        ),
      ),
    );
  }
}
