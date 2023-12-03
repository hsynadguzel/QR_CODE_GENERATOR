import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class CreateQr extends StatefulWidget {
  const CreateQr({super.key});

  @override
  State<CreateQr> createState() => _CreateQrState();
}

class _CreateQrState extends State<CreateQr> {
  final qrKey = GlobalKey();
  String? qrData;
  TextEditingController dataQrController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              selectSwitchModel(),
              const SizedBox(height: 25.0),
              qrImage(),
              const SizedBox(height: 18.0),
              textField(),
              const SizedBox(height: 15.0),
              text(),
              const SizedBox(height: 18.0),
              buttons(),
            ],
          ),
        ),
      ),
      bottomSheet: bottomTextWidget(),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: const Text(
        'QR CODE GENERATOR',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [gelistiriciHakkindaWidget()],
    );
  }

  IconButton gelistiriciHakkindaWidget() {
    return IconButton(
      onPressed: () => Get.dialog(
        AlertDialog(
          title: const Text(
            'About the Developer',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Color.fromARGB(255, 0, 73, 132),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    children: <TextSpan>[
                      TextSpan(text: 'This application was developed by'),
                      TextSpan(
                        text: ' Hüseyin ADIGÜZEL.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'For your comments and suggestions, you can reach the e-mail address below.',
                      ),
                      TextSpan(
                        text: '\n\nhsynadguzel@gmail.com',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('TAMAM'),
            ),
          ],
        ),
      ),
      icon: const Icon(
        Icons.info_outlined,
        color: Colors.black,
      ),
    );
  }

  Row selectSwitchModel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.square),
        CupertinoSwitch(
          value: switchValue,
          activeColor: Colors.blueGrey,
          onChanged: (bool? value) {
            setState(() {
              switchValue = value ?? false;
            });
          },
        ),
        const Icon(Icons.circle),
      ],
    );
  }

  Screenshot qrImage() {
    return Screenshot(
      controller: screenshotController,
      child: RepaintBoundary(
        key: qrKey,
        child: QrImageView(
          data: qrData.toString(),
          version: QrVersions.auto,
          size: 250.0,
          dataModuleStyle: switchValue == true
              ? const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.circle,
                  color: Colors.black)
              : const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: Colors.black),
          backgroundColor: Colors.white,
        ),
      ),
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
        filled: true,
        border: OutlineInputBorder(
          gapPadding: 3.0,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 3.0,
          ),
        ),
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

  Row buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: _saveGalleryQrCode,
            child: const Text(
              'SAVE TO GALLERY',
              style: TextStyle(color: Color.fromARGB(255, 3, 54, 141)),
            )),
        TextButton(
            onPressed: _shareQrCode,
            child: const Text(
              'SHARE!',
              style: TextStyle(color: Color.fromARGB(255, 3, 54, 141)),
            )),
      ],
    );
  }

  _shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    screenshotController.capture().then((image) async {
      if (image != null) {
        try {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.png').create();
          if (imagePath != null) {
            await imagePath.writeAsBytes(image);
            Share.shareFiles([imagePath.path]);
          }
        } catch (error) {}
      }
    }).catchError((onError) {
      print('Error --->> $onError');
    });
  }

  _saveGalleryQrCode() async {
    var time = DateTime.now();
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/qr-$time.png').create();
        await imagePath.writeAsBytes(image);
        await GallerySaver.saveImage(imagePath.path, albumName: 'QR Code');
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('IMAGE SAVED!'),
            ),
          );
        });
      }
    });
  }

  Padding bottomTextWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.copyright,
            size: 13.0,
          ),
          SizedBox(width: 5.0),
          Text(
            'Developed by ',
            style: TextStyle(fontSize: 12.0),
          ),
          Text(
            'Hüseyin ADIGÜZEL',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
