import '../../domain/entities/pantry_item.dart';

class PantryModel extends PantryItem {
  PantryModel({
    required String id,
    required String name,
    required DateTime expiry,
  }) : super(id: id, name: name, expiryDate: expiry);

  factory PantryModel.fromJson(Map<String, dynamic> json) {
    return PantryModel(
      id: json['_id'],
      name: json['name'],
      expiry: DateTime.parse(json['expiryDate']),
    );
  }
}
