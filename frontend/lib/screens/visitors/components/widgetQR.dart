import 'package:flutter/material.dart';
import 'package:qr_flutter/src/qr_image_view.dart';


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
              // Aquí puedes implementar la lógica para compartir el código QR
              // Puedes utilizar la función Share.share('') aquí
            },
            child: const Text('Compartir'),
          ),
        ],
      ),
    );
  }
}
