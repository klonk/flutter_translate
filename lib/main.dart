import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  new App(
          googleApiKey: 'AIzaSyCEcBudDM2zAwf7W2SuDUc_xzVQMzv3xYg',
          baseUri: 'translation.googleapis.com')
      .run(runApp);
}
