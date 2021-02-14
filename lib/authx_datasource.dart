import 'package:authentication_x/models/user.dart';

abstract class AuthDataSource {
  Future<void> login(String email, String password);
  Future<String> signup(String username, String email, String password);
  Future<void> createUserInDatabase(UserAuth user);
  Future<void> updateUserData(UserAuth user);
  Future<bool> isLogedIn();
  Future<void> logOut();
  Future deleteUser();
  Stream<UserAuth> get userData;
}
