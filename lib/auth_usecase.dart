import 'package:models/User.dart';

import 'authx_datasource.dart';

class AuthUseCase {
  AuthDataSource _dataSource;
  AuthUseCase({required AuthDataSource dataSource})
      : this._dataSource = dataSource;

  Future login(String email, String password) {
    return _dataSource.login(email, password);
  }

  Future signup(String email, String password, String username) async {
    String uid = await _dataSource.signup(username, email, password);
    User user = User(id: uid, username: username, email: email);
    return _dataSource.createUserInDatabase(user);
  }

  Future logout() {
    return _dataSource.logOut();
  }

  bool isLoggedIn() {
    return _dataSource.isLogedIn();
  }

  Future deleteUser() {
    return _dataSource.deleteUser();
  }

  Stream get user => _dataSource.userData;
}
