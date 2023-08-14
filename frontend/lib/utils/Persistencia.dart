import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferencesUtil? _instance;
  late SharedPreferences _prefs;

  SharedPreferencesUtil._internal();

  static Future<SharedPreferencesUtil> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesUtil._internal();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String token) async {
    await _prefs.setString('token', token);
  }

  String getToken() {
    return _prefs.getString('token') ?? '';
  }
  // Otros métodos para guardar/recuperar otros datos de Shared Preferences
}
DateTime visitDateTime(TimeOfDay visitTime, int value) {
    final now = DateTime.now();
    if (value == 1) {
      return DateTime(
          now.year, now.month, now.day + 1, visitTime.hour, visitTime.minute);
    } else {
      return DateTime(
          now.year, now.month, now.day, visitTime.hour, visitTime.minute);
    }
  }
bool validateNameVisitor(String value) {
  if (value.trim().split(' ').length < 2) {
    return false;
  }
  return true;
}
bool validateTimeVisit(TimeOfDay time){
  if(time.hour < TimeOfDay.now().hour){
    return false;
  }else if(time.hour == TimeOfDay.now().hour && time.minute < TimeOfDay.now().minute){
    return false;
  }
  return true;
}

Future widgetLoading(BuildContext context) async{
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return const Center(child: CircularProgressIndicator());
      });
  }