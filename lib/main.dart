import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Match',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Movie Match'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = [
    "Step Brothers",
    "Shrek",
    "Lord of the Rings",
    "Spider Man",
  ];

  List<String> _movies = [
    'https://i5.walmartimages.com/asr/e8a4a5eb-f5d9-4eef-adb7-ee817f0a5411_1.34810fce84207f7a56601f50510c9e4c.jpeg',
    'https://images.squarespace-cdn.com/content/v1/5acd17597c93273e08da4786/1547847934765-ZOU5KGSHYT6UVL6O5E5J/Shrek+Poster.png',
    'https://cdn.shopify.com/s/files/1/0652/4771/files/LOTR_REG_FINALS_Burgos_1024x1024.png?v=1611070010',
    'https://i5.walmartimages.com/asr/e8a4a5eb-f5d9-4eef-adb7-ee817f0a5411_1.34810fce84207f7a56601f50510c9e4c.jpeg',
  ];

  String _movieTitle = "Title";
  String _movieDesc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], image: Image.network('${_movies[i]}')),
          likeAction: () {
            print("LIKED");
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text(""),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            print("LEFT SWIPE");
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text(""),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text(""),
              duration: Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  // 
  void _matchMovie() {
    setState(() {
      // TODO: match this movie
      // ignore: avoid_print
      print('MatchMovie pressed');
    });
  }

  //
  void _nextMovie() {
    setState(() {
      // TODO: skip this movie
      // ignore: avoid_print
      print('NextMovie pressed');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.4,
              child: SwipeCards(
                matchEngine: _matchEngine!,
                itemBuilder: (BuildContext context, int index) {
                  /// returns container of stacked movie cards
                  return Container(
                    alignment: Alignment.center,
                    child: _swipeItems[index].content.image
                  );
                },
                onStackFinished: () {
                  _scaffoldKey.currentState!.showSnackBar(SnackBar(
                    content: Text("Stack Finished"),
                    duration: Duration(milliseconds: 500),
                  ));
                },
                itemChanged: (SwipeItem item, int index) {
                  print("item: ${item.content.text}, index: $index");
                },
                upSwipeAllowed: false,
                fillSpace: false,
              ),
            ),
            Text(
                _movieTitle,
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                '_movieDesc',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                child: const Icon(Icons.close),
                onPressed: _nextMovie,
              ),
              TextButton(
                child: const Icon(Icons.check),
                onPressed: _matchMovie,
              ),
        ]),
      ),
    );
  }
}
