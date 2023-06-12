import 'package:cloud_firestore/cloud_firestore.dart';

mixin IdModel {
  String? get id;
}

mixin  BaseFirebaseModel<T extends IdModel> {
  T fromJson(Map<String, dynamic> json);

  T? fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final value = snapshot.data();
    if (value == null) return null;
    //FIXME
    value.addEntries([MapEntry('id', snapshot.id)]);
    return fromJson(value);
  }
}
