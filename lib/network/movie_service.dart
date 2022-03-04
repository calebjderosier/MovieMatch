import 'package:http/http.dart' as http;
import 'movie.dart';

class MovieService {
  static Future<List<Movie>> fetchPopularMovies() async {
    var response =
        await http.get(Uri.parse("https://api.themoviedb.org/3/movie/popular"));
    if (response.statusCode == 200) {
      var data = response.body;
      return movieModelFromJson(data);
    } else {
      throw Exception();
    }
  }
}
