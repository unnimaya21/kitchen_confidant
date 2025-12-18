import 'package:kitchen_confidant/domain/entities/pantry_item.dart';

abstract class PantryRepository {
  Future<List<PantryItem>> getPantry();
  Future<void> addItem(String name);
  Future<void> sendItemsToApi(List<String> items);
}
