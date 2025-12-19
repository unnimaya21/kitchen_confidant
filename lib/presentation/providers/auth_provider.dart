import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitchen_confidant/core/constants/storage_constants.dart';
import 'package:kitchen_confidant/core/utils/shared_pref_service.dart';
import 'package:kitchen_confidant/data/repositories/auth_repository_impl.dart';
import 'package:kitchen_confidant/domain/repositories/auth_repository.dart';
import 'package:kitchen_confidant/core/network/dio_client.dart';
import 'package:kitchen_confidant/data/models/user_model.dart';

// AuthRepository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider); // Get Dio instance from dioProvider
  return AuthRepositoryImpl(dio);
});

// SignUp Provider
final signUpProvider = FutureProvider.family<User, User>((ref, user) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.signUp(user);
});

// Login Provider
final loginProvider = FutureProvider.family<User, Map<String, String>>((
  ref,
  credentials,
) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.login(credentials['email']!, credentials['password']!);
});

// Forgot Password Provider
final forgotPasswordProvider = FutureProvider.family<void, String>((
  ref,
  email,
) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.forgotPassword(email);
});
final authStateProvider = FutureProvider<String>((ref) async {
  final service = SharedPrefService();
  final token = await service.getString(StorageConstants.appToken);

  // Logic check: if null or empty, return empty string
  if (token == null || token.isEmpty) {
    return '';
  }
  return token;
});
final userProvider = FutureProvider<User?>((ref) async {
  final sharedPrefService = SharedPrefService();
  return await sharedPrefService.getUser();
});
