import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'next_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'items_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final checkboxProvider = StateProvider<bool>((ref) => false);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

            // 👇 ここが重要（Firestore表示）
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
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('エラー: $e')),
              ),
            ),

            const SizedBox(height: 8),

        ElevatedButton(
         child: Text('次へ'),
          onPressed: () {
            // ここにボタンを押した時に呼ばれるコードを書く
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NextPage()),
            );
          },
        ),
          ],
        ),
      ),

      // 👇 Firestore保存
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