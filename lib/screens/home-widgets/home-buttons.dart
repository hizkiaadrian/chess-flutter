import 'package:Chess/screens/home-widgets/continue-button.dart';
import 'package:Chess/screens/home-widgets/hero-title.dart';
import 'package:Chess/screens/home-widgets/start-new-game-button.dart';
import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(),
            flex: 1,
          ),
          Flexible(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                HeroTitle(),
                StartNewGameButton(),
                ContinueButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
