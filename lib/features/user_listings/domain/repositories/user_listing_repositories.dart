abstract class UserListingRepositories {
  Future getAppliedJobs({required String token});

  Future getMyJobs({required String token});

  Future getJobsApplicants({
    required String token,
    required String jobId,
  });
}
