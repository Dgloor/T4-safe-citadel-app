import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_flutter/src/qr_image_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class QRCodeModal extends StatefulWidget {
  final String visitID;

  const QRCodeModal(
      {required this.visitID});
  @override
  _QRCodeModalState createState() => _QRCodeModalState();
}

class _QRCodeModalState extends State<QRCodeModal> {
  GlobalKey globalkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: RepaintBoundary(
                key: globalkey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: QrImageView(
                    data: widget.visitID,
                    size: 300.0,
                  ),
                ),
              )),
          const SizedBox(height: 60.0),
          const Text(
            'Enviar código QR al visitante',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              shareQR(context, widget.visitID);
              // convertQRtoImage();
            },
            child: const Text('Compartir'),
          ),
        ],
      ),
    );
  }

  void shareQR(BuildContext context, String visitID) async {
    final qrImage = await QrPainter(
      data: visitID,
      version: QrVersions.auto,
      dataModuleStyle : QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: ui.Color.fromARGB(255, 255, 255, 255)),
      eyeStyle:
          QrEyeStyle(eyeShape: QrEyeShape.square, color: ui.Color.fromARGB(255, 255, 255, 255)),
      gapless: true,
    ).toImageData(1200);
    final filename = 'qr_code.png';
    final tmpDir = await getTemporaryDirectory();
    final file = await File('${tmpDir.path}/$filename').create();
    var bytes = qrImage!.buffer.asUint8List();
    await file.writeAsBytes(bytes);
    XFile img = XFile(file.path);
    await Share.shareXFiles([img],
        text:
            'Hola! te comparto el Código QR para que tengas acceso a mi residencia.');
  }

  // Future<void> convertQRtoImage() async {
  //   RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  //   final boundary = globalkey.currentContext!.findRenderObject();
  //   ui.Image image = await boundary.toImage();
  //   final directory = (await getApplicationDocumentsDirectory()).path;
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List pngBytes = byteData!.buffer.asUint8List();
  //   File imgFile = File("$directory/qrCode.png");
  //   await imgFile.writeAsBytes(pngBytes);
  //   XFile img = XFile(imgFile.path);
  //   await Share.shareXFiles([img],
  //       text:
  //           'Hola! te comparto el Código QR para que tengas acceso a mi residencia.');
  // }
}
