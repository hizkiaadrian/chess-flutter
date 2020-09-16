import 'package:Chess/main.dart';
import 'package:Chess/screens/game.dart';
import 'package:Chess/screens/home.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static const String Home = '/';
  static const String Game = '/game';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.Home: (context) => HomePage(),
      Routes.Game: (context) => GameScreen(),
    };
  }
}
