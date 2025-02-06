import 'package:flutter/material.dart';

import 'package:news961/pages/not_found_page.dart';
import 'package:news961/pages/splach_page.dart';
import 'package:news961/router/route_constants.dart';

class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) =>  SplashPage());
     
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}
