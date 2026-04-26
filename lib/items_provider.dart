import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemsProvider = StreamProvider<List<String>>((ref) {
  return FirebaseFirestore.instance.collection('items').snapshots().map((
    snapshot,
  ) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return (data['text'] as String?) ?? '';
    }).toList();
  });
});
