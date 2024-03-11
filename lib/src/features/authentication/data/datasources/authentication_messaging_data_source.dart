import 'package:firebase_messaging/firebase_messaging.dart';

abstract interface class AuthenticationMessagingDataSource {
  Future<void> init();
  Future<String?> getFcmToken();
}

class AuthenticationMessagingDataSourceImpl
    implements AuthenticationMessagingDataSource {
  final FirebaseMessaging _messagingInstance;

  AuthenticationMessagingDataSourceImpl(this._messagingInstance);

  @override
  Future<void> init() async {
    final settings = await _messagingInstance.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      await _messagingInstance.requestPermission();
    }
  }

  @override
  Future<String?> getFcmToken() async {
    final String? token = await _messagingInstance.getToken();
    return token;
  }
}
