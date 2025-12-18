import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitchen_confidant/core/constants/string_constants.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
      BaseOptions(
        baseUrl: baseUrl, // Use 10.0.2.2 for Android Emulator to hit localhost
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
    ); // Useful for debugging!
});
