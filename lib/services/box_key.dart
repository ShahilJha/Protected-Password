import 'package:protected_password/utils/utility.dart';

class BoxKey {
  static String? _key;

  static String get key => _key ?? '';

  static set key(String value) {
    _key = value;
  }

  static bool compareHash(String hash) =>
      hash == Utility.getKeyDigestString(key);

  static String get hash => Utility.getKeyDigestString(key);
}
