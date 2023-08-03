import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/features/auth/authentication_provider.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {
  @override
  void initState() {
    checkUserLoggedIn(FirebaseAuth.instance.currentUser);
    super.initState();
  }

  void checkUserLoggedIn(User? user) {
    ref.read(authProvider.notifier).fetchUserDetails(user);
  }

  final authProvider =
      StateNotifierProvider<AuthenticationNotifier, AuthenticationState>((ref) {
    return AuthenticationNotifier();
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FirebaseUIActions(
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                if (state.user != null) {
                  print('logged in');
                  checkUserLoggedIn(state.user);
                }
              })
            ],
            child: LoginView(
              action: AuthAction.signIn,
              providers: FirebaseUIAuth.providersFor(FirebaseAuth.instance.app),
            ),
          ),
          if (ref.read(authProvider).isRedirect)
            TextButton(onPressed: () {}, child: const Text('Continue to app'))
          else
            const Placeholder(),
        ],
      ),
    );
  }
}
