import 'package:models/User.dart';

abstract class AuthDataSource {
  Future login(String email, String password);
  Future<String> signup(String username, String email, String password);
  Future<void> createUserInDatabase(User user);
  Future<void> updateUserData(User user);
  Future<void> updateUserProfile(User user);
  Future<void> updateUserEmail(String newEmail);
  bool isLogedIn();
  Future<void> logOut();
  Future deleteUser();
  Stream<User> get userData;
}
