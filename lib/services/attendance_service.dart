import 'package:attendance_app/ui/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// dari cloud_firestore
// an entry point for submitting the attendance report
// menangani pengiriman data dari UI ke firebasefirestore
final CollectionReference dataCollection =
    FirebaseFirestore.instance.collection("attendance");

Future<void> submitAttendanceReport(BuildContext context, String address,
    String name, String attendancestatus, String timeStamp) async {
  showLoaderDialog(context);
  // kita mau ngumpulin data
  dataCollection.add({
    'address': address,
    'name': name,
    'description': attendancestatus
  }).then((result) {
    Navigator.of(context).pop();
    try {
      // kalau data nya benar, dia bakal langsung balik ke home screen tanpa klik apapun
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Attendance submitted successfully",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        backgroundColor: Colors.orangeAccent,
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              "Ups, $e",
              style: TextStyle(color: Colors.white),
            ))
          ],
        ),
      ));
    }
  });
}

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        //
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text("Checking the data..."),
        )
      ],
    ),
  );
  // 1 method yg nge return alert

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      });
}
