import 'package:Chess/constants/config.dart';
import 'package:Chess/game-engine/game-provider.dart';
import 'package:Chess/game-engine/typedefs/game-mode.dart';
import 'package:Chess/screens/game-widgets/board.dart';
import 'package:Chess/screens/game-widgets/check-notifier.dart';
import 'package:Chess/screens/game-widgets/ingame_menu.dart';
import 'package:Chess/screens/game-widgets/timer.dart';
import 'package:Chess/screens/game-widgets/turn-notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) => Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          centerTitle: true,
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (gameProvider.getGameMode() == GameMode.TwoPlayersTimedMode)
                TurnTimer(),
              Expanded(child: ChessBoard()),
              CheckNotifier(),
              TurnNotifier(),
            ],
          ),
        ),
        floatingActionButton: InGameMenu(),
      ),
    );
  }
}
