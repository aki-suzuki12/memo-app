import 'package:flutter/material.dart';
import 'next_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isChecked = false;

  // ← ここ追加
  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('あきアプリ開発')),
      body: Column(
        children: [
          // チェックボックス
          CheckboxListTile(
            value: isChecked,
            title: const Text('チェック'),
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),

          Expanded(
            child: Stack(
              children: [
                // リスト
                ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: items.length, // ← ここ変更
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index]), // ← ここ変更
                      subtitle: const Text('subtitle'),
                    );
                  },
                ),

                // 右下ボタン（追加ボタンに変更）
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          items.add('ListTile ${items.length}');
                        });
                      },
                      child: const Text('追加'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
