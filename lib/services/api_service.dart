import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:into_movies/model/movie_model.dart';
import 'api_config.dart';

Future<List<Movie>> fetchMovies() async {
  final response = await http.get(Uri.parse(
    '${ApiConfig.baseUrl}/trending/movie/day?api_key=${ApiConfig.apiKey}',
  ));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> results = data['results'];
    return results.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch movies');
  }
}
