import 'package:crypto_cs/core/model/word_array.dart' show WordArray;
import 'package:crypto_cs/crypto_cs.dart' show Base64, Utf8;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Base64 Encoding Tests', () {
    test('Base64 stringify test', () {
      // Test input
      WordArray wordArray = Utf8.parse("Hello, world!");

      // Expected Base64 output
      String expectedBase64 = "SGVsbG8sIHdvcmxkIQ==";

      // Call the method and verify the result
      expect(Base64.stringify(wordArray), expectedBase64);
    });
  });
}
