import 'dart:convert';
import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/urls.dart';
import '../../../../core/errors/error_model.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/repositories/profile_repositories.dart';
import 'package:http/http.dart' as http;

class ProfileRepositoriesImpl implements ProfileRepositories {
  ErrorModel _errorModel = ErrorModel({});

  ErrorModel get errorModel {
    return _errorModel;
  }

  @override
  Future updateUser({
    required Map body,
    required String id,
    required String token,
  }) async {
    var url = '$baseUrl/user/update/$id';

    try {
      var response = await http.put(
        Uri.parse(url),
        body: body,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        UserModel user = UserModel.fromJson(jsonDecode(response.body)['user']);

        return user;
      } else {
        // Handling errors
        _errorModel = ErrorModel({});
        Map<String, dynamic> errorResponse = result['errors'];

        // Adding errors to the ErrorModel
        errorResponse.forEach((field, errors) {
          errors.forEach((error) {
            _errorModel.addError(field, error);
          });
        });

        // Displaying the errors or handling them accordingly
        if (_errorModel.hasErrors()) {
          _errorModel.errors.forEach((field, errors) {
            print('$field errors: $errors');
          });
        }

        return null;
      }
    } catch (error) {
      print('Error at : $error');
      return null;
    }
  }

  @override
  Future uploadResume({
    required String token,
    required File resume,
  }) async {
    var url = '$baseUrl/user/upload/resume';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'resume',
          resume.path,
        ),
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return null;
      }
    } catch (error) {
      print('Error at resume upload : $error');
      return null;
    }
  }

  @override
  Future uploadImage({
    required String token,
    required File image,
  }) async {
    var url = '$baseUrl/user/upload/avatar';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'avatar',
          image.path,
        ),
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return null;
      }
    } catch (error) {
      print('Error at image upload : $error');
      return null;
    }
  }

  @override
  Future submitSubmission({
    required Map body,
    required String token,
  }) async {
    var url = '$baseUrl/submissions/create';

    print(body);

    try {
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      var result = jsonDecode(response.body);

      print(result);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        // Handling errors
        _errorModel = ErrorModel({});
        Map<String, dynamic> errorResponse = result['errors'];

        // Adding errors to the ErrorModel
        errorResponse.forEach((field, errors) {
          errors.forEach((error) {
            _errorModel.addError(field, error);
          });
        });

        // Displaying the errors or handling them accordingly
        if (_errorModel.hasErrors()) {
          _errorModel.errors.forEach((field, errors) {
            print('$field errors: $errors');
          });
        }

        return null;
      }
    } catch (error) {
      print('Error at : $error');
      return null;
    }
  }

  @override
  Future getSubmission({
    required String id,
    required String token,
  }) async {
    var url = Uri.parse('$baseUrl/user/submission/$id/pdf/download');

    try {
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final bytes = response.bodyBytes;
        const fileName = 'submission.pdf';
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/$fileName');
        await file.writeAsBytes(bytes);

        print('Path: ${file.path}');

        OpenFilex.open(file.path);

        return file.path;
      } else {
        print('Failed to download PDF file ${response.statusCode} : ${response.body}');

        return null;
      }
    } catch (error) {
      print('Failed to download PDF file : $error');
      return null;
    }
  }
}
