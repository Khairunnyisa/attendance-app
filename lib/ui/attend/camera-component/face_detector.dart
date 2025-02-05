import 'dart:math';

import 'package:attendance_app/utils/google_ml_kit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorComponent{
  final FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
    enableTracking: true,
    enableLandmarks: true,
  ));

  Future<void> detectFaces(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final faces = await faceDetector.processImage(inputImage);

    // kaalu misalkan face nya terdeteksi
    for (Face face in faces) {
      // boundingbox: untuk ngambil component dari gambar
      // Rect: agar proses absensi tidak bisa ditipu
      final Rect boundingBox = face.boundingBox;

      // untuk menghandle posisi wajah secara vertical
      final double? verticalPosition = face.headEulerAngleY;

      // untuk menghandle posisi wajah secara horizontal
      final double? horizontalProsition = face.headEulerAngleZ;

      // perkondisian apabile face landmark sudah aktif, ditantai oleh (mulut, mata, pipi, dan hidung, telinga)
      final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar];
      // kalau telinga kiri nya terdeteksi, dia akan mereturn posisi telinga tersebut, yg dikembalikan adalah titik koordinat nya
      if (leftEar != null ) {
        final Point<int> leftEarPosition = leftEar.position;
        print("Left Ear Position: $leftEarPosition");
        
      }

      // perkondisian apabila wajahnya terdeteksi (ditandai dengan bibir tersenyum)
      if (face.smilingProbability != null) {
        final double? smileProbability = face.smilingProbability;
        print("Smile Probability: $smileProbability");
        
      }
      // perkondisian apabila fitur tracking wajah sudah aktif
      if (face.trackingId != null) {
        final int? trackingId = face.trackingId;
        print('Tracking ID $trackingId');
        
      }
      
      
    }
  }
}