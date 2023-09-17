import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'package:news_app/features/auth/authentication_provider.dart';
import 'package:news_app/features/home/home_view.dart';
import 'package:news_app/product/constants/app_strings.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Header(context),
          _empty(),
          _AuthView(),
        ],
      ),
    );
  }

  SizedBox _empty() {
    return const SizedBox(
      height: 50,
    );
  }

  Padding _AuthView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: FirebaseUIActions(
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            if (state.user != null) {
              checkUserLoggedIn(state.user);
              context.navigateToPage(const HomeView());
            }
          })
        ],
        child: Column(
          children: [
            LoginView(
              action: AuthAction.signIn,
              providers: FirebaseUIAuth.providersFor(FirebaseAuth.instance.app),
            ),
            if (ref.read(authProvider).isRedirect)
              TextButton(
                onPressed: () {},
                child: const Text('Continue to app'),
              )
          ],
        ),
      ),
    );
  }

  Column _Header(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.loginWelcome,
          style: context.textTheme.headlineMedium,
        ),
        Text(
          AppStrings.loginWelcomeDetail,
          style: context.textTheme.bodyLarge,
        ),
      ],
    );
  }
}
