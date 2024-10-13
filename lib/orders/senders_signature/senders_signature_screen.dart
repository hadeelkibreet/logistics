import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logistics/data/prefs/prefs.dart';
import 'package:logistics/i18n/strings.g.dart';
import 'package:signature/signature.dart';

import '../../constants/colors.dart';

class SendersSignatureScreen extends ConsumerStatefulWidget {
  const SendersSignatureScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SendersSignatureScreen> createState() =>
      _SendersSignatureScreenState();
}

class _SendersSignatureScreenState
    extends ConsumerState<SendersSignatureScreen> {
  late TextEditingController SendersNameController = TextEditingController();
  late TextEditingController SendersNumberController = TextEditingController();
  late TextEditingController SendersQRController =
      TextEditingController(text: "000");
  File? _image;
  late TextEditingController SendersIDController = TextEditingController();
  late SignatureController _controllerSenderSignature;
  final bool validationNameAndPhone = true;

  @override
  void initState() {
    super.initState();
    _controllerSenderSignature = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _controllerSenderSignature.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          t.sendersSignature,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Card(
              color: ColorsApp.white,
              margin: EdgeInsets.all(16.0.sp),
              child: Padding(
                padding: EdgeInsets.all(16.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SnderInfoRow(Icons.person, SendersNameController,
                        t.SendersName, false, false, true),
                    SnderInfoRow(Icons.image, SendersIDController, t.SendersID,
                        true, false, false),
                    SnderInfoRow(Icons.phone, SendersNumberController,
                        t.phoneNumber, false, false, true),
                    SnderInfoRow(Icons.confirmation_number, SendersQRController,
                        t.AirWaybillNumber, false, true, false),
                    SizedBox(height: 11),
                    Text(
                      t.sendersSignature,
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 10.h),
                        Container(
                          height: 150.0.h,
                          width: 300.0.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          child: Signature(
                            controller: _controllerSenderSignature,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ColorsApp.white),
                            minimumSize: MaterialStateProperty.all<Size>(
                              Size(0, 30),
                            ),
                            elevation: MaterialStateProperty.all<double>(2),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _controllerSenderSignature.clear();
                            });
                          },
                          child: Text(
                            t.clear,
                            style: TextStyle(color: ColorsApp.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF449F45),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                child: Text(
                  t.Save,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SnderInfoRow(
      IconData icon,
      TextEditingController controller,
      String labelText,
      bool isimage,
      bool isQr,
      bool isValidationNameAndPhone) {
    return Padding(
      padding: EdgeInsets.all(3.0.sp),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              enabled: isimage ? false : true,
              controller: controller,
              decoration: InputDecoration(
                label: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: Text(
                          isValidationNameAndPhone
                              ? controller.text.isEmpty
                                  ? '*'
                                  : ''
                              : '',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          labelText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          isimage
              ? ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(ColorsApp.white),
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(50, 50),
                    ),
                    elevation: MaterialStateProperty.all<double>(1),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _pickImage(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.file_upload,
                        color: ColorsApp.primaryColor,
                      ),
                      Text(
                        t.Upload,
                        style: TextStyle(
                          color: ColorsApp.primaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              : isQr
                  ? Padding(
                      padding: EdgeInsets.only(top: 28.0.sp),
                      child: IconButton(
                          onPressed: () {
                            scanQRCode();
                          },
                          icon: Icon(Icons.qr_code_scanner)),
                    )
                  : SizedBox(
                      height: 0,
                    ),
        ],
      ),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        SendersQRController.text =
            qrCode.toString() != '-1' ? qrCode.toString() : '';
      });

      print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      print('Failed to scan QR Code.');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        SendersIDController.text =
            _image!.path; // Use the path directly without toString()
      });

      try {
        var dio = Dio();
        final prefHelper = ref.read(prefHelperProvider);

        var headers = {'Authorization': 'Bearer ${prefHelper.getUserToken}'};

        var data = FormData.fromMap({
          'files': [
            await MultipartFile.fromFile(_image!.path, filename: 'file1.jpg'),
            await MultipartFile.fromFile(_image!.path, filename: 'file2.jpg'),
          ],
          'request_id': '34',
          'step': '1',
          'comment': 'hdeel'
        });

        var response = await dio.post(
          'https://dashboard.alnco.co/api/validateStep',
          options: Options(headers: headers),
          data: data,
        );

        if (response.statusCode == 200) {
          print(json.encode(response.data));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload successful')),
          );
        } else {
          print(response.statusMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload failed: ${response.statusMessage}')),
          );
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading data')),
        );
      }
      print('File path: ${_image!.path}');
    }
  }

  Future<void> _uploadData(XFile source) async {
    // if (_image == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Please upload an image')),
    //   );
    //   return;
    // }

    try {
      var dio = Dio();
      final preHelper = ref.read(prefHelperProvider);

      var headers = {'Authorization': 'Bearer ${preHelper.getUserToken}'};

      var data = FormData.fromMap({
        'files': [
          await MultipartFile.fromFile(source.path, filename: '${source.name}'),
          await MultipartFile.fromFile(source.path, filename: '${source.name}'),
        ],
        'request_id': '34',
        'step': '1',
        'comment': 'hadeeel'
      });

      var response = await dio.post(
        'https://dashboard.alnco.co/api/validateStep',
        options: Options(headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload successful')),
        );
      } else {
        print(response.statusMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: ${response.statusMessage}')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading data')),
      );
    }
  }
}
