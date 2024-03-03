import 'dart:convert';

import '../../../../core/constants/urls.dart';
import '../../../listings/data/models/job_model.dart';
import '../../domain/repositories/user_listing_repositories.dart';

import 'package:http/http.dart' as http;

class UserListingRepositoriesImpl extends UserListingRepositories {
  @override
  Future getAppliedJobs({required String token}) async {
    try {
      var page = 1;
      var url = Uri.parse('$baseUrl/listings');

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
        List<JobModel> appliedJobs = [];

        for (var j in jsonResponse) {
          JobModel job = JobModel.fromJson(j);

          if (job.hasApplied == 1) {
            appliedJobs.add(job);
          }
        }

        while (nextPage != null) {
          page++;

          var url2 = Uri.parse('$baseUrl/listings?page=$page');

          var response2 = await http.get(
            url2,
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          );

          if (response2.statusCode == 200 || response2.statusCode == 201) {
            nextPage = jsonDecode(response2.body)['listings']['next_page_url'];
            var jsonResponse2 = jsonDecode(response2.body)['listings']['data'];

            for (var j in jsonResponse2) {
              JobModel job2 = JobModel.fromJson(j);

              if (job2.hasApplied == 1) {
                appliedJobs.add(job2);
              }
            }
          }
        }

        return appliedJobs;
      } else {
        throw Exception('Problem loading applied jobs');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getMyJobs({required String token}) async {
    try {
      var page = 1;
      var url = Uri.parse('$baseUrl/listings/business');

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

        List<JobModel> myJobs = [];

        for (var j in jsonResponse) {
          JobModel job = JobModel.fromJson(j);

          myJobs.add(job);
        }

        while (nextPage != null) {
          page++;

          var url2 = Uri.parse('$baseUrl/listings?page=$page');

          var response2 = await http.get(
            url2,
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          );

          if (response2.statusCode == 200 || response2.statusCode == 201) {
            nextPage = jsonDecode(response2.body)['listings']['next_page_url'];
            var jsonResponse2 = jsonDecode(response2.body)['listings']['data'];

            for (var j in jsonResponse2) {
              JobModel job2 = JobModel.fromJson(j);

              myJobs.add(job2);
            }
          }
        }

        return myJobs;
      } else {
        throw Exception('Problem loading applied jobs');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getJobsApplicants({
    required String token,
    required String jobId,
  }) async {
    var url = Uri.parse('$baseUrl/user/applicants/all/$jobId');

    try {
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body)['listings'];

        List applicantsList = jsonResponse;

        return applicantsList;
      } else {
        throw Exception('Problem loading applicants for this job');
      }
    } catch (e) {
      print(e);
    }
  }
}
