import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logistics/constants/dio.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:logistics/i18n/strings.g.dart';
import 'package:logistics/orders/active_orders/active_orders.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:uuid/uuid.dart';

import '../../constants/colors.dart';

class SendersSignatureScreen extends ConsumerStatefulWidget {
  final String requestId;
  const SendersSignatureScreen({Key? key, required this.requestId})
      : super(key: key);

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
  File? file1;
  File? file2;
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
                    // SnderInfoRow(Icons.person, SendersNameController,
                    //     t.SendersName, false, false, true),
                    SnderInfoRow(Icons.image, SendersIDController, t.SendersID,
                        true, false, false),
                    SnderInfoRow(Icons.comment, SendersNumberController,
                        t.comment, false, false, false),
                    // SnderInfoRow(Icons.confirmation_num_outlined, SendersQRController,
                    //     t.AirWaybillNumber, false, true, false),
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
                onPressed: () async {
                  await saveSignatureAsFile();
                  if (file1 != null &&
                      file2 != null &&
                      SendersNumberController.text != null) {
                    await ApiService().postSendersSig(
                        Endpoints.postSenderSig,
                        ref,
                        file1!,
                        file2!,
                        widget.requestId,
                        '1',
                        SendersNumberController.text);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ActiveOrders()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'can\'t uploading information,please try agen')),
                    );
                  }
                },
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
                    _showPicker(context);
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

  Future<File?> saveSignatureAsFile() async {
    if (_controllerSenderSignature.isNotEmpty) {
      // Capture the signature as bytes
      Uint8List? signature = await _controllerSenderSignature.toPngBytes();
      if (signature != null) {
        // Get the temporary directory to save the file
        final tempDir = await getTemporaryDirectory();
        var uuid = Uuid();
        final filePath = '${tempDir.path}/${uuid.v4()}.png';

        // Save the signature to a file
        File file = File(filePath);
        file2 = await file.writeAsBytes(signature);
        return file;
      }
    }
    return null;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() async {
        _image = File(pickedImage.path);
        file1 = await File(pickedImage.path);
        SendersIDController.text =
            _image!.path; // Use the path directly without toString()
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
