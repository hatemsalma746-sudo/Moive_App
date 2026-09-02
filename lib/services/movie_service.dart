import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moive_app/model/movies_list/moive_model.dart';
import 'package:moive_app/model/movies_list/movies.dart';
import 'package:moive_app/services/api_constant.dart';
import 'package:moive_app/services/endpoint.dart';

class MovieService {
  static Future<List<Movies>> fetchMovies({String? genre}) async {
    final url = Uri.parse(
      'https://${ApiConstant.baseUrl}${Endpoint
          .endPointOfListMovie}${genre != null ? '?genre=$genre' : ''}',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final model = MoiveModel.fromJson(jsonDecode(response.body));
      return model.data?.movies ?? [];
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }


  // https://movies-api.accel.li
  // /api/v2/list_movies.json
  // $query_term='marvel'

  static Future<List<Movies>> searchMoviesByQueryTerm(
      String queryTerm,
      ) async {
    final url = Uri.https(
      ApiConstant.baseUrl,
      Endpoint.endPointOfListMovie,
      {
        'query_term': queryTerm,
      },
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final model = MoiveModel.fromJson(responseBody);

      return model.data?.movies ?? [];
    } else {
      throw Exception(
        'Failed to search movies: ${response.statusCode}',
      );
    }
  }

}
