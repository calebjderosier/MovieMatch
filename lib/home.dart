import 'package:flutter/material.dart';

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
  String _movieImgUrl = 'https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg';
  String _movieTitle = 'Lord of the Rings';

  // Add this movie to liked array
  void _swipedRight() {
    setState(() {
      // TODO: add this movie to 'liked' array
      // ignore: avoid_print
      print('MatchMovie pressed');
    });
  }

  // Skip this movie
  void _swipedLeft() {
    setState(() {
      // TODO: skip this movie
      // ignore: avoid_print
      print('NextMovie pressed');
    });
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
            child: buildMovieItem(
              _movieImgUrl,
              _movieTitle,
              context
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                ),
                onPressed: _swipedLeft,
                child: const Icon(Icons.close),
              ),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
Column buildMovieItem(String imgUrl, String title, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          border: Border.all(
            width: 4, color: Theme.of(context).scaffoldBackgroundColor,
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
            fit: BoxFit.cover, image: NetworkImage(imgUrl)
          )
        ),
      ),
      const SizedBox(
        height: 35,
      ),
      Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      const SizedBox(
        height: 35,
      ),
    ],
  );
}
