import 'package:flutter/material.dart';
import 'package:marvel_series/features/series/core/routes/routes.strings.dart';
import 'package:marvel_series/features/series/presentation/pages/home.page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  RoutesStrings.home: (_) => Home(),
};
