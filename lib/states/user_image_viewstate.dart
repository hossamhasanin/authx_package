import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:models/User.dart';

class UserImageViewState extends Equatable {
  final User? user;
  final bool uploading;
  final File? pickedImage;
  final String error;

  UserImageViewState(
      {this.user,
      this.pickedImage,
      required this.uploading,
      required this.error});

  @override
  List<Object?> get props => [user, uploading, pickedImage, error];

  UserImageViewState copy({
    User? user,
    bool? uploading,
    File? pickedImage,
    String? error,
  }) {
    return UserImageViewState(
        user: user ?? this.user,
        uploading: uploading ?? this.uploading,
        pickedImage: pickedImage ?? this.pickedImage,
        error: error ?? this.error);
  }
}
