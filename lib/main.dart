import 'package:flutter/material.dart';
import 'package:paintom1/paint_page.dart';
import 'package:paintom1/temporary_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(),
        "/paintpage": (context) => PaintPage(),
        "/temporary_page": (context) => TemporaryPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paintom'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Next Page'),
              onPressed: () {
                Navigator.pushNamed(context, "/paintpage");
              },
            ),
            RaisedButton(
              child: Text('Fake Page'),
              onPressed: () {
                Navigator.pushNamed(context, "/temporary_page");
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
