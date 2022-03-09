import 'package:flutter/material.dart';
import 'package:movie_match/network/Movie.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:developer' as log;

import 'network/APIKey.dart';

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

  late Future<List<Movie>> movies;

  @override
  void initState() {
    super.initState();
    _currentMovie = _moviesToDisplay[Random().nextInt(_moviesToDisplay.length)];
    movies = fetchPopularMovies();
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
  ];
  
  final List<int> _partnerMovies = [634649, 568124];
  final List<int> _myMovies = [];

  // Sets the current movie to another in the random list.
  Movie _getNextMovie() {
    setState(() {
      _moviesToDisplay.removeWhere((element) => element.id == _currentMovie.id);
      int _nextId = Random().nextInt(_moviesToDisplay.length);

      _currentMovie = _moviesToDisplay[_nextId]; // TODO set to actual next movie ID
      // ignore: avoid_print
      print('newId is $_nextId');
    });
    return _moviesToDisplay[_currentMovie.id];
  }

  // Display the "matched" alert
  void _showMatchedAlert() {
    // TODO: display matched alert
    // ignore: avoid_print
    print('match alert displayed for movie ${_currentMovie.id}');
  }

  // Add this movie to liked array
  void _swipedRight() {
    setState(() {
      _myMovies.add(_currentMovie.id);
      if (_partnerMovies.contains(_currentMovie.id)) _showMatchedAlert();
      // ignore: avoid_print
      print('user swiped right on ${_currentMovie.id}');
      _getNextMovie();
    });
  }

  // Skip this movie
  void _swipedLeft() {
    // ignore: avoid_print
    print('user swiped left on ${_currentMovie.id}');
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
          Center(
            child: FutureBuilder<List<Movie>>(
              future: movies,
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Movie>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Text(snapshot.data!.first.title);
                } else {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Text('Empty');
                }
              },

            ),
          ),
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

Future<List<Movie>> fetchPopularMovies() async {
    var response =
        await http.get(Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=f6547b65f627de34d9371c04eb570048"));
    if (response.statusCode == 200) {
      var data = response.body;
      return movieModelFromJson(data);
    } else {
      throw Exception();
    }
  }
