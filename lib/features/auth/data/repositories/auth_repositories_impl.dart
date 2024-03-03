import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/urls.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../models/user_model.dart';

class AuthRepositoriesImpl extends AuthRepositories {
  UserModel? _user;

  UserModel? get user {
    return _user;
  }

  @override
  Future isAuthenticated({required String token}) async {
    try {
      var url = Uri.parse('$baseUrl/user/current');

      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body)['user'];
        _user = UserModel.fromJson(data);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);

      _user = null;
    }
  }

  @override
  Future logout({required String token}) async {
    try {
      var url = Uri.parse('$baseUrl/user/logout');

      await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    } catch (error) {
      throw UnimplementedError();
    }
  }

  void updateUser(UserModel user) {
    _user = user;
  }

  @override
  Future setAcademia({
    required String token,
    required String majorId,
  }) async {
    if (majorId != '' && majorId != null) {
      try {
        var url = Uri.parse('$baseUrl/user/update/major/$majorId');

        var response = await http.put(
          url,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          return true;
        } else {
          print(response.body);
          return false;
        }
      } catch (e) {
        print(e);
        return false;
      }
    }
    return false;
  }
}
