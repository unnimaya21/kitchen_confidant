import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitchen_confidant/data/repositories/pantry_repository_impl.dart';
import 'package:kitchen_confidant/domain/repositories/pantry_repository.dart';
import 'package:kitchen_confidant/core/constants/string_constants.dart';

// Dio Provider
final dioProvider = Provider<Dio>((ref) {
  return Dio(
      BaseOptions(
        baseUrl: baseUrl, // Ensure this is set to your API's base URL
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    )
    ..interceptors.add(
      LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: true,
        request: true,
        requestBody: true,
        responseHeader: true,
      ),
    );
});

// PantryRepository Provider
final pantryRepositoryProvider = Provider<PantryRepository>((ref) {
  final dio = ref.watch(dioProvider); // Get the Dio instance from dioProvider
  return PantryRepositoryImpl(dio);
});
