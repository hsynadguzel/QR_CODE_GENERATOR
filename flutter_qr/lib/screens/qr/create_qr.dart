import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateQr extends StatefulWidget {
  const CreateQr({super.key});

  @override
  State<CreateQr> createState() => _CreateQrState();
}

class _CreateQrState extends State<CreateQr> {
  final qrKey = GlobalKey();
  String? qrData;
  TextEditingController dataQrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 12.0),
          child: Column(
            children: [
              qrImage(),
              const SizedBox(height: 18.0),
              textField(),
              const SizedBox(height: 15.0),
              text(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: const Text(
        'CREATE QR CODE',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Text text() {
    return const Text(
      'In order for your QR code to be generated, you need to fill in the text field. When you fill in the text field, your QR code will be generated automatically.',
      style: TextStyle(
        color: Colors.black,
      ),
      textAlign: TextAlign.justify,
    );
  }

  TextField textField() {
    return TextField(
      onChanged: (value) => setState(() {
        qrData = dataQrController.text;
      }),
      cursorColor: Colors.black,
      controller: dataQrController,
      decoration: const InputDecoration(
        hintText: 'Enter your data',
        border: OutlineInputBorder(
          gapPadding: 5.0,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 5.0,
          ),
        ),
      ),
    );
  }

  RepaintBoundary qrImage() {
    return RepaintBoundary(
      key: qrKey,
      child: QrImage(
        data: qrData.toString(),
        version: QrVersions.auto,
        size: 250.0,
        dataModuleStyle: const QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.circle, color: Colors.black),
        backgroundColor: Colors.white,
      ),
    );
  }
}
