import 'package:flutter/material.dart';

class DriverStatusScreen extends StatefulWidget {
  @override
  _DriverStatusScreenState createState() => _DriverStatusScreenState();
}

class _DriverStatusScreenState extends State<DriverStatusScreen> {
  bool isServes = false;
  bool inBrack = false;
  bool inOut = false;
  Color borderColor1 = Colors.grey[300]!;
  Color borderColor2 = Colors.grey[300]!;
  Color borderColor3 = Colors.grey[300]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('جدول الخدمة'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.red,
            padding: EdgeInsets.all(16.0),
            child: Text(
              'خارج الخدمة',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                buildStatusOption(
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                  text: 'أنا في الخدمة',
                  borderColor: borderColor1,
                  iconBgColor: Colors.grey[300]!,
                  NumberOfser: 1,
                  isServes: isServes,
                  inBrack: inBrack,
                  inOut: inOut,
                  onPressed: () {
                    setState(() {
                      isServes = true;
                      inBrack = false;
                      inOut = false;
                      borderColor1 = Colors.green;
                      borderColor2 = Colors.grey[300]!;
                      borderColor3 = Colors.grey[300]!;
                    });
                  },
                ),
                SizedBox(height: 8),
                buildStatusOption(
                  icon: Icons.free_breakfast,
                  iconColor: Colors.orange,
                  text: 'أنا في استراحة',
                  borderColor: borderColor2,
                  iconBgColor: Colors.grey[300]!,
                  NumberOfser: 2,
                  isServes: isServes,
                  inBrack: inBrack,
                  inOut: inOut,
                  onPressed: () {
                    setState(() {
                      isServes = false;
                      inBrack = true;
                      inOut = false;
                      borderColor1 = Colors.grey[300]!;
                      borderColor2 = Colors.amber;
                      borderColor3 = Colors.grey[300]!;
                    });
                  },
                ),
                SizedBox(height: 8),
                buildStatusOption(
                  icon: Icons.cancel,
                  iconColor: Colors.red,
                  text: 'أنا خارج الخدمة',
                  borderColor: Colors.grey[300]!,
                  iconBgColor: Colors.red[100]!,
                  textColor: Colors.black,
                  NumberOfser: 3,
                  isServes: isServes,
                  inBrack: inBrack,
                  inOut: inOut,
                  onPressed: () {
                    setState(() {
                      isServes = false;
                      inBrack = false;
                      inOut = true;

                      borderColor1 = Colors.grey[300]!;
                      borderColor2 = Colors.grey[300]!;
                      borderColor3 = Colors.red;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStatusOption({
    required IconData icon,
    required Color iconColor,
    required String text,
    required Color borderColor,
    required Color iconBgColor,
    required int NumberOfser,
    required bool isServes,
    required bool inBrack,
    required bool inOut,
    Color textColor = Colors.black,
    required VoidCallback onPressed,
  }) {
    Color optionBgColor = borderColor; // تعيين لون الخلفية الافتراضي

    // التحقق من الخيار المحدد وتعيين لون الخلفية بناءً على ذلك
    if (NumberOfser == 1 && isServes) {
      optionBgColor = Colors.green; // لون خلفية الخيار الأول
    } else if (NumberOfser == 2 && inBrack) {
      optionBgColor = Colors.orange; // لون خلفية الخيار الثاني
    } else if (NumberOfser == 3 && inOut) {
      optionBgColor = Colors.red; // لون خلفية الخيار الثالث
    }

    return Container(
      decoration: BoxDecoration(
        color: optionBgColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
