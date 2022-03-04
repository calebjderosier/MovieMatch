import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_match/network/movie.dart';

class MovieController extends GetxController {

  final List<Movie> _movies = [];

  @override
  void onInit() {
    super.onInit();

    rootBundle.loadString('assets/json/movies.json').then((value) => 
      movieModelFromJson(value).forEach((element) { _movies.insert(0, element); })
    );
  }

  List<Movie> get movies {
    return [..._movies];
  }
}
