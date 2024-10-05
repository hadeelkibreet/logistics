// return SingleChildScrollView(
//   child: Form(
//     key: _formkey,
//     child: Column(
//       children: [
//         Stack(
//           children: [
//             Container(
//               height: 190,
//               decoration: BoxDecoration(
//                 color: ColorsApp.primaryColor.withOpacity(0.2),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(50.0),
//                   bottomRight: Radius.circular(50.0),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       backgroundImage:
//                           AssetImage(profile.code as String),
//                       radius: 50.sp,
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       profile.name,
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       profile.phone,
//                       style: TextStyle(
//                           fontSize: 16, color: Colors.grey[700]),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 16.0),
//           padding: EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               buildInfoRow(Icons.info, t.personalInfo, '', true),
//               Divider(thickness: 1),
//               buildInfoRow(
//                   Icons.cake, profile.phone, t.dateOfBirth),
//               buildInfoRow(Icons.person, profile.gender, t.gender),
//               buildInfoRow(Icons.public, profile.name, t.Country),
//               buildInfoRow(Icons.email, profile.email, t.email),
//               Stack(
//                 children: [
//                   TextFormField(
//                     controller: _passwordController,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return t.EnterThePassword;
//                       }
//                       // Add additional validation logic here if needed
//                       return null; // Return null if the value is valid
//                     },
//                     obscureText: !_passwordVisible,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: ColorsApp.white,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide.none,
//                       ),
//                       suffixIcon: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _passwordVisible = !_passwordVisible;
//                           });
//                         },
//                         child: Icon(
//                           _passwordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: Colors.grey.withOpacity(0.9),
//                         ),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.lock,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 4.0, horizontal: 50),
//                     child: Text(
//                       t.passWord,
//                       // style: TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 ],
//               ),
//               TextButton(
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         backgroundColor: ColorsApp.white,
//                         title: Column(
//                           children: [
//                             Icon(
//                               Icons.question_mark,
//                               color: ColorsApp.primaryColor,
//                               size: 45.sp,
//                             ),
//                             SizedBox(
//                               height: 10.h,
//                             ),
//                             Text(
//                               t.DoYouReallyWantToLogOut,
//                               style: TextStyle(
//                                 color: ColorsApp.primaryColor,
//                                 fontSize: 16.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                         actions: [
//                           Row(
//                             mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text(
//                                   t.no,
//                                   style: TextStyle(
//                                     color: ColorsApp.primaryColor,
//                                   ),
//                                 ),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   // Navigator.pushAndRemoveUntil(
//                                   //   context,
//                                   //   MaterialPageRoute(
//                                   //       builder: (context) => LogInScreen()),
//                                   //       (route) => false,
//                                   // );
//                                 },
//                                 child: Text(
//                                   t.yes,
//                                   style: TextStyle(
//                                     color: ColorsApp.primaryColor,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: Text(
//                   t.changeThePassWord,
//                   style: TextStyle(color: ColorsApp.primaryColor),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// );
