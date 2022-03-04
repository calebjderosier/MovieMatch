import 'package:flutter/material.dart';
import 'package:movie_match/home.dart';

void main() {
  runApp(const HomePage());
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
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://cdn.shopify.com/s/files/1/0652/4771/files/LOTR_REG_FINALS_Burgos_1024x1024.png?v=1611070010',
              width: 256,
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
          ],
        ),
      ),
    );
  }
}
