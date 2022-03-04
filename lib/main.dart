import 'package:flutter/material.dart';

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
  String _movieTitle = "Title";
  String _movieDesc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

  // Mark this movie as a match.
  void _matchMovie() {
    setState(() {
      // TODO: match this movie
      // ignore: avoid_print
      print('MatchMovie pressed');
    });
  }

  // Skip to the next movie. 
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
          children: <Widget>[
            Image.network(
              'https://cdn.shopify.com/s/files/1/0652/4771/files/LOTR_REG_FINALS_Burgos_1024x1024.png?v=1611070010', // placeholder movie poster
              width: 256,
            ),
            Text(
              _movieTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              _movieDesc,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Center(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      child: const Icon(Icons.close),
                      onPressed: _nextMovie,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 48, right: 24),
                      ),
                    )
                  ),
                  Expanded(
                    child: TextButton(
                      child: const Icon(Icons.check),
                      onPressed: _matchMovie,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 24, right: 48),
                      ),
                    ),
                  ),
                ]
              )
            )
          ],
        ),
      ),
    );
  }
}
