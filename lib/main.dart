import 'package:Chess/constants/config.dart';
import 'package:Chess/constants/routes.dart';
import 'package:Chess/game-engine/provider/game-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final ColorPalette palette = ColorPalette(
    whiteSquare: Colors.brown[300],
    blackSquare: Colors.brown,
    selectedSquareBorder: Colors.deepPurpleAccent,
    availableMovesSquareOverlay: Colors.amberAccent.withOpacity(0.5));

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameProvider>(
      create: (_) => GameProvider(),
      builder: (context, child) => MaterialApp(
        title: appTitle,
        builder: (context, child) => child,
        initialRoute: Routes.Home,
        routes: Routes.getRoutes(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
