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
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  subtitle: const Text('subtitle'),
                );
              },
            ),
          ),

          // 👇 画面遷移ボタンはここ
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NextPage()),
                );
              },
              child: const Text('次の画面へ'),
            ),
          ),
        ],
      ),

      // 👇 追加ボタンはこっち（分離）
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            items.add('ListTile ${items.length}');
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
