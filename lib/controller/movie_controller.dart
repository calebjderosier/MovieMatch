import 'package:get/get.dart';
import 'package:movie_match/network/movie.dart';

class MovieController extends GetxController {

  final List<Movie> _movies = [
    Movie(
        id: 1,
        title: 'Lord of the Rings',
        releaseDate: "1",
        posterPath:
            "https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg"),
    Movie(
        id: 2,
        title: 'Encanto',
        releaseDate: "12",
        posterPath:
            "https://m.media-amazon.com/images/I/71noGMUal1S._AC_SL1100_.jpg"),
    Movie(
        id: 3,
        title: 'Spider-Man: No Way Home',
        releaseDate: "123",
        posterPath:
            "https://m.media-amazon.com/images/M/MV5BZWMyYzFjYTYtNTRjYi00OGExLWE2YzgtOGRmYjAxZTU3NzBiXkEyXkFqcGdeQXVyMzQ0MzA0NTM@._V1_FMjpg_UX1000_.jpg"),
    Movie(
        id: 4,
        title: 'Batman',
        releaseDate: "1234",
        posterPath:
            "https://sportshub.cbsistatic.com/i/2022/01/26/c77b5cd2-e1db-4e45-9049-8eaa1b9a7cd0/the-batman.jpg?auto=webp&width=1200&height=1778&crop=0.675:1,smart"),
  ]; 

  List<Movie> get movies {
    return [..._movies];
  }
}
