import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  LatLng? currentLocation;

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      currentLocation = LatLng(
        position.latitude,
        position.longitude,
      );
    });
  }

  @override
Widget build(BuildContext context) {
  if (currentLocation == null) {
    return Center(
      child: ElevatedButton(
        onPressed: getLocation,
        child: const Text('現在地取得'),
      ),
    );
  }

  return FlutterMap(
    options: MapOptions(
      initialCenter: currentLocation!,
      initialZoom: 15,
    ),
    children: [
      TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.suzukiaki.clean_test2',
        ),

      MarkerLayer(
        markers: [
          Marker(
            point: currentLocation!,
            width: 80,
            height: 80,
            child: const Icon(
              Icons.location_pin,
              size: 40,
            ),
          ),
        ],
      ),
    ],
  );
}
}