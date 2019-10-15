import 'package:flutter/material.dart';
import 'package:supernova_translator/models/translation.dart';
import 'package:supernova_translator/modules/data_provider.dart';
import 'package:supernova_translator/translations/app_translations.dart';

import 'favorite_icon.dart';

class TranslationItem extends StatelessWidget {

  final TranslationResponse translation;

  const TranslationItem(this.translation,{Key key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(elevation: 4.0,
         child: Padding(
           padding: const EdgeInsets.all(24.0),
           child: Row(
             children: <Widget>[
             Expanded(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text(translation.srcText,style: Theme.of(context).textTheme.body1.apply(fontSizeDelta: 3),),
                   const SizedBox(height: 8,),
                   Text(translation.trgText ?? '' ,style: Theme.of(context).textTheme.body1.apply(fontSizeDelta: -0.7,fontWeightDelta: 70),),
                    const SizedBox(height: 8,),
                   if(translation.detected)
                   ...{
                    
                        new AutoDetectLang(langCode: translation.srcLang),
                   },         
                     
                 ],
               )),
             FavoriteIconButton(translation)
           ],),
         ),
      ),
    );
  }
}

class AutoDetectLang extends StatelessWidget {
  const AutoDetectLang({
    Key key,
    @required this.langCode,
  }) : super(key: key);

  final String langCode;

  @override
  Widget build(BuildContext context) {
    var bloc = DataProvider.getTranslation(context);
    return Text("${AppTranslations.of(context).text('common.detect_label')}: ${bloc.getLangName(langCode).name}",style: Theme.of(context).textTheme.body1.apply(fontSizeDelta: -0.7,fontWeightDelta: -10));
  }
}