import 'package:http/http.dart' as http;

class MovieService {
  static Future<List<MoviesModel>> fetchPopularMovies() async {
    var response =
        await http.get(Uri.parse("https://api.themoviedb.org/3/movie/popular"));
    if (response.statusCode == 200) {
      var data = response.body;
      return productsModelFromJson(data);
    } else {
      throw Exception();
    }
  }
}
