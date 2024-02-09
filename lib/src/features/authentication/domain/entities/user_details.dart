import 'dart:io';

import 'package:equatable/equatable.dart';

class UserDetailsEntity extends Equatable {
  final String email;
  final String password;
  final String completeName;
  final String fcmToken;
  final File photo;

  const UserDetailsEntity({
    required this.email,
    required this.password,
    required this.completeName,
    required this.fcmToken,
    required this.photo,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        completeName,
        fcmToken,
        photo,
      ];
}
