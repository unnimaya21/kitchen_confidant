import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitchen_confidant/di/di.dart';
import 'package:kitchen_confidant/domain/repositories/pantry_repository.dart';
import 'package:kitchen_confidant/presentation/pantry/pantry_scanner.dart';
import 'package:kitchen_confidant/presentation/providers/pantry_provider.dart';

class PantryScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pantryAsync = ref.watch(pantryListProvider);
    final PantryRepository pantryRepository = ref.watch(
      pantryRepositoryProvider,
    );

    return Scaffold(
      appBar: AppBar(title: Text("My Virtual Pantry")),
      body: pantryAsync.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final isExpiring =
                item.expiryDate.difference(DateTime.now()).inDays < 3;

            return ListTile(
              title: Text(item.name),
              subtitle: Text(
                "Expires: ${item.expiryDate.toLocal()}".split(' ')[0],
              ),
              trailing: isExpiring
                  ? Icon(Icons.warning, color: Colors.red)
                  : null,
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Something went wrong!")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showScanner(context, pantryRepository),
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  void _showScanner(BuildContext context, pantryRepository) {
    // Navigate to your Scanner Screen

    PantryScanner(pantryRepository).scanReceipt().then((scannedItems) {
      // After scanning, you can process the scanned items
      // For example, add them to the pantry provider
      // This is just a placeholder for actual implementation
      print("Scanned Items: $scannedItems");
    });
  }
}
