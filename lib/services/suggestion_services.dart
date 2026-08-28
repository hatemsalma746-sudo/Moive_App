import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moive_app/services/api_constant.dart';
import 'package:moive_app/services/endpoint.dart';

import '../model/moive_suggetion/movies.dart';

class SuggestionService {
  static Future<List<Movies>> getMovieSuggestions(int movieId) async {
    final uri = Uri.https(ApiConstant.baseUrl, Endpoint.endPointOfSuggestion, {
      'movie_id': movieId.toString(),
    });

    print('Suggestion URL: $uri');

    final response = await http.get(uri);
    print('Suggestion URL: $uri');
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load movie suggestions');
    }

    final jsonData = jsonDecode(response.body);

    final List movies = jsonData['data']['movies'];

    return movies.take(4).map((movie) => Movies.fromJson(movie)).toList();
  }
}
