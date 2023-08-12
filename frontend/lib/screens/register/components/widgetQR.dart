import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';


class QRCodeModal extends StatefulWidget {
  final String visitID;

  const QRCodeModal({super.key, required this.visitID});

  @override
  _QRCodeModalState createState() => _QRCodeModalState();
}

class _QRCodeModalState extends State<QRCodeModal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: QrImageView(
              data: widget.visitID,
              size: 300.0,
            ),
          ),
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
              shareQR(context,widget.visitID);
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
      gapless: false,
      ).toImageData(200.0);
    const filename = 'qr_code.png';
    final tmpDir = await getTemporaryDirectory();
    final file = await File('${tmpDir.path}/$filename').create();
    var bytes = qrImage!.buffer.asUint8List();
    await file.writeAsBytes(bytes);
    XFile img = XFile(file.path);
    await Share.shareXFiles([img], text: 'Código QR para la visita'); 

  }
}
