import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vestago_task/home_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return _materialRoute(const HomeScreen());
      default:
        return _materialRoute(const HomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
