import '../../domain/entities/user_signup_details.dart';

class UserSignUpDetailsDto extends UserSignUpDetailsEntity {
  const UserSignUpDetailsDto({
    required super.email,
    required super.completeName,
    required super.password,
    required super.photoUrl,
  });

  factory UserSignUpDetailsDto.fromEntity(
    final UserSignUpDetailsEntity entity,
  ) {
    return UserSignUpDetailsDto(
      email: entity.email,
      completeName: entity.completeName,
      password: entity.password,
      photoUrl: entity.photoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'completeName': completeName,
      'photoUrl': photoUrl,
    };
  }
}
