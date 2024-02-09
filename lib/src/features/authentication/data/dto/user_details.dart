import '../../domain/entities/user_details.dart';

class UserDetailsDto extends UserDetailsEntity {
  const UserDetailsDto({
    required super.email,
    required super.completeName,
    required super.fcmToken,
    required super.password,
    required super.photo,
  });

  factory UserDetailsDto.fromEntity(final UserDetailsEntity entity) {
    return UserDetailsDto(
      email: entity.email,
      completeName: entity.completeName,
      fcmToken: entity.fcmToken,
      password: entity.password,
      photo: entity.photo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'completeName': completeName,
      'fcmToken': fcmToken,
    };
  }
}
