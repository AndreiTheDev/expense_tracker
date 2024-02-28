// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String? fcmToken;
  final String completeName;
  final String photoUrl;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.fcmToken,
    required this.completeName,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [uid, email, fcmToken, completeName, photoUrl];
}
