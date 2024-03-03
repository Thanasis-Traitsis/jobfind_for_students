abstract class AuthRepositories {
  Future isAuthenticated({required String token});

  Future logout({required String token});

  Future setAcademia({
    required String token,
    required String majorId,
  });
}
