// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/product/enums/cache_items.dart';

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  AuthenticationNotifier() : super(const AuthenticationState());

  Future<void> fetchUserDetails(User? user) async {
    if (user == null) return;
    final token = await user.getIdToken();
    await saveTokenToCache(token);
    state = state.copyWith(isRedirect: true);
  }

  Future<void> saveTokenToCache(String token) async {
    await CacheItems.token.write(token);
  }
}

class AuthenticationState extends Equatable {
  const AuthenticationState({this.isRedirect = false});

  final bool isRedirect;

  @override
  // TODO: implement props
  List<Object> get props => [isRedirect];

  AuthenticationState copyWith({
    bool? isRedirect,
  }) {
    return AuthenticationState(
      isRedirect: isRedirect ?? this.isRedirect,
    );
  }
}
