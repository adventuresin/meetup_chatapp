import 'package:adventures_in_chat_app/conversations_page.dart';
import 'package:adventures_in_chat_app/models/conversation_item.dart';
import 'package:adventures_in_chat_app/services/database_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'chat_page_test.dart';
import 'mocks/database_mocks.dart';

void main() {
  group('ConversationsList', () {
    testWidgets('preexisting conversationId, uids, displaynames and photoURLs',
        (WidgetTester tester) async {
      final fake = FakeDatabase();
      final db = DatabaseService(database: fake);

      await tester.pumpWidget(wrapWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (context) => ConversationsViewModel([])),
            Provider<DatabaseService>.value(value: db),
          ],
          child: ConversationsPage(),
        ),
      ));

      fake.add(ConversationItem(conversationId: 'abc123', uids: [
        '123',
        '456'
      ], displayNames: [
        'Leon',
        'Noel'
      ], photoURLs: [
        'https://lh3.googleusercontent.com/a-/AOh14GgcLuTiYf_wdIIMAw5CPaBDQowtVTHczbRV8eZrIQ=s96-c'
            'https://lh3.googleusercontent.com/a-/AOh14GgcLuTiYf_wdIIMAw5CPaBDQowtVTHczbRV8eZrIQ=s96-c',
      ]));

      await tester.pumpAndSettle();

      expect(find.text('Noel'), findsOneWidget);
    });
  });
}