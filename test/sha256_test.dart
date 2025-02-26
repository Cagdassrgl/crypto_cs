import 'dart:typed_data' show Uint8List;

import 'package:crypto_cs/crypto_cs.dart' show SHA256;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SHA-256 Hashing Tests', () {
    test('SHA-256 hash test', () {
      // Test input
      String input = "Hello, world!";

      // Expected SHA-256 hash in hexadecimal format
      String expectedHashHex = "315f5bdb76d078c43b8ac0064e4a0164612b1fce77c869345bfc94c75894edd3";

      // Compute the hash
      Uint8List hashResult = SHA256.hash(input);

      // Convert to hex string
      String computedHashHex = hashResult.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

      // Verify the result
      expect(computedHashHex, expectedHashHex);
    });
  });
}
