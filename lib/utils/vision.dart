import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class Vision {
  // biar gak sembarangan dipake
  // syntax untuk ngebuat class kita itu safe
  Vision._();

  static final Vision instance = Vision._();

  FaceDetector faceDetector([FaceDetectorOptions? option]) {
    return FaceDetector(options: option ?? FaceDetectorOptions());
  }
}
