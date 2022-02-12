import 'package:flutter/cupertino.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  late double latitude;
  late double longitude;
  bool permissionAllowed = false;
  var selectedAddress;
  Future<void> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // ignore: unnecessary_null_comparison
    if (position != null) {
      this.latitude = position.latitude;
      this.longitude = position.longitude;
      this.permissionAllowed = true;
      notifyListeners();
    } else {
      print('Permission not allowed');
    }
  }

  void onCameraMove(CameraPosition cameraPosition) async {
    this.latitude = cameraPosition.target.latitude;
    this.longitude = cameraPosition.target.longitude;
    notifyListeners();
  }

  Future<void> getMoveCamera() async {
    final coordinates = new Coordinates(this.latitude, this.longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    this.selectedAddress = addresses.first;
    print("${selectedAddress.featureName} : ${selectedAddress.addressLine}");
  }
}
