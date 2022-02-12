import 'package:flutter/material.dart';
import 'package:flutter_web_a2hs/providers/location_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  // MapScreen({Key? key}) : super(key: key);
  static const String id = "map-screen";

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng currentLocation;
  // ignore: unused_field
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);
    setState(() {
      currentLocation = LatLng(locationData.latitude, locationData.longitude);
    });

    void onCreated(GoogleMapController controller) {
      setState(() {
        _mapController = controller;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 14.4746,
              ),
              zoomControlsEnabled: true,
              minMaxZoomPreference: MinMaxZoomPreference(1.5, 20.8),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.hybrid,
              mapToolbarEnabled: true,
              onCameraMove: (CameraPosition position) {
                locationData.onCameraMove(position);
              },
              onMapCreated: onCreated,
              onCameraIdle: () {
                locationData.getMoveCamera();
              },
            ),
          ],
        ),
      ),
    );
  }
}
