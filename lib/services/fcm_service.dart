import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging;

  FCMService(FirebaseMessaging firebaseMessaging)
      : _firebaseMessaging = firebaseMessaging {
    if (!Platform.isMacOS) {
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage: $message');
          // _showItemDialog(message);
        },
        // TODO: remove the check for iOS when the plugin has updated
        // Platform.isIOS ? null :
        onBackgroundMessage: backgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          print('onLaunch: $message');
          // _navigateToItemDetail(message);
        },
        onResume: (Map<String, dynamic> message) async {
          print('onResume: $message');
          // _navigateToItemDetail(message);
        },
      );

      _firebaseMessaging.requestNotificationPermissions();

      _firebaseMessaging.getToken().then(print);
    }
  }
}

Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];

    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];

    print(notification);
  }

  return null;
}
