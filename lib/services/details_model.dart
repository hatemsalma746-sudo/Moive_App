import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moive_app/model/movies_details/movie_details.dart';
import 'package:moive_app/services/api_constant.dart';
import 'package:moive_app/services/endpoint.dart';

class DetailsModel {

  // https://movies-api.accel.li/api/v2
  // /movie_details.json
  // ?movie_id=78127
  // &with_images=true
  // &with_cast=true

  static Future<MovieDetails> getMovieDetails(int movieId) async {
    Uri url = Uri.https(
      ApiConstant.baseUrl,
      Endpoint.endPointOfDetails,
      {
        'movie_id': movieId.toString(),
        'with_images': 'true',
        'with_cast': 'true',
      },
    );
    print("URL: $url");
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load movie details');
    }
    print("URL: $url");
    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");


    final jsonData = jsonDecode(response.body);

    print(MovieDetails.fromJson(
      jsonData['data']['movie'],
    ));
    print('MOVIE ID: ${jsonData['data']['movie']['id']}');
    print('TITLE: ${jsonData['data']['movie']['title']}');
    print('RATING: ${jsonData['data']['movie']['rating']}');
    print('RATING TYPE: ${jsonData['data']['movie']['rating'].runtimeType}');

    return MovieDetails.fromJson(
      jsonData['data']['movie'],
    );


  }
}