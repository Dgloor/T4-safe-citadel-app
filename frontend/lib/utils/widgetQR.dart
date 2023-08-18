import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

import '../../../utils/Persistencia.dart';

class QRCodeModal extends StatefulWidget {
  final String visitID;
  final String? nombreVisita;
  final DateTime fechaVisita;

  const QRCodeModal(
      {required this.visitID,
      required this.nombreVisita,
      required this.fechaVisita});
  @override
  _QRCodeModalState createState() => _QRCodeModalState();
}

class _QRCodeModalState extends State<QRCodeModal> {
  GlobalKey globalkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    String fechaVisita =
        DateFormat('dd/MM/yyyy HH:mm').format(widget.fechaVisita);
    return SizedBox(
       key: const Key("qrCodeModal"),
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
          Center(
              child: Text(
            'Visita: ${widget.nombreVisita}\n Fecha y hora de visita: ${fechaVisita}',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
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
              shareQR(context, widget.visitID, widget.nombreVisita!,fechaVisita);
            },
            child: const Text('Compartir'),
          ),
        ],
      ),
    );
  }
}