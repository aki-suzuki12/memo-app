import 'package:flutter/material.dart';
import 'package:clean_test2/banner_service.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final shouldShow = await shouldShowBanner();

      if (shouldShow) {
        Future.delayed(const Duration(milliseconds: 500), () {
          showMyBottomSheet(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('次のページ')),
      body: const Center(child: Text('Next Page')),
    );
  }
}



