import 'package:Chess/constants/routes.dart';
import 'package:Chess/dialogs/choose-game-mode.dart';
import 'package:Chess/dialogs/choose-player.dart';
import 'package:Chess/dialogs/start-new-game-prompt.dart';
import 'package:Chess/game-engine/provider/game-provider.dart';
import 'package:Chess/game-engine/provider/typedefs/game-mode.dart';
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
          'Start a new game',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () async {
          if (gameProvider.getMovesHistory().isEmpty) {
            GameMode chosenGameMode = await chooseGameMode(context);
            if (chosenGameMode == GameMode.AgainstBot)
              showDialog<Player>(context: context, child: ChoosePlayerDialog());
            if (chosenGameMode == GameMode.TwoPlayers)
              Navigator.pushNamed(context, Routes.Game);
          } else if (await shouldStartNewGame(context)) {
            gameProvider.initializeProviderState();
            GameMode chosenGameMode = await chooseGameMode(context);
            if (chosenGameMode == GameMode.AgainstBot)
              showDialog<Player>(context: context, child: ChoosePlayerDialog());
            if (chosenGameMode == GameMode.TwoPlayers)
              Navigator.pushNamed(context, Routes.Game);
          }
        },
      ),
    );
  }
}

Future<bool> shouldStartNewGame(BuildContext context) async => await showDialog(
    context: context, child: StartNewGamePrompt(), barrierDismissible: false);

Future<GameMode> chooseGameMode(BuildContext context) async => await showDialog(
    context: context, child: ChooseGameModeDialog(), barrierDismissible: false);
