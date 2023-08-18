import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:qr_flutter/qr_flutter.dart';

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

  void shareQR(BuildContext context, String visitID, String nameVisit, String dateVisit) async {
    final qrImage = await QrPainter(
      data: visitID,
      version: QrVersions.auto,
      dataModuleStyle : QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: ui.Color.fromARGB(255, 255, 255, 255)),
      eyeStyle:
          QrEyeStyle(eyeShape: QrEyeShape.square, color: ui.Color.fromARGB(255, 255, 255, 255)),
      gapless: true,
    ).toImageData(1200);
    const filename = 'codigoQR.png';
    final tmpDir = await getTemporaryDirectory();
    final file = await File('${tmpDir.path}/$filename').create();
    var bytes = qrImage!.buffer.asUint8List();
    await file.writeAsBytes(bytes);
    XFile img = XFile(file.path);
    await Share.shareXFiles([img],
        text:
            'Código QR generado para *$nameVisit*, para la visita del día *$dateVisit* a S7. Por favor, no compartir con nadie.');
  }