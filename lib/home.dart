import 'package:flutter/material.dart';
import 'package:movie_match/network/Movie.dart';
import 'dart:math';

class MovieMatchApp extends StatelessWidget {
  const MovieMatchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Swipe right for movies you are interested in',
      home: ChooseMovies(),
    );
  }
}

class ChooseMovies extends StatefulWidget {
  @override
  _ChooseMoviesState createState() => _ChooseMoviesState();
}

class _ChooseMoviesState extends State<ChooseMovies> {
  @override
  void initState() {
    super.initState();
    _currentMovie = _moviesToDisplay[Random().nextInt(_moviesToDisplay.length)];
  }

  late Movie _currentMovie;
  final List<Movie> _moviesToDisplay = [
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
    Movie(
        id: 5,
        title: 'Shrek 2',
        releaseDate: "123",
        posterPath:
            "https://cdn.shopify.com/s/files/1/1416/8662/products/shrek_2_2004_original_film_art_5000x.jpg?v=1551894581"),
    Movie(
        id: 6,
        title: 'Harry Potter and the Chamber of Secrets',
        releaseDate: "123",
        posterPath:
            "https://m.media-amazon.com/images/M/MV5BMTcxODgwMDkxNV5BMl5BanBnXkFtZTYwMDk2MDg3._V1_FMjpg_UX1000_.jpg"),
    Movie(
        id: 7,
        title: 'Talladega Nights',
        releaseDate: "123",
        posterPath:
            "https://m.media-amazon.com/images/M/MV5BNzAzOTk1OTIyM15BMl5BanBnXkFtZTcwNDIzNTQzMQ@@._V1_.jpg"),
    Movie(
        id: 8,
        title: 'Bruce Almighty',
        releaseDate: "123",
        posterPath:
            "https://m.media-amazon.com/images/I/51fpx3kKQ8L._SY445_.jpg"),
    Movie(
        id: 9,
        title: 'Fantastic Beasts and Where to Find Them',
        releaseDate: "123",
        posterPath:
            "https://m.media-amazon.com/images/I/91PdOec4bFL._SL1500_.jpg"),
    Movie(
        id: 10,
        title: 'Matilda',
        releaseDate: "123",
        posterPath:
            "https://m.media-amazon.com/images/I/91mIVq8Lk9L._SL1500_.jpg"),
    Movie(
        id: 11,
        title: 'Mrs. Doubtfire',
        releaseDate: "123",
        posterPath:
            "https://lumiere-a.akamaihd.net/v1/images/image_ef98a49a.jpeg"),
    Movie(
        id: 12,
        title: 'Shrek',
        releaseDate: "123",
        posterPath:
            "https://m.media-amazon.com/images/M/MV5BOGZhM2FhNTItODAzNi00YjA0LWEyN2UtNjJlYWQzYzU1MDg5L2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_.jpg"),
  ];
  
  final List<int> _partnerMovies = [4, 5, 6, 8, 12, 10];
  final List<int> _myMovies = [];

  // Sets the current movie to another in the random list.
  Movie _getNextMovie() {
    setState(() {
      _moviesToDisplay.removeWhere((element) => element.id == _currentMovie.id);
      int _nextId = _moviesToDisplay.length > 0 ? Random().nextInt(_moviesToDisplay.length) : -1;

      if(_nextId != -1) {
        _currentMovie = _moviesToDisplay[_nextId];
      } else {
        _showEmptyAlert();
      }
    });
    return _moviesToDisplay[_currentMovie.id];
  }

  // Display the "no more movies" alert
  void _showEmptyAlert() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Center(
                child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                children: [
                  TextSpan(text: 'No more movies! '),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 2.0),
                      child: Icon(Icons.hourglass_empty, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )),
            backgroundColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          );
        });
  }

  // Display the "matched" alert
  void _showMatchedAlert() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Center(
                child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                children: [
                  TextSpan(text: 'Matched! '),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 2.0),
                      child: Icon(Icons.star, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )),
            backgroundColor: Colors.pink,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          );
        });
  }

  // Add this movie to liked array
  void _swipedRight() {
    setState(() {
      _myMovies.add(_currentMovie.id);
      if (_partnerMovies.contains(_currentMovie.id)) _showMatchedAlert();
      _getNextMovie();
    });
  }

  // Skip this movie
  void _swipedLeft() {
    _getNextMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(child: buildMovieItem(_currentMovie, context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                ),
                onPressed: _swipedLeft,
                child: const Icon(Icons.close),
              ),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                ),
                onPressed: _swipedRight,
                child: const Icon(Icons.check),
              )
            ],
          )
        ],
      ),
    );
  }
}

// Create a new movie item using the given imgUrl and title.
Column buildMovieItem(Movie movie, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 10),
              )
            ],
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(movie.posterPath))),
      ),
      const SizedBox(
        height: 35,
      ),
      Center(
        child: Text(
          movie.title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      const SizedBox(
        height: 35,
      ),
    ],
  );
}
