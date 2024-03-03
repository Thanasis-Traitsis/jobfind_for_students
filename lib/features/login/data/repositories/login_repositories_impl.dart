import 'dart:convert';

import '../../../../core/constants/urls.dart';
import '../../../../core/errors/error_model.dart';
import '../../domain/repositories/login_repositories.dart';
import '../../../auth/data/models/user_model.dart';

import 'package:http/http.dart' as http;

class LoginRepositoriesImpl implements LoginRepositories {
  UserModel? _user;

  UserModel? get user {
    return _user;
  }

  ErrorModel _errorModel = ErrorModel({});

  ErrorModel get errorModel {
    return _errorModel;
  }

  @override
  Future loginUser({
    required Map body,
  }) async {
    var url = '$baseUrl/login';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          'Accept': 'application/json',
        },
      );

      var result = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _user = UserModel.fromJson(result['user']);

        final tokenKey = jsonDecode(response.body)['token'];

        return tokenKey;
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
      }
    } catch (error) {
      print('Error at login : $error');
    }

    throw UnimplementedError();
  }
}
