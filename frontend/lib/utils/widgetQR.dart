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
          const SizedBox(height: 16.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Visitante: ',
                style: TextStyle(
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(204, 141, 38, 1)
                ),
              ),
              Text(
                '${widget.nombreVisita}',
                style: TextStyle(
                  fontSize: 21.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Fecha y hora: ',
                style: TextStyle(
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                  color:  Color.fromRGBO(204, 141, 38, 1)
                ),
              ),
              Text(
                '${fechaVisita}',
                style: TextStyle(
                  fontSize: 21.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40.0),
          ElevatedButton.icon(
            onPressed: () {
              shareQR(
                  context, widget.visitID, widget.nombreVisita!, fechaVisita);
            },
            icon: const Icon(Icons.share),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(2, 69, 1, 1), // Background color
            ),
            label: const Text('Compartir QR', style: TextStyle(color: Color.fromRGBO(255, 254, 254, 1)))
          ),
        ],
      ),
    );
  }
}
