import 'package:Chess/routes.dart';
import 'package:Chess/screens/game.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chess Mobile',
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Chess Mobile'),
            backgroundColor: Colors.primaries[0],
            elevation: 0,
            centerTitle: true,
          ),
          body: child,
        );
      },
      initialRoute: Routes.Home,
      routes: Routes.getRoutes(),
    );
  }
}
