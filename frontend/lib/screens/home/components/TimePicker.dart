import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePickerPage extends StatefulWidget {
  const TimePickerPage({super.key});

  @override
  State<TimePickerPage> createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildTimePicker()),
    );
  }
  Widget buildTimePicker() => SizedBox(
    height: 180,
    child:CupertinoDatePicker(
    initialDateTime: dateTime,
    mode: CupertinoDatePickerMode.time,
    onDateTimeChanged: (dateTime) =>
    setState(() {
      this.dateTime = dateTime;
    }),
  ));
}