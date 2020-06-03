import 'package:flutter/material.dart';
import 'package:marvel_series/src/views/commons/routes/routes.dart';
import 'package:marvel_series/src/views/commons/routes/routes.strings.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(Main());
}

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
