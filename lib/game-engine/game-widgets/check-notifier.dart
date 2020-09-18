import 'package:Chess/game-engine/game-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckNotifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) => Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
        child: Text(
          gameProvider.isCheck ? "CHECK" : "${gameProvider.playerColor}",
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
