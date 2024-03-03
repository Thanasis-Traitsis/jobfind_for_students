import '../../data/models/job_model.dart';

abstract class JobRepositories {
  Future<List<JobModel>> fetchJobs({required String token});

  Future<List> fetchApplicants({required String token});

  Future<List<JobModel>> fetchJobsById(int majordID);

  Future<List<dynamic>> fetchMoreJobs(int numberOfPage, String filter);

  Future<List<JobModel>> fetchSearchJobs(String search);

  Future<List<JobModel>> fetchFilterJobs(String filter);

}
