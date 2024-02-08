import 'package:equatable/equatable.dart';

class UserDetailsEntity extends Equatable {
  final String email;
  final String completeName;
  final String fcmToken;

  const UserDetailsEntity({
    required this.email,
    required this.completeName,
    required this.fcmToken,
  });

  @override
  List<Object?> get props => [
        email,
        completeName,
        fcmToken,
      ];
}
