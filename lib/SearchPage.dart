import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String locationText = '位置情報を取得してください';

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // GPS有効確認
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      setState(() {
        locationText = 'GPSがOFFです';
      });
      return;
    }

    // 権限確認
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationText = '位置情報権限が拒否されています';
      });
      return;
    }

    // 現在地取得
    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      locationText = '緯度: ${position.latitude}\n経度: ${position.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(locationText),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: getLocation, child: const Text('現在地取得')),
          ],
        ),
      ),
    );
  }
}
