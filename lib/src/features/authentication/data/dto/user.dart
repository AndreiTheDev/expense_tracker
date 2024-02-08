import '../../domain/entities/user.dart';

class UserDto extends UserEntity {
  const UserDto({
    required super.uid,
    required super.email,
    required super.fcmToken,
    required super.completeName,
    required super.photoUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      uid: json['uid'],
      email: json['email'],
      fcmToken: json['fcmToken'],
      completeName: json['completeName'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'fcmToken': fcmToken,
      'completeName': completeName,
      'photoUrl': photoUrl,
    };
  }
}
