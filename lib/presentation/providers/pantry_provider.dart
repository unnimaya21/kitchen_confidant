import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitchen_confidant/domain/entities/pantry_item.dart';
import 'package:kitchen_confidant/di/di.dart'; // Import the DI file

final pantryListProvider = FutureProvider<List<PantryItem>>((ref) async {
  return ref.watch(pantryRepositoryProvider).getPantry();
});
