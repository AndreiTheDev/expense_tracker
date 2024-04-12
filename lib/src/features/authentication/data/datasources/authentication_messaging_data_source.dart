import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

import '../../../../core/utils/logger.dart';

abstract interface class AuthenticationMessagingDataSource {
  Future<void> init();
  Future<String?> getFcmToken();
}

class AuthenticationMessagingDataSourceImpl
    implements AuthenticationMessagingDataSource {
  final FirebaseMessaging _messagingInstance;
  final Logger _logger = getLogger(AuthenticationMessagingDataSourceImpl);

  AuthenticationMessagingDataSourceImpl(this._messagingInstance);

  @override
  Future<void> init() async {
    _logger.d('init - called');
    final settings = await _messagingInstance.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      await _messagingInstance.requestPermission();
    }
  }

  @override
  Future<String?> getFcmToken() async {
    _logger.d('getFcmToken - called');
    final String? token = await _messagingInstance.getToken();
    return token;
  }
}
