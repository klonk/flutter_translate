import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernova_translator/models/lang.dart';

class LangPicker extends StatelessWidget {
  final String selectedLang;
  final List<Lang> lang;
  final bool src;
  final ValueChanged<String> onChanged;

  const LangPicker(
      {Key key, this.selectedLang, this.lang, this.src, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (lang == null) {
      return CircularProgressIndicator();
    }

    return Container(
        child: new DropdownButton<String>(
      value: selectedLang,
      selectedItemBuilder: (context) => lang
          .map((f) => Container(
              //todo dynamic text width
              width: 100,
              child: AutoSizeText(
                f.name,
                maxLines: 1,
              )))
          .toList(),
      items: lang.map((Lang value) {
        return new DropdownMenuItem<String>(
          value: value.language,
          child: new Text(value.name),
        );
      }).toList(),
      onChanged: (value) {
        onChanged(value);
      },
    ));
  }
}
