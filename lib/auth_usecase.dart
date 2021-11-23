import 'package:authentication_x/states/user_image_viewstate.dart';
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

  Future<UserImageViewState> upadateUserData(
      UserImageViewState viewState, User user) async {
    try {
      await _dataSource.updateUserData(user);
      return Future.value(
          viewState.copy(user: user, uploading: false, error: ""));
    } catch (e) {
      return Future.value(viewState.copy(
          uploading: false, error: "Error while saving the data"));
    }
  }

  Future<UserImageViewState> updateProfile(
      UserImageViewState viewState, User user) async {
    try {
      await _dataSource.updateUserData(user);
      await _dataSource.updateUserProfile(user);

      return viewState.copy(user: user);
    } catch (e) {
      return viewState.copy(error: "Error while updating the profile");
    }
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

  Stream<User> get user => _dataSource.userData;
}
