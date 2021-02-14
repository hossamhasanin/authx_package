import 'package:authentication_x/authx_datasource.dart';

class AuthUseCase {
  AuthDataSource _dataSource;
  AuthUseCase({AuthDataSource dataSource}) : this._dataSource = dataSource;

  Future login(String email, String password) {
    return _dataSource.login(email, password);
  }

  Future signup(String email, String password, String username) {
    return _dataSource.signup(username, email, password);
  }

  Future logout() {
    return _dataSource.logOut();
  }

  Future isLoggedIn() {
    return _dataSource.isLogedIn();
  }

  Future deleteUser() {
    return _dataSource.deleteUser();
  }

  Stream get user => _dataSource.userData;
}
