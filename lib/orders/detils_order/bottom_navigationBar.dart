import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/constants/dio.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:logistics/i18n/strings.g.dart';

Widget MyBottomNavigationBar2(
    BuildContext context, ref, requestId, statusData) {
  dynamic selectedId; // Track the selected radio button id
  //
  // final List<Map<String, dynamic>> statusData = [
  //   {"id": 1, "name": "Bad_Sender_Address"},
  //   {"id": 2, "name": "Sender_Not_Available"},
  //   {"id": 3, "name": "Sender_Mobile_Switched_Off"},
  //   {"id": 4, "name": "Sender_Mobile_Wrong_or_Incomplete"},
  //   {"id": 5, "name": "Sender_Mobile_No_Response"},
  //   {"id": 6, "name": "Pick_Up_Address_is_Out_of_Service_Area"},
  //   {"id": 7, "name": "Unable_to_Access_Sender_Premises_or_Closed"},
  //   {"id": 8, "name": "Out_For_Delivery"},
  //   {"id": 9, "name": "Arrived_at_Delivery_Address"},
  //   {"id": 10, "name": "Bad_Recipient_Address"},
  //   {"id": 11, "name": "Recipient_Not_Available"},
  //   {"id": 12, "name": "Recipient_Mobile_Switched_Off"},
  //   {"id": 13, "name": "Recipient_Number_is_Wrong_or_Incomplete"},
  //   {"id": 14, "name": "Recipient_Mobile_No_Response"},
  //   {"id": 15, "name": "Unable_to_Access_Recipient_Premises_or_Closed"},
  //   {"id": 16, "name": "No_Capacity_or_Time"},
  //   {"id": 17, "name": "Pick_Up_Rejected"},
  //   {"id": 18, "name": "Delivery_Rejected"},
  //   {"id": 19, "name": "Delivery_Failed"}
  // ];

  return Center(child: StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      return Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: statusData.length,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    title: Text(
                      statusData[index]["name"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    value: statusData[index]["name"],
                    groupValue: selectedId,
                    onChanged: (value) {
                      setState(() {
                        selectedId = value;
                        print("Selected ID: $selectedId");
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Handle submit button press
                print("Submit button pressed. Selected ID: $selectedId");
                await ApiService()
                    .postReject(Endpoints.reject, ref, selectedId, requestId);
              },
              child: Container(
                width: 250.w,
                child: Center(
                  child: Text(
                    t.cancel,
                    style: TextStyle(color: Colors.white, fontSize: 25.sp),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      );
    },
  ));
}
