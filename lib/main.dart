import 'package:attendance_app/ui/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// yg di compile pertama adalah inisialisasi awal
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
  runApp(const AttendaceApp());
}

class AttendaceApp extends StatelessWidget {
  const AttendaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          cardTheme: CardTheme(surfaceTintColor: Colors.white),
          dialogTheme: DialogTheme(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)),
      home: HomeScreen(),
    );
  }
}
