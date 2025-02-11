import 'package:attendance_app/services/data_service.dart';
import 'package:attendance_app/ui/history/components/attendance_card.dart';
import 'package:attendance_app/ui/history/components/delete_dialog.dart';
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
              // mendefinisikan jumlah data
              itemCount: data.length,
              itemBuilder: (context, index) {
                return AttendanceHistoryCard(
                  // list dari querysnapshots, kita panggil index nya dari 0
                  // mendefinisikan data yg akan muncul di ui berdasarka index atau posisi yang ada di database
                  data: data[index].data() as Map<String, dynamic>, 
                  onDelete: (){
                    showDialog(context: context, builder: (context) => DeleteDialog(
                      // untuk menjadikan index sebagai id dari data yang ada di database
                      documentID: data[index].id, 
                      dataCollection: dataService.dataCollection,
                      // digunakan untuk memprebarui state setelah terjadi perhapusan data dari database
                      onConfirm: (){
                        setState(() {
                          dataService.deleteData(data[index].id);
                          Navigator.pop(context);
                        });
                      },
                      )
                      );
                  }
                  );
              } ,
              );
          }),
    );
  }
}
