import 'dart:convert';

import '../../../../core/constants/urls.dart';
import '../../../auth/domain/usecases/secure_storage.dart';

import 'package:http/http.dart' as http;

Future getMajorIds(String id) async {
  String? token = await SecureStorage().hasToken();

  try {
    var url = Uri.parse('$baseUrl/academia/universities/$id');

    var response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List selectedDep = [];

      List selectedMajors = [];

      List selectedUni = jsonDecode(response.body)['universities'];

      for (var i = 0; i < selectedUni.length; i++) {
        selectedDep = selectedDep + selectedUni[i]['departments'];
      }

      for (var i = 0; i < selectedDep.length; i++) {
        selectedMajors = selectedMajors + selectedDep[i]['majors'];
      }

      List chosenUni = [];

      for (var i = 0; i < selectedUni.length; i++) {
        chosenUni.add(selectedUni[i]['name']);
      }

      List chosenDep = [];

      for (var i = 0; i < selectedDep.length; i++) {
        chosenDep.add(selectedDep[i]['name']);
      }

      List chosenMajors = [];

      for (var i = 0; i < selectedMajors.length; i++) {
        chosenMajors.add(selectedMajors[i]['id']);
      }

      return [chosenUni, chosenDep, chosenMajors];
    } else {
      print('Error while fetching major id');
    }
  } catch (e) {
    print(e);
  }
  return null;
}
