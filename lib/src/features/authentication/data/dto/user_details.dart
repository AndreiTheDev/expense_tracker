import '../../domain/entities/user_details.dart';

class UserDetailsDto extends UserDetailsEntity {
  const UserDetailsDto({
    required super.email,
    required super.completeName,
    required super.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'completeName': completeName,
      'fcmToken': fcmToken,
    };
  }
}
