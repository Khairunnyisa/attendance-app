// satu parameter yg menghandle aksi pas aplikasi nerima posisi
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<void> getGeoLocationPosition(
    BuildContext context, Function(Position) onPositionReceived) async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);
  onPositionReceived(position);
}

Future<void> getAddressFromLangLat(
    Position position, Function(String) onAdressReceived) async {
  // kita ambil address dari informasi yg kita dapet dari placemark
  List<Placemark> placemark =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemark[0];
  String address =
      "${place.street}, ${place.subLocality}, ${place.subLocality}, ${place.country}";
  onAdressReceived(address);
}

Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // kalau gak enable = kebalikannya
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.location_off,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Location services are disabled. Please enable the services.",
            style: TextStyle(),
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    ));
    return false;
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.location_off,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Lccation permission denied",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        backgroundColor: Colors.blueGrey,
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.location_off,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Location permission denied forever, we cannot access",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    ));
  }
  return true;
}
