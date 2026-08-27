import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moive_app/model/movies_list/moive_model.dart';
import 'package:moive_app/model/movies_list/movies.dart';

class MovieService {
  static Future<List<Movies>> fetchMovies({String? genre}) async {
    final uri = Uri.parse(
      'https://movies-api.accel.li/api/v2/list_movies.json${genre != null ? '?genre=$genre' : ''}',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final model = MoiveModel.fromJson(jsonDecode(response.body));
      return model.data?.movies ?? [];
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }
}
