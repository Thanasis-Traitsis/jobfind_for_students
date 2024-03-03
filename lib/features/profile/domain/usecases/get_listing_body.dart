import 'dart:convert';

import 'package:flutter/services.dart';

Future<List> getListingBody() async {
  var listCredentials = await rootBundle.loadString('assets/listing_body.json');

  var listBody = jsonDecode(listCredentials)['listing_body'];

  return listBody;
}
