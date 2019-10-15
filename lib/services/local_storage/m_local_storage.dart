import 'package:shared_preferences/shared_preferences.dart';

import 'browser_local_storage.dart';

import 'dart:async';

const bool kIsWeb = identical(0, 0.0);

class MLocalStorage {
  BrowserLocalStorage browserLocalStorage;
  SharedPreferences sharedPrefStorage;
  static Completer<MLocalStorage> _completer;

  static Future<MLocalStorage> getInstance() async {
    if (_completer == null) {
      _completer = Completer();
      _initStorage();
    }
    return _completer.future;
  }

  static Future<MLocalStorage> _initStorage() async {
    var storage = new MLocalStorage();
    if (kIsWeb)
      storage.browserLocalStorage = await BrowserLocalStorage.getInstance();
    if (!kIsWeb)
      storage.sharedPrefStorage = await SharedPreferences.getInstance();
    _completer.complete(storage);
    print("init storage");
    return storage;
  }

  bool containsKey(String key) => kIsWeb
      ? this.browserLocalStorage.containsKey(key)
      : this.sharedPrefStorage.containsKey(key);

  bool getBool(String key) => kIsWeb
      ? this.browserLocalStorage.getBool(key)
      : this.sharedPrefStorage.getBool(key);

  double getDouble(String key) => kIsWeb
      ? this.browserLocalStorage.getDouble(key)
      : this.sharedPrefStorage.getDouble(key);

  int getInt(String key) => kIsWeb
      ? this.browserLocalStorage.getInt(key)
      : this.sharedPrefStorage.getInt(key);

  Set<String> getKeys() => kIsWeb
      ? this.browserLocalStorage.getKeys()
      : this.sharedPrefStorage.getKeys();

  String getString(String key) => kIsWeb
      ? this.browserLocalStorage.getString(key)
      : this.sharedPrefStorage.getString(key);

  List<String> getStringList(String key) => kIsWeb
      ? this.browserLocalStorage.getStringList(key).toList()
      : this.sharedPrefStorage.getStringList(key).toList();

  Future<void> reload() async {}

  Future<bool> remove(String key) async {
    assert(key != null);
    if (kIsWeb) {
      this.browserLocalStorage.remove(key);
    } else {
      this.sharedPrefStorage.remove(key);
    }
    return true;
  }

  Future<bool> setBool(String key, bool value) => kIsWeb
      ? this.browserLocalStorage.setBool(key, value)
      : this.sharedPrefStorage.setBool(key, value);

  Future<bool> setDouble(String key, double value) => kIsWeb
      ? this.browserLocalStorage.setDouble(key, value)
      : this.sharedPrefStorage.setDouble(key, value);

  Future<bool> setInt(String key, int value) => kIsWeb
      ? this.browserLocalStorage.setInt(key, value)
      : this.sharedPrefStorage.setInt(key, value);

  Future<bool> setString(String key, String value) => kIsWeb
      ? this.browserLocalStorage.setString(key, value)
      : this.sharedPrefStorage.setString(key, value);

  Future<bool> setStringList(String key, List<String> value) => kIsWeb
      ? this.browserLocalStorage.setStringList(key, value)
      : this.sharedPrefStorage.setStringList(key, value);
}
