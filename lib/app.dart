import 'package:flutter/material.dart';
import 'package:supernova_translator/app.widget.dart';
import 'package:supernova_translator/services/api_client.dart';

void main() => runApp(new AppWidget());

class App {
  static ApiClient http;

  static String clientId;

  static String googleApiKeys;

  App(
      {String environment,
      String baseUri,
      String clientId,
      String googleApiKey}) {
    App.clientId = clientId;
    App.googleApiKeys = googleApiKey;
    App.http = new ApiClient(baseUri);
    App.http.init();
  }

  // App run.
  void run(runApp) {
    runApp(new AppWidget());
  }

  static final List<String> supportedLanguagesCodes = ["en", "cs", "de"];

  static Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language, ""));

  static LocaleChangeCallback onLocaleChanged;

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  Future onSelectNotification(String payload) async {}
}

typedef void LocaleChangeCallback(Locale locale);
