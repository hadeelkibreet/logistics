import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/home/profile/entity/profile_entity.dart';
import 'package:logistics/home/profile/providers/profile_provider.dart';
import 'package:logistics/i18n/strings.g.dart';

import '../driver_status/widget/driver_drawar.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final GlobalKey _formkey = GlobalKey<FormState>();
  final TextEditingController _passwordController =
      TextEditingController(text: 'pass1234');
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(profileProvider);

    return Scaffold(
        backgroundColor: ColorsApp.backgroundColor,
        drawer: DriverDrawar(),
        appBar: AppBar(
          title: Text(t.MyProfile),
          centerTitle: true,
        ),
        body: profileData.when(
          data: (ProfileEntity profile) => SingleChildScrollView(
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
                                profile.name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                profile.phone,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        buildInfoRow(Icons.info, t.personalInfo, '', true),
                        Divider(thickness: 1),
                        buildInfoRow(
                            Icons.cake, profile.birthDate, t.dateOfBirth),
                        buildInfoRow(Icons.person, profile.gender, t.gender),
                        buildInfoRow(Icons.public, 'Saudi Arabia', t.Country),
                        buildInfoRow(Icons.email, 'ahmad@gmail.com', t.email),
                        Stack(
                          children: [
                            TextFormField(
                              controller: _passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return t.EnterThePassword;
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
                                t.passWord,
                                // style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: ColorsApp.white,
                                  title: Column(
                                    children: [
                                      Icon(
                                        Icons.question_mark,
                                        color: ColorsApp.primaryColor,
                                        size: 45.sp,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        t.DoYouReallyWantToLogOut,
                                        style: TextStyle(
                                          color: ColorsApp.primaryColor,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            t.no,
                                            style: TextStyle(
                                              color: ColorsApp.primaryColor,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Navigator.pushAndRemoveUntil(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) => LogInScreen()),
                                            //       (route) => false,
                                            // );
                                          },
                                          child: Text(
                                            t.yes,
                                            style: TextStyle(
                                              color: ColorsApp.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            t.changeThePassWord,
                            style: TextStyle(color: ColorsApp.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          error: (error, stackTrace) => Text("Error"),
          loading: () => CircularProgressIndicator(),
        ));
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
