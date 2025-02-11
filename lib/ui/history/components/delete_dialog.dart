// sebuah notification yg berbentuk dialog atau poput notification

import 'package:attendance_app/services/attendance_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String documentID;
  final CollectionReference dataCollection;

  const DeleteDialog(
      {super.key, required this.documentID, required this.dataCollection, Null Function()? onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Delete Data",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      content: const Text(
        "Are you sure want to delete this data",
        style: TextStyle(fontSize: 14, color: Colors.black),
      ),
      actions: [
        TextButton(
          child: const Text(
            "Yes",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onPressed: () {
            // untuk berkomunikasi dengan database, untuk melakukan penghapusan data dari database
            dataCollection.doc(documentID).delete();
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text(
            "No",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
