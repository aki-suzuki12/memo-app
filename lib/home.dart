import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'next_page.dart';
import 'items_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final checkboxProvider = StateProvider<bool>((ref) => false);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    setupFCM();
  }

  Future<void> setupFCM() async {
    await FirebaseMessaging.instance.requestPermission();

    await FirebaseMessaging.instance.subscribeToTopic("all");
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(itemsProvider);
    final isChecked = ref.watch(checkboxProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('あきアプリ開発')),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CheckboxListTile(
              value: isChecked,
              title: const Text('チェック'),
              onChanged: (value) {
                ref.read(checkboxProvider.notifier).state = value!;
              },
            ),

            const SizedBox(height: 8),

            Expanded(
              child: itemsAsync.when(
                data: (items) {
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(items[index]),
                        subtitle: const Text('Firestoreデータ'),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('エラー: $e')),
              ),
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              child: const Text('次へ'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseFirestore.instance.collection('items').add({
            'text': 'ListTile ${DateTime.now()}',
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
