import 'dart:convert';

import '../../../../core/constants/urls.dart';
import '../../domain/repositories/job_card_repositories.dart';

import 'package:http/http.dart' as http;

class JobCardRepositoriesImpl extends JobCardRepositories {
  /*
    |--------------------------------------------------------------------------
    | Toggle favourite job from a job card
    |--------------------------------------------------------------------------
  */
  @override
  Future<bool> favoriteJob({
    required String token,
    required String id,
  }) async {
    try {
      var url = Uri.parse('$baseUrl/listings/favourite/$id');

      var response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(jsonDecode(response.body));

        return jsonDecode(response.body)['isFavourite'];
      } else {
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  /*
    |--------------------------------------------------------------------------
    | Toggle apply job from a job card
    |--------------------------------------------------------------------------
  */
  @override
  Future<bool> applyJob({
    required String token,
    required String id,
  }) async {
    try {
      var url = Uri.parse('$baseUrl/listings/$id/apply');

      var response = await http.put(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(jsonDecode(response.body));

        var hasAppliedInt = jsonDecode(response.body)['hasApplied'];

        return hasAppliedInt == 1 ? true : false;
      } else {
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  /*
    |--------------------------------------------------------------------------
    | View job
    |--------------------------------------------------------------------------
  */
  @override
  Future<bool> viewJob({
    required String token,
    required String id,
  }) async {
    try {
      var url = Uri.parse('$baseUrl/listings/$id/view');

      var response = await http.put(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(jsonDecode(response.body));

        var hasViewedInt = jsonDecode(response.body)['status'];

        return hasViewedInt;
      } else {
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
