import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializeapp: pertama yg dipanggil sebelum pake langganan yg lain
  await Firebase.initializeApp(
      options: FirebaseOptions(
          // data yg diambil dari file google.service.json
          apiKey: "AIzaSyDRM7VQ48oNLxSHG3OGRdQ7JTx5M8yGgLc", //current_key
          appId:
              "1:895275453906:android:f3b58fa41207f113e88c0b", //mobilesdk_app_id
          messagingSenderId: "895275453906", //project_number
          projectId: "attendance-app-718fe" //project_id
          ));
}
