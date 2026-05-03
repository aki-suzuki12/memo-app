import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showMyBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        color: Colors.blue[200],
        child: const Center(child: Text("BottomSheet")),
      );
    },
  );
}

Future<bool> shouldShowBanner() async {
  final prefs = await SharedPreferences.getInstance();
  final isShown = prefs.getBool('isBannerShown') ?? false;

  if (!isShown) {
    await prefs.setBool('isBannerShown', true);
    return true;
  }
  return false;
}
