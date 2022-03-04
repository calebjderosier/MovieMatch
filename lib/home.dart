import 'package:flutter/material.dart';
import 'package:movie_match/network/Movie.dart';
import 'dart:math';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'content.dart';

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
    _moviesToDisplay.shuffle();
    _currentMovie = _moviesToDisplay[0];
    for (int i = 0; i < _moviesToDisplay.length; i++) {
      _swipeItems.add(SwipeItem(
        content: Content(
            text: _moviesToDisplay[i].title,
            image: Image.network(_moviesToDisplay[i].posterPath)),
        likeAction: _swipedRight,
        nopeAction: _swipedLeft,
        superlikeAction: null,
        onSlideUpdate: null,
      ));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  int _currentIndex = 0;
  late Movie _currentMovie;
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
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
  void _updateIndex() {
    setState(() {
      _currentIndex++;
      _currentMovie = _moviesToDisplay[_currentIndex];
      if (_currentIndex == _moviesToDisplay.length) {
        _showEmptyAlert();
      }
    });
  }

  void _showAlert(String title, Icon icon, Color backgroundColor) {
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
                  TextSpan(text: title),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 2.0),
                      child: icon,
                    ),
                  ),
                ],
              ),
            )),
            backgroundColor: backgroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          );
        });
  }

  // Display the "no more movies" alert
  void _showEmptyAlert() {
    _showAlert('No more movies! ',
        Icon(Icons.hourglass_empty, color: Colors.white), Colors.blue);
  }

  // Display the "matched" alert
  void _showMatchedAlert() {
    _showAlert('Matched! ', Icon(Icons.star, color: Colors.white), Colors.pink);
  }

  // Add this movie to liked array
  void _swipedRight() {
    setState(() {
      _myMovies.add(_currentMovie.id);
      if (_partnerMovies.contains(_currentMovie.id)) _showMatchedAlert();
      _updateIndex();
    });
  }

  // Skip this movie
  void _swipedLeft() {
    _updateIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.4,
            child: SwipeCards(
              matchEngine: _matchEngine!,
              itemBuilder: (BuildContext context, int index) {
                /// returns container of stacked movie cards
                return Container(
                    alignment: Alignment.center,
                    child: _swipeItems[index].content.image);
              },
              onStackFinished: () {
                print("onStackFinished");
              },
              itemChanged: (SwipeItem item, int index) {
                print("item: ${item.content.text}, index: $index");
              },
              upSwipeAllowed: false,
              fillSpace: false,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 35,
          ),
          Center(
            child: Text(
              _currentMovie.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
