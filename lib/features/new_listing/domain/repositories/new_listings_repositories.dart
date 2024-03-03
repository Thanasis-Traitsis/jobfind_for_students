abstract class NewListingsRepositories {
  Future getAcademia();

  Future createListing({
    required Map body,
  });

  Future updateListing({
    required Map body,
    required String jobId,
  });

  Future deleteListing({
    required String jobId,
  });
}
