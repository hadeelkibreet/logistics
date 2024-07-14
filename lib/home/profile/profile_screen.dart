import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/i18n/strings.g.dart';

import '../driver_status/widget/driver_drawar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey _formkey = GlobalKey<FormState>();
  final TextEditingController _passwordController =
      TextEditingController(text: 'pass1234');
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DriverDrawar(),
      appBar: AppBar(
        title: Text(t.MyProfile),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 190,
                    decoration: BoxDecoration(
                      color: ColorsApp.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s',
                            ),
                            radius: 50.sp,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'ahmed',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '0555555555',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    buildInfoRow(Icons.info, 'معلومات شخصية', '', true),
                    Divider(thickness: 1),
                    buildInfoRow(Icons.cake, 'Mar 15, 2021', 'تاريخ الميلاد'),
                    buildInfoRow(Icons.person, 'ذكر', 'الجنس'),
                    buildInfoRow(Icons.public, 'Saudi Arabia', 'البلد'),
                    buildInfoRow(
                        Icons.email, 'ahmad@gmail.com', 'البريد الإلكتروني'),
                    // buildInfoRow(Icons.lock, '111', 'كلمة المرور'),

                    Stack(
                      children: [
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 't.EnterThePassword';
                            }
                            // Add additional validation logic here if needed
                            return null; // Return null if the value is valid
                          },
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorsApp.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              child: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey.withOpacity(0.9),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 50),
                          child: Text(
                            'كلمة المرور',
                            // style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'تغيير كلمة السر',
                          style: TextStyle(color: ColorsApp.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String text, String title,
      [bool isTitle = false]) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isTitle
                  ? SizedBox(
                      width: 0,
                    )
                  : Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
              Text(
                text,
                style: TextStyle(
                  fontSize: isTitle ? 18 : 16,
                  fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
