import 'package:Chess/constants/config.dart';
import 'package:Chess/screens/home-widgets/home-buttons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: true,
      ),
      body: Container(
        decoration: homeBackground,
        child: Row(
          children: [
            Flexible(flex: 1, child: Container()),
            Flexible(
              flex: 4,
              child: HomeButtons(),
            ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration homeBackground = BoxDecoration(
  image: DecorationImage(
    image: ExactAssetImage(
      'assets/home_wallpaper.jpeg',
    ),
    fit: BoxFit.cover,
  ),
);
