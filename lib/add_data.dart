import 'package:diabetes_tracker/model/record_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddData extends StatefulWidget {
  GlobalKey<FormState> formKey;

  AddData({this.formKey});

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _textEditingController = TextEditingController();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _textEditingController.text =
            DateFormat('dd-MM-yyyy').format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    _textEditingController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
    return Form(
      key: widget.formKey,
      child: Container(
        //padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: mediaWidth,
                  child: ListTile(
                    leading: Text("Fasting"),
                    title: Container(
                      margin: EdgeInsets.only(left: 25),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          context.read<RecordProvider>().setFasting(value);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: mediaWidth,
                  child: ListTile(
                    leading: Text("PP"),
                    title: Container(
                      margin: EdgeInsets.only(left: 7),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          context.read<RecordProvider>().setPP(value);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: mediaWidth,
                  child: ListTile(
                    leading: Text("Date"),
                    title: Container(
                      margin: EdgeInsets.only(left: 45),
                      child: TextFormField(
                        controller: _textEditingController,
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          context
                              .read<RecordProvider>()
                              .setDate(selectedDate.millisecondsSinceEpoch);
                        },
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
