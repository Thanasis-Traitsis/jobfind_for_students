import 'dart:convert';

import '../../../../core/constants/urls.dart';
import '../../../../core/errors/error_model.dart';
import '../../../auth/domain/usecases/secure_storage.dart';
import '../../domain/repositories/new_listings_repositories.dart';

import 'package:http/http.dart' as http;

class NewListingsRepositoriesImpl implements NewListingsRepositories {
  final storage = SecureStorage();

  ErrorModel _errorModel = ErrorModel({});

  ErrorModel get errorModel {
    return _errorModel;
  }

  @override
  Future getAcademia() async {
    String? token = await storage.hasToken();

    try {
      var url = Uri.parse('$baseUrl/academia/universities');

      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body)['universities'];

        List universities = [];
        Map departments = {};
        Map majors = {};

        List allTogether = [];

        for (var i = 0; i < jsonResponse.length; i++) {
          universities.add(jsonResponse[i]['name']);
          departments[jsonResponse[i]['name']] = [];
          for (var j = 0; j < jsonResponse[i]['departments'].length; j++) {
            departments[jsonResponse[i]['name']]
                .add(jsonResponse[i]['departments'][j]);

            majors[jsonResponse[i]['departments'][j]['name']] = [];
            for (var m = 0;
                m < jsonResponse[i]['departments'][j]['majors'].length;
                m++) {
              majors[jsonResponse[i]['departments'][j]['name']]
                  .add(jsonResponse[i]['departments'][j]['majors'][m]);

              allTogether.add(
                {
                  'id': jsonResponse[i]['departments'][j]['majors'][m]['id'],
                  'major': jsonResponse[i]['departments'][j]['majors'][m]
                      ['name'],
                  'department': jsonResponse[i]['departments'][j]['name'],
                  'university': jsonResponse[i]['name'],
                },
              );
            }
          }
        }

        return [universities, departments, majors, allTogether];
      } else {
        print('Error while fetching universities');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  @override
  Future createListing({
    required Map body,
  }) async {
    String? token = await storage.hasToken();

    try {
      var url = Uri.parse('$baseUrl/listings/create');

      var response = await http.post(
        url,
        body: body,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        // Handling errors
        _errorModel = ErrorModel({});
        Map<String, dynamic> errorResponse = jsonResponse['errors'];

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

        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Future updateListing({required Map body, required String jobId}) async {
    String? token = await storage.hasToken();

    try {
      var url = Uri.parse('$baseUrl/listings/update/$jobId');

      var response = await http.put(
        url,
        body: body,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        // Handling errors
        _errorModel = ErrorModel({});
        Map<String, dynamic> errorResponse = jsonResponse['errors'];

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

        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Future deleteListing({required String jobId}) async {
    String? token = await storage.hasToken();

    try {
      var url = Uri.parse('$baseUrl/listings/delete/$jobId');

      var response = await http.delete(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
