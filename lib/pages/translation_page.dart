import 'package:flutter/material.dart';
import 'package:supernova_translator/components/translation_input.dart';
import 'package:supernova_translator/components/translation_item.dart';
import 'package:supernova_translator/models/translation.dart';
import 'package:supernova_translator/modules/data_provider.dart';
import 'package:supernova_translator/translations/app_translations.dart';

class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage>
    with AutomaticKeepAliveClientMixin<TranslationPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var bloc = DataProvider.getTranslation(context);
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            child: new TranslationInput(bloc: bloc),
            elevation: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              AppTranslations.of(context).text('common.translations'),
              style:
                  Theme.of(context).textTheme.caption.apply(fontSizeDelta: 2),
            ),
          ),
        ),
        StreamBuilder<TranslationResponse>(
            stream: bloc.translation,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container();
              }
              return TranslationItem(snapshot.data);
            })
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
