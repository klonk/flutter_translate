import 'package:flutter/material.dart';
import 'package:supernova_translator/models/translation.dart';

import 'package:supernova_translator/modules/data_provider.dart';

class FavoriteIconButton extends StatelessWidget {
  final TranslationResponse translation;

  const FavoriteIconButton(this.translation, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var bloc = DataProvider.getTranslation(context);
    return StreamBuilder<List<TranslationResponse>>(
      stream: bloc.favoriteTranslation,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        var favorite = snapshot.data.contains(this.translation);

        if (favorite) {
          return IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () => bloc.removeFavorite(this.translation));
        } else {
          return IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () => bloc.addFavorite(this.translation));
        }
      },
    );
  }
}
