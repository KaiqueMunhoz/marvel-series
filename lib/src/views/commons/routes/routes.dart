import 'package:flutter/material.dart';
import 'package:marvel_series/src/views/commons/routes/routes.strings.dart';
import 'package:marvel_series/src/views/home/home.page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  RoutesStrings.home: (_) => Home(),
};
