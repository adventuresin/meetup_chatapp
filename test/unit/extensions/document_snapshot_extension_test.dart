// Import the test package and Counter class
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/test.dart';
import 'package:adventures_in_chat_app/extensions/extensions.dart';
import '../../mocks/document_snapshot_mocks.dart';

void main() {
  group('toMessage()', () {
    test(
        'toMessage will return valid DateTime when valid Timestamp in database',
        () {
      var fake = FakeMessageDocumentSnapshot('123455679', 'Test Message',
          Timestamp.fromDate(DateTime.parse('1969-07-20 20:18:04')));
      var message = fake.toMessage();

      expect(message.timestamp, DateTime.parse('1969-07-20 20:18:04'));
    });

    test('toMessage will return current DateTime when in null Timestamp', () {
      var fake = FakeMessageDocumentSnapshot('123455679', 'Test Message', null);
      var before = DateTime.now();
      var message = fake.toMessage();
      var after = DateTime.now();

      expect(
          true,
          message.timestamp.isAfter(before) &&
              message.timestamp.isBefore(after));
    });
  });

  group('toUserItem()', () {
    test('toUserItem will have empty displayName and photoURL if not populated',
        () {
      var fake = FakeUserItemDocumentSnapshot.nullData();
      var userItem = fake.toUserItem();

      expect(userItem.displayName, null);
      expect(userItem.photoURL, null);
    });

    test('toUserItem will have displayName and photoURL', () {
      var fake =
          FakeUserItemDocumentSnapshot('leon', 'https://example.com/leon.png');
      var userItem = fake.toUserItem();

      expect(userItem.displayName, 'leon');
      expect(userItem.photoURL, 'https://example.com/leon.png');
    });
  });
}
