import 'dart:convert';

import 'package:new_bloc_ihu/core/constants/urls.dart';
import 'package:new_bloc_ihu/features/signup/domain/repositories/signup_repositories.dart';

import 'package:http/http.dart' as http;

import '../../../../core/errors/error_model.dart';
import '../../../auth/data/models/user_model.dart';

class SignupRepositoriesImpl implements SignupRepositories {
  UserModel? _user;

  UserModel? get user {
    return _user;
  }

  ErrorModel _errorModel = ErrorModel({});

  ErrorModel get errorModel {
    return _errorModel;
  }

  @override
  Future signupUser({required Map body}) async {
    var url = '$baseUrl/register';

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
    } catch (error) {}
    throw UnimplementedError();
  }
}
