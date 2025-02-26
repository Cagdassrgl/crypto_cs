import 'package:crypto_cs/crypto_cs.dart' show MD5;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MD5 Hashing Tests', () {
    test('MD5 hash test', () {
      // Test input
      String input = "Hello, world!";

      // Expected MD5 hash
      String expectedHash = "8fd7234ef2e7b519d0e353879de0af50";

      // Call the method and verify the result
      expect(MD5.hash(input), expectedHash);
    });
  });
}
