import 'package:attendance_app/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  final DataService dataService = DataService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance History"),
      ),
      // 1 kelas yg mebuat ui kita menjadi ter manage
      body: StreamBuilder(
          //snapshots: memanage atau menhandle data2 yg kita ambil
          stream: dataService.dataCollection.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // kalau semisalkan gaada data
            if (!snapshot.hasData) {
              return const Center(
                child: Text("There's no data"),
              );
            }
            // sebuah list dari querydocumentsapshots
            // kalau snapshot ada datanya
            final data = snapshot.data!.docs;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                
              } ,
              );
          }),
    );
  }
}
