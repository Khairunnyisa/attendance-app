import 'package:attendance_app/ui/permission/components/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ErrorHandler {
  static void handleError(BuildContext context, dynamic error) {
    if (error is PermissionDeniedException) {
      SnackBarComponent.showSnackBar(context, "Permission Denied",
          isError: true);
    } else {
      SnackBarComponent.showSnackBar(context, error, isError: true);
    }
    Navigator.of(context).pop();
  }
}


// menginplementasi yang ada di exception class
class PermissionDeniedException implements Exception {
  final String message;
  // proses pembuatan placeholder dari sebuah exception/error
  PermissionDeniedException([this.message = '']);

  @override
  String toString() => message.isEmpty ? "Permission Denied" : message;
}
