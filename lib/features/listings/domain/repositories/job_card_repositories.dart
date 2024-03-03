abstract class JobCardRepositories {
  Future<bool> favoriteJob({
    required String token,
    required String id,
  });

  Future<bool> applyJob({
    required String token,
    required String id,
  });

  Future<bool> viewJob({
    required String token,
    required String id,
  });
}
