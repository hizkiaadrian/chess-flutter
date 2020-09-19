import 'package:Chess/dialogs/choose-player.dart';
import 'package:Chess/dialogs/start-new-game-prompt.dart';
import 'package:Chess/game-engine/provider/game-provider.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartNewGameButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) => RaisedButton(
        padding: EdgeInsets.all(15.0),
        child: Text(
          'Start a new 1P game',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () async {
          if (gameProvider.getMovesHistory().isEmpty) {
            showDialog<Player>(context: context, child: ChoosePlayerDialog());
          } else if (await shouldStartNewGame(context)) {
            gameProvider.initializeProviderState();
            showDialog<Player>(context: context, child: ChoosePlayerDialog());
          }
        },
      ),
    );
  }
}

Future<bool> shouldStartNewGame(BuildContext context) async => await showDialog(
    context: context, child: StartNewGamePrompt(), barrierDismissible: false);
