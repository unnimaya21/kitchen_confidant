import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitchen_confidant/presentation/auth/intro_login_page.dart';
import 'package:kitchen_confidant/presentation/pages/entrypoint/entrypoint_ui.dart';
import 'package:kitchen_confidant/presentation/providers/auth_provider.dart';

class KitchenConfidant extends ConsumerWidget {
  const KitchenConfidant({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) =>
          Scaffold(body: Center(child: Text('Error loading token: $err'))),
      data: (token) {
        debugPrint('===== Navigation Check: Token is "$token"');

        if (token.isEmpty) {
          return const IntroLoginPage();
        } else {
          return const EntryPointUI();
        }
      },
    );
  }
}
