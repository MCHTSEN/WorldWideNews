import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseColletions {
  news,
  category,
  version;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
