import 'dart:convert';

import 'package:flutter/foundation.dart';

class MD5 {
  static const List<int> _initialValues = [0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476];

  static const List<int> _s = [
    7,
    12,
    17,
    22,
    7,
    12,
    17,
    22,
    7,
    12,
    17,
    22,
    7,
    12,
    17,
    22,
    5,
    9,
    14,
    20,
    5,
    9,
    14,
    20,
    5,
    9,
    14,
    20,
    5,
    9,
    14,
    20,
    4,
    11,
    16,
    23,
    4,
    11,
    16,
    23,
    4,
    11,
    16,
    23,
    4,
    11,
    16,
    23,
    6,
    10,
    15,
    21,
    6,
    10,
    15,
    21,
    6,
    10,
    15,
    21,
    6,
    10,
    15,
    21,
  ];

  static final List<int> _t = List<int>.generate(64, (i) => (4294967296 * (i + 1).abs()).floor());

  static List<int> _toBytes(String input) {
    return utf8.encode(input);
  }

  static Uint8List _padMessage(List<int> message) {
    int originalLength = message.length;
    int bitLength = originalLength * 8;

    List<int> padded = List.from(message)..add(0x80);
    while ((padded.length + 8) % 64 != 0) {
      padded.add(0x00);
    }

    padded.addAll(List.generate(8, (i) => (bitLength >> (8 * i)) & 0xFF));

    return Uint8List.fromList(padded);
  }

  static int _leftRotate(int x, int c) {
    return ((x << c) | (x >> (32 - c))) & 0xFFFFFFFF;
  }

  static String hash(String input) {
    List<int> message = _toBytes(input);
    Uint8List paddedMessage = _padMessage(message);

    int a = _initialValues[0];
    int b = _initialValues[1];
    int c = _initialValues[2];
    int d = _initialValues[3];

    for (int i = 0; i < paddedMessage.length; i += 64) {
      List<int> chunk = paddedMessage.sublist(i, i + 64);
      List<int> m = List.generate(16, (j) => chunk.sublist(j * 4, (j + 1) * 4).fold(0, (prev, byte) => prev | (byte << (8 * (j % 4)))));

      int aa = a, bb = b, cc = c, dd = d;

      for (int j = 0; j < 64; j++) {
        int f, g;
        if (j < 16) {
          f = (b & c) | (~b & d);
          g = j;
        } else if (j < 32) {
          f = (d & b) | (~d & c);
          g = (5 * j + 1) % 16;
        } else if (j < 48) {
          f = b ^ c ^ d;
          g = (3 * j + 5) % 16;
        } else {
          f = c ^ (b | ~d);
          g = (7 * j) % 16;
        }

        int temp = d;
        d = c;
        c = b;
        b = b + _leftRotate((a + f + _t[j] + m[g]) & 0xFFFFFFFF, _s[j]);
        a = temp;
      }

      a = (a + aa) & 0xFFFFFFFF;
      b = (b + bb) & 0xFFFFFFFF;
      c = (c + cc) & 0xFFFFFFFF;
      d = (d + dd) & 0xFFFFFFFF;
    }

    return [a, b, c, d].map((e) => e.toRadixString(16).padLeft(8, '0')).join();
  }
}
