import 'package:equatable/equatable.dart';

class UserSignUpDetailsEntity extends Equatable {
  final String email;
  final String password;
  final String completeName;
  final String photoUrl;

  const UserSignUpDetailsEntity({
    required this.email,
    required this.password,
    required this.completeName,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        completeName,
        photoUrl,
      ];
}
