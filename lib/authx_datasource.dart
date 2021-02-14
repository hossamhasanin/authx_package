abstract class AuthDataSource<T> {
  Future<void> login(String email, String password);
  Future<String> signup(String username, String email, String password);
  Future<void> createUserInDatabase(T user);
  Future<void> updateUserData(T user);
  Future<bool> isLogedIn();
  Future<void> logOut();
  Future deleteUser();
  Stream<T> get userData;
}
