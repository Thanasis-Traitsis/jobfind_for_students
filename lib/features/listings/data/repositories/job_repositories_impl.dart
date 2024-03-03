import 'dart:convert';

import '../../../../core/constants/urls.dart';
import '../../../auth/domain/usecases/secure_storage.dart';
import '../../domain/repositories/job_repositories.dart';
import '../models/job_model.dart';

import 'package:http/http.dart' as http;

class JobRepositoriesImpl extends JobRepositories {
  String tkn = '';

  /*
    |--------------------------------------------------------------------------
    | Fetch all the recent jobs
    |--------------------------------------------------------------------------
  */
  @override
  Future<List<JobModel>> fetchJobs({required String token}) async {
    tkn = token;

    try {
      var url = Uri.parse('$baseUrl/listings');

      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body)['listings']['data'];

        List<JobModel> recentJobs = [];

        for (var j in jsonResponse) {
          JobModel job = JobModel.fromJson(j);

          job.applicants_count = null;

          recentJobs.add(job);
        }

        return recentJobs;
      } else {
        print('Error while fetching the recent jobs');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  /*
    |--------------------------------------------------------------------------
    | Fetch all the jobs based on the user's major id
    |--------------------------------------------------------------------------
  */
  @override
  Future<List<JobModel>> fetchJobsById(int? majorID) async {
    if (majorID != null) {
      try {
        var url = Uri.parse('$baseUrl/listings?major=$majorID');

        var response = await http.get(
          url,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $tkn',
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          var jsonResponse = jsonDecode(response.body)['listings']['data'];

          List<JobModel> majordIdJobs = [];

          for (var j in jsonResponse) {
            JobModel job = JobModel.fromJson(j);

            majordIdJobs.add(job);
          }

          return majordIdJobs;
        } else {
          print('Error while fetching the jobs based on the Major Id');
        }
      } catch (e) {
        print(e);
      }
    }

    return [];
  }

  /*
    |--------------------------------------------------------------------------
    | Fetch more jobs after scrolling to the bottom of the screen
    |--------------------------------------------------------------------------
  */
  @override
  Future<List<dynamic>> fetchMoreJobs(int numberOfPage, String filter) async {
    String? token = await SecureStorage().hasToken();

    try {
      var url = Uri.parse('$baseUrl/listings?${filter}page=$numberOfPage');

      print(url);

      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var nextPage = jsonDecode(response.body)['listings']['next_page_url'];
        var jsonResponse = jsonDecode(response.body)['listings']['data'];

        List<JobModel> moreJobs = [];

        for (var j in jsonResponse) {
          JobModel job = JobModel.fromJson(j);

          job.applicants_count = null;

          moreJobs.add(job);
        }

        return [moreJobs, nextPage];
      } else {
        print('Error while fetching the more jobs');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  /*
    |--------------------------------------------------------------------------
    | Fetch jobs based on the search textfield
    |--------------------------------------------------------------------------
  */
  @override
  Future<List<JobModel>> fetchSearchJobs(String search) async {
    try {
      var url = Uri.parse('$baseUrl/listings?search=$search');

      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tkn',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body)['listings']['data'];

        List<JobModel> searchedJobs = [];

        for (var j in jsonResponse) {
          JobModel job = JobModel.fromJson(j);

          job.applicants_count = null;

          searchedJobs.add(job);
        }

        return searchedJobs;
      } else {
        print('Error while fetching the searched jobs');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  /*
    |--------------------------------------------------------------------------
    | Fetch jobs based on the search textfield
    |--------------------------------------------------------------------------
  */
  @override
  Future<List<JobModel>> fetchFilterJobs(String filter) async {
    try {
      var url = Uri.parse('$baseUrl/listings?filter=$filter');

      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $tkn',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body)['listings']['data'];

        List<JobModel> filteredJobs = [];

        for (var j in jsonResponse) {
          JobModel job = JobModel.fromJson(j);

          job.applicants_count = null;

          filteredJobs.add(job);
        }

        return filteredJobs;
      } else {
        print('Error while fetching the filtered jobs');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  /*
    |--------------------------------------------------------------------------
    | Fetch recent applicants from the business acount logged in
    |--------------------------------------------------------------------------
  */
  @override
  Future<List> fetchApplicants({
    required String token,
  }) async {
    try {
      var url = Uri.parse('$baseUrl/applications/list/latest');

      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body)['listings'];

        List recentApplicants = jsonResponse;

        return recentApplicants;
      } else {
        print('Error while fetching the recent applicants');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
