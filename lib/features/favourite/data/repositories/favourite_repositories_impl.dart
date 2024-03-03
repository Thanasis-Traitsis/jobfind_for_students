import 'dart:convert';

import '../../../../core/constants/urls.dart';
import '../../../listings/data/models/job_model.dart';
import '../../domain/repositories/favourite_repositories.dart';

import 'package:http/http.dart' as http;

class FavouriteRepositoriesImpl extends FavouriteRepositories {
  @override
  Future getFavourites({required String token}) async {
    try {
      var url = Uri.parse('$baseUrl/listings/favourites');

      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body)['listings']['data'];
        List<JobModel> favouriteJobs = [];

        for (var j in jsonResponse) {
          JobModel job = JobModel.fromJson(j);

          favouriteJobs.add(job);
        }

        // print(favouriteJobs);

        return favouriteJobs;
      } else {
        throw Exception('Problem loading jobs');
      }
    } catch (e) {
      print(e);
    }
  }
}
