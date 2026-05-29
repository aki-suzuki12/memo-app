import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Future<List<Map<String, dynamic>>> fetchCafe(double lat, double lon) async {
  final query =
      """
[out:json];
(
  node(around:5000,$lat,$lon)["name"~"Starbucks|スターバックス|コメダ"];
  way(around:5000,$lat,$lon)["name"~"Starbucks|スターバックス|コメダ"];
);
out center;
""";

  final response = await http.post(
    Uri.parse('https://overpass-api.de/api/interpreter'),
    body: query,
  );

  final data = jsonDecode(response.body);

  List<Map<String, dynamic>> cafes = [];

  for (final item in data['elements']) {
    cafes.add({
      'name': item['tags']['name'],
      'lat': item['type'] == 'node' ? item['lat'] : item['center']['lat'],
      'lon': item['type'] == 'node' ? item['lon'] : item['center']['lon'],
    });
  }

  return cafes;
}
