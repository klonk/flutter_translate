import 'package:flutter/material.dart';
import 'package:supernova_translator/translations/app_translations.dart';

import 'language_selector_page.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            InkWell(
              child: FractionallySizedBox(
                widthFactor: 0.6,
                child: Card(
                    elevation: 8,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Language: ${AppTranslations.of(context).locale.languageCode}',
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ))),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LanguageSelectorPage())),
            ),
            const SizedBox(
              height: 16,
            ),
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.help),
                        const SizedBox(
                          width: 8,
                        ),
                        Text('Support',
                            style: Theme.of(context).textTheme.display1),
                      ],
                    ),
                    ListTile(
                      leading: Icon(Icons.satellite),
                      title: Text('Tutorial'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_input_component),
                      title: Text('Contact support'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    ListTile(
                      leading: Icon(Icons.rate_review),
                      title: Text('Rate application'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    ListTile(
                      leading: Icon(Icons.share),
                      title: Text('Share'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
