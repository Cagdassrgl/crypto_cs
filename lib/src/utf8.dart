import 'package:crypto_cs/core/model/word_array.dart' show WordArray;

class Utf8 {
  static WordArray parse(String hexStr) {
    hexStr = hexStr.runes.map((rune) => rune.toRadixString(16).padLeft(2, '0')).join('');

    int hexStrLength = hexStr.length;
    List<int> words = List.filled((hexStrLength / 8).ceil(), 0);

    for (int i = 0; i < hexStrLength; i += 2) {
      int byteValue = int.parse(hexStr.substring(i, i + 2), radix: 16);
      words[i >> 3] |= byteValue << (24 - (i % 8) * 4);
    }

    return WordArray(words, hexStrLength ~/ 2);
  }
}
