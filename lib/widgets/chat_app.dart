import 'package:adventures_in_chat_app/widgets/auth/auth_page.dart';
import 'package:adventures_in_chat_app/widgets/messages/chat_page.dart';
import 'package:adventures_in_chat_app/extensions/extensions.dart';
import 'package:adventures_in_chat_app/widgets/home/home_page.dart';
import 'package:adventures_in_chat_app/widgets/auth/link_accounts_page.dart';
import 'package:adventures_in_chat_app/widgets/options/profile_page.dart';
import 'package:adventures_in_chat_app/services/database_service.dart';
import 'package:adventures_in_chat_app/services/fcm_service.dart';
import 'package:adventures_in_chat_app/widgets/splash/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatApp extends StatelessWidget {
  final DatabaseService db = DatabaseService();
  final FCMService fcm = FCMService(FirebaseMessaging());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatabaseService>.value(
          value: db,
        ),
        Provider<FCMService>.value(value: fcm),
      ],
      child: MaterialApp(
        title: 'Adventures In',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (settings) {
          // If we push the ChatPage route
          if (settings.name == ChatPage.routeName) {
            // Cast the arguments to the correct type: ChatPageArgs.
            final args = settings.arguments as ChatPageArgs;

            // Then, extract the required data from the arguments and
            // pass the data to the correct screen.
            return MaterialPageRoute<dynamic>(
              builder: (context) {
                return ChatPage(
                  conversationItem: args.conversationItem,
                  currentUserId: args.currentUserId,
                  db: db,
                );
              },
            );
          }
          return MaterialPageRoute<dynamic>(builder: (context) {
            return Container();
          });
        },
        home: StreamBuilder<FirebaseUser>(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                // set the database service to use the current user
                context.db.currentUserId = snapshot.data.uid;
                return HomePage();
              } else {
                context.db.currentUserId = null;
                return AuthPage();
              }
            }

            return SplashPage();
          },
        ),
        routes: {
          ProfilePage.routeName: (context) => ProfilePage(),
          LinkAccountsPage.routeName: (context) => LinkAccountsPage(),
        },
      ),
    );
  }
}