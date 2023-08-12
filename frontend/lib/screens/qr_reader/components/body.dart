import 'dart:developer';
import 'dart:io';
import 'package:safecitadel/utils/Persistence.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:safecitadel/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import 'package:safecitadel/screens/qr_reader/qr_reader_screen.dart';

void main() => runApp(const MaterialApp(home: Body()));

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear Código QR')),
      body: //crear una columna con 3 elementos: una imagen, un boton, otro boton. Uno debajo de otro centrados
          Column(
            //centrar la columna  
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //imagen
           Align(
              alignment: Alignment.bottomCenter,
              child:Image.asset(
            'assets/images/qr.png',
            height: 300,
            width: 300,
          ),
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
          //boton
           DefaultButton(
          press: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QRViewExample(),
            ));
          },
          text: 'Escanear Código QR',
        ),
         SizedBox(height: getProportionateScreenWidth(20)),
          //boton
        ],
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    const Text('Escanea el código'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            style: buttonStyle,
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return const Text('Flash');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            style: buttonStyle,
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return const Text(
                                      'Voltear cámara');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 400.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 20,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      try {
        String code =result?.code ?? "00000";
        var visitData = await ApiGlobal.api.getVisitByQRCode(code);
        _showVisitInfoPopup(visitData,code);
      } catch (error) {
        print('Error obteniendo información de visita: $error');
      }
    });
}

  void _showVisitInfoPopup(dynamic visitData,String code) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Información sobre la visita'),
            content: Text('Nombre del visitante: ${visitData['visitor']['name']}.\nLa residencia a la que se dirige es ${visitData['residence']['address']}\n'),
            
            actions: [
              TextButton(      
                style: TextButton.styleFrom(foregroundColor: kPrimaryLightColor),  // Establece el color aquí
                onPressed: () {
                  ApiGlobal.api.registerVisit(code);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Registro exitoso!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pushNamed(context, QRScreen.routeName);
                },
                child: const Text('Aceptar'),
              ),
              TextButton(
                
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () {
                   ApiGlobal.api.cancelVisit(code);
                   Navigator.pushNamed(context, QRScreen.routeName);
                },
                child: const Text('Cancelar'),
              ),
            ],
          );
        });
  }


  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}