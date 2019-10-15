import 'package:flutter/material.dart';
import 'package:supernova_translator/components/translation_item.dart';
import 'package:supernova_translator/models/translation.dart';
import 'package:supernova_translator/modules/data_provider.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key}) : super(key: key);

  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    var bloc = DataProvider.getTranslation(context);
    return Container(
        child: StreamBuilder<List<TranslationResponse>>(
      stream: bloc.favoriteTranslation,
      initialData: List<TranslationResponse>(),
      builder: (BuildContext context, snapshot) {
        return Container(
            child: ListView.builder(
          itemCount: snapshot?.data?.length,
          itemBuilder: (context, index) =>
              TranslationItem(snapshot.data[index]),
        ));
      },
    ));
  }
}
