import 'package:crypto_cs/core/model/word_array.dart' show WordArray;

class Base64 {
  static const String _map = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';

  static String stringify(WordArray wordArray) {
    List<int> words = List<int>.from(wordArray.words);
    int sigBytes = wordArray.sigBytes;

    List<String> base64Chars = [];

    for (int i = 0; i < sigBytes; i += 3) {
      int byte1 = (words[i >> 2] >> (24 - (i % 4) * 8)) & 0xff;
      int byte2 = (i + 1 < sigBytes) ? (words[(i + 1) >> 2] >> (24 - ((i + 1) % 4) * 8)) & 0xff : 0;
      int byte3 = (i + 2 < sigBytes) ? (words[(i + 2) >> 2] >> (24 - ((i + 2) % 4) * 8)) & 0xff : 0;

      int triplet = (byte1 << 16) | (byte2 << 8) | byte3;

      for (int j = 0; (j < 4) && (i + j * 0.75 < sigBytes); j++) {
        base64Chars.add(_map[(triplet >> (6 * (3 - j))) & 0x3f]);
      }
    }

    // Padding ekleme
    while (base64Chars.length % 4 != 0) {
      base64Chars.add('=');
    }

    return base64Chars.join('');
  }
}
