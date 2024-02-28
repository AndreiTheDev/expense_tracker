import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_messaging_data_source.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_messaging_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseMessaging>(),
  MockSpec<NotificationSettings>(),
])
void main() {
  late AuthenticationMessagingDataSourceImpl sut;
  late MockFirebaseMessaging mockFirebaseMessaging;
  late MockNotificationSettings mockNotificationSettings;
  setUp(() {
    mockFirebaseMessaging = MockFirebaseMessaging();
    mockNotificationSettings = MockNotificationSettings();
    sut = AuthenticationMessagingDataSourceImpl(mockFirebaseMessaging);
  });

  test('Init function requests user permission for notifications', () async {
    when(mockFirebaseMessaging.getNotificationSettings())
        .thenAnswer((realInvocation) async => mockNotificationSettings);
    when(mockNotificationSettings.authorizationStatus)
        .thenReturn(AuthorizationStatus.notDetermined);
    when(mockFirebaseMessaging.requestPermission())
        .thenAnswer((realInvocation) async => mockNotificationSettings);
    await sut.init();

    verify(mockFirebaseMessaging.getNotificationSettings()).called(1);
    verify(mockFirebaseMessaging.requestPermission()).called(1);
    verify(mockNotificationSettings.authorizationStatus).called(1);
    verifyNoMoreInteractions(mockFirebaseMessaging);
    verifyNoMoreInteractions(mockNotificationSettings);
  });

  test('getFcmToken return the phone FcmToken', () async {
    when(mockFirebaseMessaging.getToken())
        .thenAnswer((realInvocation) async => 'testFcm');

    final response = await sut.getFcmToken();

    expect(response, 'testFcm');

    verify(mockFirebaseMessaging.getToken()).called(1);
    verifyNoMoreInteractions(mockFirebaseMessaging);
  });
}
