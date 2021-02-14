import 'package:authentication_x/models/user.dart';

abstract class AuthDataSource {
  Future<void> login(String email, String password);
  Future<String> signup(String username, String email, String password);
  Future<void> createUserInDatabase(User user);
  Future<void> updateUserData(User user);
  Future<bool> isLogedIn();
  Future<void> logOut();
  Future deleteUser();
  Stream<User> get userData;
}
