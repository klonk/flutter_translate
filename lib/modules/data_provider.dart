import 'package:flutter/material.dart';
import 'package:supernova_translator/modules/translation_bloc.dart';

class DataProvider extends InheritedWidget {
  final TranslationBloc translationBloc;

  DataProvider({
    Key key,
    Widget child,
  })  : translationBloc = new TranslationBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TranslationBloc getTranslation(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(DataProvider) as DataProvider)
          .translationBloc;

  static DataProvider getData(BuildContext context) =>
      context.inheritFromWidgetOfExactType(DataProvider);
}
