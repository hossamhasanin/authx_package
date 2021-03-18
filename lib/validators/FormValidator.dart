import 'ValidationErrors.dart';

class FormValidator {
  final _usernameValidCharacters = RegExp(r'^[a-zA-Z0-9_]+$');
  final _emailValidCharacters = RegExp(r'[a-zA-Z0-9_\.@]');
  final _passwordSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  final _passwordLetters = RegExp(r'[a-zA-Z]');

  EmailErrors? isEmailValid(String? email) {
    if (email == null) {
      return EmailErrors.EmailEmpty;
    }
    if (email.isEmpty) {
      return EmailErrors.EmailEmpty;
    }
    if (!email.contains("@")) {
      return EmailErrors.EmailDoesNotContailAt;
    }

    if (!_emailValidCharacters.hasMatch(email)) {
      return EmailErrors.EmailContainsNotValidChar;
    }
    if (email.length < 5) {
      return EmailErrors.EmailTooShort;
    }
    return null;
  }

  UserNameErrors? isUsernameValid(String? username) {
    if (username == null) {
      return UserNameErrors.UserNameEmpty;
    }
    if (username.isEmpty) {
      return UserNameErrors.UserNameEmpty;
    }
    if (username.length > 25) {
      return UserNameErrors.UserNameTooLong;
    }

    if (!_usernameValidCharacters.hasMatch(username)) {
      return UserNameErrors.UserNameContainsNotValidChar;
    }
    if (username.length < 5) {
      return UserNameErrors.UserNameTooShort;
    }
    return null;
  }

  PassWordErrors? isPasswordValid(String? password) {
    if (password == null) {
      return PassWordErrors.PasswordEmpty;
    }
    if (password.isEmpty) {
      return PassWordErrors.PasswordEmpty;
    }
    if (!password.contains(_passwordSpecialCharacters)) {
      return PassWordErrors.PasswordNotContainsSpecialChar;
    }

    if (!_passwordLetters.hasMatch(password)) {
      return PassWordErrors.PasswordMustContainAtLeastOnLetter;
    }
    if (password.length < 10) {
      return PassWordErrors.PassowrdTooShort;
    }
    return null;
  }
}
