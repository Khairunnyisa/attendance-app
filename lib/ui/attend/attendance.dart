import 'dart:io';

import 'package:attendance_app/services/location_service.dart';
import 'package:attendance_app/services/timestamp_service.dart';
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
  String adressPlaceholder = "",
      datePlaceholder = "",
      timePlaceholder = "",
      timeStampPlaceholder = "",
      statusPlaceHolder = "Attend";
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
    super.initState;
    handleLocationPermission(context);
    setDateTime((date, time, timeStamp) {
      // siap2 untuk ambil data dari awal
      // value nya kita ambil dari yg didalam setdatetime
      setState(() {
        datePlaceholder = date;
        timePlaceholder = time;
        timeStampPlaceholder = timeStamp;
      });
    });
    // pake status doang karena dia parameter
    setAttendanceStatus((status) {
      setState(() {
        statusPlaceHolder = status;
      });
    });

    // ketika image udah gak kosong
    if (image != null) {
      isLoading = true;
      getGeoLocationPosition(context, (position) {
        // set pertama kali sebelum ada perubahan data
        setState(() {
          isLoading = false;
          getAddressFromLangLat(position, (address) {
            setState(() {
              adressPlaceholder = address;
            });
          });
        });
      });
    }
  }

  // @override => anotasi
  @override
  Widget build(BuildContext context) {
    // untuk mendapatkan size yg sesuai device
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
