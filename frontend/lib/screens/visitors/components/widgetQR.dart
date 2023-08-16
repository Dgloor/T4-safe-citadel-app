
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_flutter/src/qr_image_view.dart';

import '../../../utils/Persistencia.dart';


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
            },
            child: const Text('Compartir'),
          ),
        ],
      ),
    );
  }

  
}
