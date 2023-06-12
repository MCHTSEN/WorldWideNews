// ignore_for_file: public_member_api_docs, sort_constructors_first
class FirebaseCustomException implements Exception {
  final String message;
  FirebaseCustomException({
    required this.message,
  });

  @override
  String toString() => '$this $message';
}
