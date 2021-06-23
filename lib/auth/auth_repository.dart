import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRepository {
  login({required String username, required String password}) async {
    var response = await http.post(
      Uri.parse('https://trello.backend.tests.nekidaem.ru/api/v1/users/login/'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, String>{'username': username, 'password': password}),
    );
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['token'];
    } else {
      throw Exception(jsonDecode(response.body)['non_field_errors']);
    }
  }
}
