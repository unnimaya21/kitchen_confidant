import 'package:kitchen_confidant/data/models/user_model.dart';

abstract class AuthRepository {
  // Future<List<User>> getPantry();
  Future<User> login(String email, String password);
  Future<User> signUp(User user);
  Future<void> forgotPassword(String email);
}
