import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';

class SHA256 {
  static final List<int> _H = _computeH();
  static final List<int> _K = _computeK();

  static List<int> _computeH() {
    List<int> H = [];
    int n = 2, nPrime = 0;
    while (nPrime < 8) {
      if (_isPrime(n)) {
        H.add(_fractionalBits(pow(n, 1 / 2).toDouble()));
        nPrime++;
      }
      n++;
    }
    return H;
  }

  static List<int> _computeK() {
    List<int> K = [];
    int n = 2, nPrime = 0;
    while (nPrime < 64) {
      if (_isPrime(n)) {
        K.add(_fractionalBits(pow(n, 1 / 3).toDouble()));
        nPrime++;
      }
      n++;
    }
    return K;
  }

  static bool _isPrime(int n) {
    if (n < 2) return false;
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  static int _fractionalBits(double x) {
    return ((x - x.floor()) * 0x100000000).toInt();
  }

  static Uint8List hash(String message) {
    List<int> bytes = utf8.encode(message);
    List<int> padded = _padMessage(bytes);
    List<int> hashValues = List<int>.from(_H);
    List<int> W = List<int>.filled(64, 0);

    for (int i = 0; i < padded.length; i += 64) {
      for (int j = 0; j < 16; j++) {
        W[j] = _bytesToInt(padded, i + j * 4);
      }

      for (int j = 16; j < 64; j++) {
        int s0 = _rightRotate(W[j - 15], 7) ^ _rightRotate(W[j - 15], 18) ^ (W[j - 15] >> 3);
        int s1 = _rightRotate(W[j - 2], 17) ^ _rightRotate(W[j - 2], 19) ^ (W[j - 2] >> 10);
        W[j] = (W[j - 16] + s0 + W[j - 7] + s1) & 0xFFFFFFFF;
      }

      int a = hashValues[0], b = hashValues[1], c = hashValues[2], d = hashValues[3];
      int e = hashValues[4], f = hashValues[5], g = hashValues[6], h = hashValues[7];

      for (int j = 0; j < 64; j++) {
        int S1 = _rightRotate(e, 6) ^ _rightRotate(e, 11) ^ _rightRotate(e, 25);
        int ch = (e & f) ^ ((~e) & g);
        int temp1 = h + S1 + ch + _K[j] + W[j];
        int S0 = _rightRotate(a, 2) ^ _rightRotate(a, 13) ^ _rightRotate(a, 22);
        int maj = (a & b) ^ (a & c) ^ (b & c);
        int temp2 = S0 + maj;

        h = g;
        g = f;
        f = e;
        e = (d + temp1) & 0xFFFFFFFF;
        d = c;
        c = b;
        b = a;
        a = (temp1 + temp2) & 0xFFFFFFFF;
      }

      hashValues[0] = (hashValues[0] + a) & 0xFFFFFFFF;
      hashValues[1] = (hashValues[1] + b) & 0xFFFFFFFF;
      hashValues[2] = (hashValues[2] + c) & 0xFFFFFFFF;
      hashValues[3] = (hashValues[3] + d) & 0xFFFFFFFF;
      hashValues[4] = (hashValues[4] + e) & 0xFFFFFFFF;
      hashValues[5] = (hashValues[5] + f) & 0xFFFFFFFF;
      hashValues[6] = (hashValues[6] + g) & 0xFFFFFFFF;
      hashValues[7] = (hashValues[7] + h) & 0xFFFFFFFF;
    }

    return Uint8List.fromList(hashValues.expand((h) => _intToBytes(h)).toList());
  }

  static List<int> _padMessage(List<int> message) {
    int ml = message.length * 8;
    List<int> padded = List<int>.from(message)..add(0x80);
    while ((padded.length * 8) % 512 != 448) {
      padded.add(0);
    }
    padded.addAll(_intToBytes(ml >> 32));
    padded.addAll(_intToBytes(ml & 0xFFFFFFFF));
    return padded;
  }

  static int _bytesToInt(List<int> bytes, int offset) {
    return (bytes[offset] << 24) | (bytes[offset + 1] << 16) | (bytes[offset + 2] << 8) | (bytes[offset + 3]);
  }

  static List<int> _intToBytes(int n) {
    return [(n >> 24) & 0xFF, (n >> 16) & 0xFF, (n >> 8) & 0xFF, n & 0xFF];
  }

  static int _rightRotate(int x, int n) {
    return ((x >> n) | (x << (32 - n))) & 0xFFFFFFFF;
  }
}
