import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/product/utilities/exceptions/firebase_custom_exception.dart';

mixin IdModel {
  String? get id;
}

mixin BaseFirebaseModel<T extends IdModel> {
  T fromJson(Map<String, dynamic> json);

  T fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final value = snapshot.data();
    if (value == null) {
      throw FirebaseCustomException(message: '$snapshot is null');
    }
    //FIXME
    value.addEntries([MapEntry('id', snapshot.id)]);
    return fromJson(value);
  }
}
