import 'dart:io';

abstract class ProfileRepositories {
  Future updateUser({
    required Map body,
    required String id,
    required String token,
  });

  Future uploadResume({
    required String token,
    required File resume,
  });

  Future uploadImage({
    required String token,
    required File image,
  });

  Future submitSubmission({
    required Map body,
    required String token,
  });

  Future getSubmission({
    required String id,
    required String token,
  });
}
