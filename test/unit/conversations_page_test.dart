// Import the test package and Counter class
import 'package:adventures_in_chat_app/models/conversation_item.dart';
import 'package:adventures_in_chat_app/models/conversations_view_model.dart';
import 'package:test/test.dart';

void main() {
  group('ConversationViewModel', () {
    test('.add()', () {
      var inject_list = <ConversationItem>[];
      var vm = ConversationsViewModel(inject_list);
      var instance = ConversationItem(
          conversationId: 'abc123',
          uids: ['123', '456'],
          displayNames: ['Leon', 'Noel'],
          photoURLs: ['https://url1', 'https://url2']);
      vm.add(item: instance);
      expect(inject_list, [instance]);
    });
    test('.populateWith() replaces _items when empty', () {
      var inject_list = <ConversationItem>[];
      var vm = ConversationsViewModel(inject_list); // start with empty list
      var instance = ConversationItem(
          conversationId: 'abc123',
          uids: ['123', '456'],
          displayNames: ['Leon', 'Noel'],
          photoURLs: ['https://url1', 'https://url2']);
      var alternate_list = <ConversationItem>[];
      alternate_list.add(instance);

      vm.populateWith(alternate_list);
      expect(inject_list, alternate_list);
    });

    test('.populateWith() replaces _items when already has items', () {
      var inject_list = <ConversationItem>[];
      var vm = ConversationsViewModel(inject_list); // start with empty list
      var instance = ConversationItem(
          conversationId: 'abc123',
          uids: ['123', '456'],
          displayNames: ['Leon', 'Noel'],
          photoURLs: ['https://url1', 'https://url2']);
      var alternate_list = <ConversationItem>[];
      alternate_list.add(instance);

      vm.populateWith(alternate_list);
      expect(inject_list, alternate_list);

      var second_instance = ConversationItem(
          conversationId: 'def456',
          uids: ['456', '789'],
          displayNames: ['Noel', 'Richard'],
          photoURLs: ['https://url2', 'https://url3']);
      var second_alternative_list = <ConversationItem>[];
      second_alternative_list.add(second_instance);

      vm.populateWith(second_alternative_list);

      // vm will now have the second_alternative_list
      expect(inject_list, second_alternative_list);
    });
  });
}