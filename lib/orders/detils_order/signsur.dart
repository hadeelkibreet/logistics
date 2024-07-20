import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  late SignatureController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveSignature() async {
    if (await Permission.storage.request().isGranted) {
      final Uint8List? data = await _controller.toPngBytes();
      if (data != null) {
        final directory = await getExternalStorageDirectory();
        final file = File('${directory!.path}/signature.png');
        await file.writeAsBytes(data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signature saved to ${file.path}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save signature')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signature Example'),
      ),
      body: Column(
        children: [
          Signature(
            controller: _controller,
            height: 300,
            backgroundColor: Colors.grey,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _controller.clear();
                  });
                },
                child: Text('Clear'),
              ),
              ElevatedButton(
                onPressed: _saveSignature,
                child: Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
