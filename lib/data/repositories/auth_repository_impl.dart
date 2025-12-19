import 'package:dio/dio.dart';
import 'package:kitchen_confidant/core/constants/storage_constants.dart';
import 'package:kitchen_confidant/core/services/error_service.dart';
import 'package:kitchen_confidant/core/utils/shared_pref_service.dart';
import 'package:kitchen_confidant/data/models/user_model.dart';
import 'package:kitchen_confidant/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final SharedPrefService _sharedPrefService = SharedPrefService();

  AuthRepositoryImpl(this._dio);
  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      print('=====response from signup: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final token =
            response.data['token']; // Assuming the token is in the response

        // Store the token using SharedPrefService
        await _sharedPrefService.saveString(StorageConstants.appToken, token);
        await _sharedPrefService.saveUser(User.fromJson(response.data['user']));

        return User.fromJson(
          response.data['user'],
        ); // Adjust according to your API response structure
      } else {
        throw Exception('Failed to sign up: ${response.statusMessage}');
      }
    } on DioException catch (error) {
      String message = "Something went wrong!";

      message = error.response?.data['message'] ?? error.message ?? message;
      ErrorService.showError(message);
      // Handle specific Dio errors (timeout, 404, etc.)
      throw Exception('Failed to sign up: ${error.message}');
    }
  }

  @override
  Future<User> signUp(User user) async {
    try {
      final response = await _dio.post('/auth/signup', data: user.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('=====response from signup: ${response.data}');
        final token =
            response.data['token']; // Assuming the token is in the response
        // Store the token using SharedPrefService
        await _sharedPrefService.saveString(StorageConstants.appToken, token);
        await _sharedPrefService.saveUser(User.fromJson(response.data['user']));

        return User.fromJson(response.data['user']);
      } else {
        throw Exception('Failed to sign up: ${response.statusMessage}');
      }
    } on DioException catch (error) {
      String message = "Something went wrong!";

      message = error.response?.data['message'] ?? error.message ?? message;
      ErrorService.showError(message);
      // Handle specific Dio errors (timeout, 404, etc.)
      throw Exception('Failed to sign up: ${error.message}');
    }
  }
}
