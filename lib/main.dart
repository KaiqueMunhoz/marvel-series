import 'package:flutter/material.dart';
import 'package:marvel_series/src/views/commons/routes/routes.dart';
import 'package:marvel_series/src/views/commons/routes/routes.strings.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Series',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RoutesStrings.home,
      routes: routes,
    );
  }
}
