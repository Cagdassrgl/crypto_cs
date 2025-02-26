# crypto_cs

`crypto_cs` is a Dart package that provides implementations of various cryptographic algorithms and utilities, such as Base64 encoding, MD5 hashing, SHA-256 hashing, and UTF-8/hex string parsing. The package is designed for ease of use and integration in your Dart/Flutter applications, providing essential cryptographic functionality.

## Features

- **Base64 Encoding**: Encode byte arrays into Base64 string representations.
- **MD5 Hashing**: Generate MD5 hashes for input strings.
- **SHA-256 Hashing**: Generate SHA-256 hashes for input strings.
- **UTF-8/Hex Parsing**: Convert hexadecimal strings into `WordArray` for cryptographic operations.


## Usage

### Base64 Encoding

The `Base64` class provides a method to convert a `WordArray` to a Base64 string.

#### Example Usage:

```dart
import 'package:crypto_cs/crypto_cs.dart';

WordArray wordArray = Utf8.parse("Hello, world");
String base64String = Base64.stringify(wordArray);

### MD5 Hashing

Use the `MD5` class to compute an MD5 hash of a string.

The `MD5` class allows you to compute a 128-bit hash value for any given string. This hash is typically used to check data integrity or create unique identifiers for data. 

#### Example Usage:

```dart
import 'package:crypto_cs/crypto_cs.dart';

String input = "Hello, world!";
String hash = MD5.hash(input);

### SHA-256 Hashing

Use the `SHA256` class to compute a SHA-256 hash of a string.

The `SHA256` class computes a 256-bit hash value for a given string using the SHA-256 algorithm, which is part of the SHA-2 family of cryptographic hash functions. It is widely used for data integrity verification and digital signatures.

#### Example Usage:

```dart
import 'package:crypto_cs/crypto_cs.dart';

String input = "Hello, world!";
Uint8List hash = SHA256.hash(input);
