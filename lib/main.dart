import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  new App(
          googleApiKey: 'TODO ENTER API KEY',
          baseUri: 'translation.googleapis.com')
      .run(runApp);
}
