import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final AppBar appBar;

  BasePage({@required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        child: child,
      ),
    );
  }
}
