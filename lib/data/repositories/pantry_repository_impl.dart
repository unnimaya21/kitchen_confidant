import 'package:dio/dio.dart';
import 'package:kitchen_confidant/core/services/error_service.dart';
import 'package:kitchen_confidant/data/models/pantry_model.dart';
import 'package:kitchen_confidant/domain/entities/pantry_item.dart';
import 'package:kitchen_confidant/domain/repositories/pantry_repository.dart';

class PantryRepositoryImpl implements PantryRepository {
  final Dio _dio;

  PantryRepositoryImpl(this._dio);

  @override
  Future<List<PantryItem>> getPantry() async {
    try {
      final response = await _dio.get('/api/users');

      // Dio returns the parsed Map/List directly in response.data
      final List data = response.data;
      if (response.statusCode! < 400) {
        return data.map((item) => PantryModel.fromJson(item)).toList();
      } else {
        return <PantryModel>[];
      }
    } on DioException catch (error) {
      String message = "Something went wrong!";

      message = error.response?.data['message'] ?? error.message ?? message;
      ErrorService.showError(message);
      // Handle specific Dio errors (timeout, 404, etc.)
      throw Exception('Failed to fetch pantry: ${error.message}');
    }
  }

  @override
  Future<void> addItem(String name) async {
    await _dio.post('/api/pantry', data: {'name': name});
  }

  @override
  Future<void> sendItemsToApi(List<String> items) async {
    print(
      '====implementation objects being sent to API: $items  \n===\n----\n0000',
    );
    try {
      final response = await _dio.post(
        '/pantry/addItemsToPantry',
        data: {'items': items},
      );
      print('******++++++======$response');
      ErrorService.showError(response.statusMessage!);
      // if (response.statusCode == 200) {
      //   print('Items successfully sent to the API.');
      // } else {
      //   print('Failed to send items. Status code: ${response.statusCode}');
      // }
    } catch (error) {
      print('=====Error sending items to the API: $error');
      String message = "Something went wrong!";
      if (error is DioException) {
        message = error.response?.data['message'] ?? error.message ?? message;
      } else {
        message = error.toString();
      }
      ErrorService.showError(message);
    }
  }
}
