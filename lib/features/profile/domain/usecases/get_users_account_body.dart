import 'dart:convert';

import 'package:flutter/services.dart';

Future<List> getUsersAccountBody(String role) async {
  var list = [];

  var userCredentials =
      await rootBundle.loadString('assets/account_settings.json');

  var usersList = jsonDecode(userCredentials)['account_settings'];

  for (var i = 0; i < usersList.length; i++) {
    if (usersList[i].containsKey(role)) {
      list = usersList[i][role];
    }
  }

  return list;
}