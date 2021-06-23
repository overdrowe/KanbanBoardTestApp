import 'dart:convert';

import 'package:http/http.dart' as http;

class UserRepository {
  final String token;

  UserRepository({required this.token});

  getCards() async {
    var url = "https://trello.backend.tests.nekidaem.ru/api/v1/cards/";

    var headers = {'Authorization': 'JWT $token'};

    var request = http.Request('GET', Uri.parse('https://trello.backend.tests.nekidaem.ru/api/v1/cards/'));
    request.bodyFields = {};
    request.headers.addAll(headers);

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'JWT $token',
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception('Some exception');
    }
  }
}
