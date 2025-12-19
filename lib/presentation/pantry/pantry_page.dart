import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitchen_confidant/di/di.dart';
import 'package:kitchen_confidant/presentation/pantry/pantry_scanner.dart';
import 'package:kitchen_confidant/presentation/providers/pantry_provider.dart';

final pantryScannerProvider = Provider<PantryScanner>((ref) {
  final pantryRepository = ref.watch(pantryRepositoryProvider);
  return PantryScanner(pantryRepository);
});

class PantryPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider
    final pantryAsync = ref.watch(pantryListProvider);

    return Scaffold(
      body: pantryAsync.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, i) => ListTile(title: Text(items[i].name)),
        ),
        loading: () => CircularProgressIndicator(),
        error: (e, st) => Text('Something went wrong'),
      ),
    );
  }
}
