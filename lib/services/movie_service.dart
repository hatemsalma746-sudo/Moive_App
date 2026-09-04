import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moive_app/model/movies_list/moive_model.dart';
import 'package:moive_app/model/movies_list/movies.dart';
import 'package:moive_app/services/api_constant.dart';
import 'package:moive_app/services/endpoint.dart';

class MovieService {
  static Future<List<Movies>> fetchMovies({String? genre}) async {
    final uri = Uri.parse(
      'https://${ApiConstant.baseUrl}/api/v2'
          '${Endpoint.endPointOfListMovie}'
          '${genre != null ? '?genre=$genre' : ''}',
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final model = MoiveModel.fromJson(
        jsonDecode(response.body),
      );
      return model.data?.movies ?? [];
    } else {
      throw Exception(
        'Failed to load movies: ${response.statusCode}',
      );
    }
  }

  static Future<Movies> fetchMovieById(int movieId) async {
    final uri = Uri.parse(
      'https://${ApiConstant
          .baseUrl}/api/v2/movie_details.json?movie_id=$movieId',
    );
    final response = await http.get(uri);
    print('MOVIE DETAILS URL: $uri');
    print('STATUS CODE: ${response.statusCode}');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final movieData = json['data']['movie'];
      return Movies.fromJson(movieData);
    }
    else {
      throw Exception(
        'Failed to load movie: ${response.statusCode}',
      );
    }
  }
}
