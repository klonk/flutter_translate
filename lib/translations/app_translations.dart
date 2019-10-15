import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppTranslations {
  Locale locale;
  static Map<dynamic, dynamic> _sentence;

  AppTranslations(Locale locale) {
    this.locale = locale;
    _sentence = null;
  }

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  static Future<AppTranslations> load(Locale locale) async {
    AppTranslations appTranslations = AppTranslations(locale);
    String jsonContent = await rootBundle
        .loadString("locale/localization_${locale.languageCode}.json");
    Map<String, dynamic> _result = json.decode(jsonContent);

    _sentence = new Map();
    _result.forEach((String key, dynamic value) {
      _sentence[key] = value;
    });

    return appTranslations;
  }

  String get currentLanguage => locale.languageCode;

  String text(String key) {
    if (_sentence == null) {
      return "";
    }
    return this._resolve(key, _sentence);
  }

  String dbText(Map<String, String> texts) {
    var text = texts[locale.countryCode];
    return text;
  }

  String tr(String key, {List<String> args}) {
    String res = this._resolve(key, _sentence);
    if (args != null) {
      args.forEach((String str) {
        res = res.replaceFirst(RegExp(r'{}'), str);
      });
    }
    return res;
  }

  String _resolve(String path, dynamic obj) {
    List<String> keys = path.split('.');

    if (keys.length > 1) {
      for (int index = 0; index <= keys.length; index++) {
        if (obj.containsKey(keys[index]) && obj[keys[index]] is! String) {
          return _resolve(
              keys.sublist(index + 1, keys.length).join('.'), obj[keys[index]]);
        }

        return obj[path] ?? path;
      }
    }

    return obj[path] ?? path;
  }
}
