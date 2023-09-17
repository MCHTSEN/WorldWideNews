import 'package:news_app/product/enums/firebase_collection.dart';
import 'package:news_app/product/utilities/base/base_firebase_model.dart';

mixin FirebaseUtilty {
  Future<List<T>?> fetchList<T extends IdModel, R extends BaseFirebaseModel<T>>(
    FirebaseColletions collection,
    R data,
  ) async {
    final newsCollectionReference = collection.reference;

    final response = await newsCollectionReference
        .withConverter<T>(
          fromFirestore: (snapshot, options) => data.fromFirebase(snapshot),
          toFirestore: (value, options) => {},
        )
        .get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      return values;
    }
    return null;
  }
}
