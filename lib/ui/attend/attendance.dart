import 'dart:io';

import 'package:attendance_app/ui/attend/camera_screen.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class Attendance extends StatefulWidget {
  final XFile? image;
  const Attendance({super.key, required this.image});

  @override
  State<Attendance> createState() => _AttendanceState(this.image);
}

class _AttendanceState extends State<Attendance> {
  _AttendanceState(this.image);

  XFile? image;
  // mau melampirkan beberapa informasi
  String adress = "", date = "", time = "", dateTime = "", status = "Attend";
  bool isLoading = false;
  // double untuk desimal
  // lat = vertical, long = horizontal
  double lat = 0.0, long = 0.0;
  int dateHourse = 0, minute = 0;
  // kayak study case yg auth, kita mau masukin nama disini
  final controller = TextEditingController();
  // FirebaseFirestore.instance.collection('attendance') => itu yg dimasukin key nya
  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('attendance');

  @override
  void initState() {
    handleLocationPermission();
    setDateTime();
    setAttendStatus();

    // ketika image udah gak kosong
    if (image != null) {
      isLoading = true;
      getGeoLocationPosition();
    }
  }

  // @override => anotasi
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          // biar balik ke halaman awal
          onPressed: () => Navigator.of(context).pop,
        ),
        title: Text(
          "Attendace Report",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.blueAccent),
                child: Row(
                  children: [
                    SizedBox(width: 12),
                    Icon(Icons.face_retouching_natural_outlined),
                    SizedBox(width: 12),
                    // kasih informasi, harus take foto dulu
                    Text(
                      "Please scan your face!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                child: Text(
                  "Capture Image",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              // bikin sebuah objek biar bisa menerima gesture
              // biar capture nya bisa di klik
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CameraScreen()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    10,
                    0,
                    10,
                    20,
                  ),
                  width: size.width,
                  height: 150,
                  child: DottedBorder(
                    radius: Radius.circular(10),
                    borderType: BorderType.RRect,
                    strokeWidth: 1,
                    dashPattern: [5, 5],
                    child: SizedBox.expand(
                        child: FittedBox(
                            child: image != null
                                ? Image.file(
                                    File(image!.path),
                                    fit: BoxFit.cover,
                                  )
                                : Icon(Icons.camera_enhance_outlined))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  controller: controller,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      labelText: "Your Name",
                      hintText: "Please type your name",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      labelStyle: TextStyle(fontSize: 14, color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
