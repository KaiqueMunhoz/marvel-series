import 'package:flutter/material.dart';
import 'package:marvel_series/src/views/base/base.page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Center(
          child: Container(
        child: Text("Algo"),
      )),
    );
  }
}
