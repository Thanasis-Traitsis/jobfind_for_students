import 'dart:convert';

import 'package:flutter/services.dart';

Future<List> getRequestDegreeBody() async {
  var requestCredentials =
      await rootBundle.loadString('assets/request_degree_list.json');

  var requestList = jsonDecode(requestCredentials)['request_degree_list'];

  return requestList;
}
