import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image1;

  Future<void> pickImages() async {
    // Pick the first image
    final XFile? pickedFile1 =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile1 != null) {
      setState(() {
        _image1 = pickedFile1;
      });
      uploadFiles();
    } else {
      print('No images selected.');
    }
  }

  String getContentType(String filePath) {
    if (filePath.endsWith('.jpg') || filePath.endsWith('.jpeg')) {
      return 'image/jpeg';
    } else if (filePath.endsWith('.png')) {
      return 'image/png';
    } else if (filePath.endsWith('.gif')) {
      return 'image/gif';
    } else if (filePath.endsWith('.svg')) {
      return 'image/svg+xml';
    } else if (filePath.endsWith('.bmp')) {
      return 'image/bmp';
    } else if (filePath.endsWith('.webp')) {
      return 'image/webp';
    } else {
      return 'application/octet-stream'; // Fallback
    }
  }

  Future<void> uploadFiles() async {
    if (_image1 != null) {
      File file1 = await File(_image1!.path);
      File file2 = await File(_image1!.path);
      String contentType = getContentType(file1.path);

      print('${file1.path}');
      var headers = {
        'Authorization':
            'Bearer \$2y\$10\$YIlIxKI3aNn4enpiMM.mqOCsLmMi/0J2nU7Ez05uZaeV3UlgtynHK',
        // 'Content-Type': contentType,
      };

      FormData data = FormData.fromMap({
        'signature': await MultipartFile.fromFile(
          file2.path,
          filename: file2.path.split('/').last,
          // contentType: hp.MediaType.parse(contentType),
        ),
        'image': await MultipartFile.fromFile(
          file1.path,
          filename: file1.path.split('/').last,
          // contentType: hp.MediaType.parse(contentType)
        ),
        'request_id': '34',
        'step': '1',
        'comment': '88'
      });

      Dio dio = Dio();

      try {
        var response = await dio.request(
          'https://dashboard.alnco.co/api/validateStep',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );

        if (response.statusCode == 200) {
          print('Upload success: ${response.data}');
        } else {
          print('Upload failed: ${response.statusMessage}');
        }
      } catch (e) {
        print('Error occurred: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: pickImages,
          child: Text('Pick and Upload Images'),
        ),
      ),
    );
  }
}
