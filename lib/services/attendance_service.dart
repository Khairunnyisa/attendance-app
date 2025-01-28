import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// dari cloud_firestore
final CollectionReference dataCollection =
    FirebaseFirestore.instance.collection("attendance");

Future<void> submitReport(BuildContext context, String address, String name,
    String status, String timeStamp) async {
  // showLoaderDialog(context);
}
