import 'package:diabetes_tracker/add_data.dart';
import 'package:diabetes_tracker/model/current_view.dart';
import 'package:diabetes_tracker/model/record_provider.dart';
import 'package:diabetes_tracker/view_data.dart';
import 'package:diabetes_tracker/view_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  String title;
  GlobalKey<FormState> formKey;
  MyHomePage({this.title, this.formKey});

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      new AddData(formKey: formKey),
      new ViewData(),
      new ViewTable()
    ];
    return Scaffold(
      body: _children[context.watch<CurrentView>().index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<CurrentView>().index,
        onTap: (index) => context.read<CurrentView>().setView(index),
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.add_box_outlined),
            label: 'Add Data',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.addchart_outlined),
            label: 'View Chart',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.addchart_outlined),
            label: 'View Table',
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(title),
        actions: context.watch<CurrentView>().index == 0
            ? [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      print(context.read<RecordProvider>().record);
                      // saveTask();
                      context.read<RecordProvider>().saveRecord();
                      context.read<CurrentView>().setView(2);
                    }
                  },
                ),
              ]
            : [],
      ),
    );
  }
}
