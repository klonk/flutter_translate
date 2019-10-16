import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supernova_translator/modules/data_provider.dart';
import 'package:supernova_translator/pages/start_page.dart';
import 'package:supernova_translator/translations/app_translations_delegate.dart';

import 'app.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  Key key = new UniqueKey();
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    App.onLocaleChanged = onLocaleChange;
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
  }

  @override
  Widget build(BuildContext context) {
    return DataProvider(
      child: MaterialApp(
        key: key,
        localizationsDelegates: [
          _newLocaleDelegate,
          //provides localised strings
          GlobalMaterialLocalizations.delegate,
          //provides RTL support
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: App.supportedLocales(),
        title: 'Supernova Translator',
        home: StartPage(),
      ),
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}
