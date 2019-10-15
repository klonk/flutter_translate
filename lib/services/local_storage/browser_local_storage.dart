import 'dart:convert';
import 'package:universal_html/prefer_sdk/html.dart' as html;

class BrowserLocalStorage {
  static Future<BrowserLocalStorage> getInstance() =>
      Future.value(BrowserLocalStorage());

  Map<String, String> get _storage =>
      html.window.localStorage; // ignore: undefined_identifier

  Future<bool> clear() async {
    _storage.clear();
    return true;
  }

  bool containsKey(String key) => _storage.containsKey(key);

  dynamic get(String key) {
    assert(key != null);
    final value = _storage[key];
    if (value == null) return null;
    switch (value[0]) {
      case 't':
        return true;
      case 'f':
        return false;
      case 'd':
        return double.parse(value.substring(1));
      case 'i':
        return double.parse(value.substring(1));
      case 's':
        return value.substring(1);
      case '[':
        return (jsonDecode(value) as List<dynamic>)
            .map((f) => f.toString())
            .toList();
      default:
        assert(false);
    }
  }

  bool getBool(String key) => get(key);

  double getDouble(String key) => get(key);

  int getInt(String key) => get(key);

  Set<String> getKeys() => Set.of(_storage.keys);

  String getString(String key) => get(key);

  List<String> getStringList(String key) => get(key);

  Future<void> reload() async {}

  Future<bool> remove(String key) async {
    assert(key != null);
    _storage.remove(key);
    return true;
  }

  Future<bool> _set<T>(String key, T value, String Function(T) encode) async {
    assert(key != null);
    if (value == null) return remove(key);
    _storage[key] = encode(value);
    return true;
  }

  Future<bool> setBool(String key, bool value) =>
      _set(key, value, (value) => value ? 't' : 'f');

  Future<bool> setDouble(String key, double value) =>
      _set(key, value, (value) => 'd$value');

  Future<bool> setInt(String key, int value) =>
      _set(key, value, (value) => 'i$value');

  Future<bool> setString(String key, String value) =>
      _set(key, value, (value) => 's$value');

  Future<bool> setStringList(String key, List<String> value) =>
      _set(key, value, jsonEncode);
}
