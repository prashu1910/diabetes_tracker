import 'dart:ui';

import 'package:diabetes_tracker/model/record_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'model/record.dart';

class ViewTable extends StatefulWidget {
  @override
  _ViewTableState createState() => _ViewTableState();
}

class _ViewTableState extends State<ViewTable> {
  @override
  Widget build(BuildContext context) {
    List<Record> _records = context.watch<RecordProvider>().recList;
    if (_records != null) {
      _records.sort((a, b) => a.date > b.date
          ? 1
          : a.date == b.date
              ? 0
              : -1);
    }
    return Container(
      margin: EdgeInsets.all(20),
      child: _records == null
          ? Container(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Fasting",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "PP",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                for (var item in _records)
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('dd-MM-yyyy').format(
                              DateTime.fromMillisecondsSinceEpoch(item.date))),
                          Text(item.fasting.toString()),
                          Text(item.pp.toString()),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => {
                              context
                                  .read<RecordProvider>()
                                  .deleteRecord(item.id)
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
