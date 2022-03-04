import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.green,
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.settings, color: Colors.green))
        ],
      ),
      body: Container(
          child: ListView(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        children: [
          Center(
            child: Text(
              'Choose a movie here',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
              child: buildMovieItem(
                  'https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg',
                  context)),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 50),
                ),
                onPressed: () {},
                child: Icon(Icons.close),
              ),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 50),
                ),
                onPressed: () {},
                child: Icon(Icons.check)
              )
            ],
          )
        ],
      )),
    );
  }
}

Stack buildMovieItem(String imgUrl, BuildContext context) {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
            border: Border.all(
                width: 4, color: Theme.of(context).scaffoldBackgroundColor),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 10),
              )
            ],
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(imgUrl))),
      )
    ],
  );
}
