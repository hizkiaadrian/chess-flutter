import 'package:Chess/constants/config.dart';
import 'package:Chess/dialogs/choose-player.dart';
import 'package:Chess/game-engine/game-provider.dart';
import 'package:Chess/dialogs/start-new-game-prompt.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) => Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(
                'assets/home_wallpaper.jpeg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 4,
                child: Padding(
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                "Chess Mobile",
                                style: TextStyle(
                                    fontSize: 45.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            RaisedButton(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Start a new game',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              onPressed: () async {
                                if (gameProvider
                                    .boardState.movesHistory.isEmpty) {
                                  await showDialog<Player>(
                                      context: context,
                                      child: ChoosePlayerDialog(),
                                      barrierDismissible: true);
                                  Navigator.pushNamed(context, '/game');
                                } else if (await showDialog<bool>(
                                  context: context,
                                  child: StartNewGamePrompt(),
                                  barrierDismissible: false,
                                )) {
                                  gameProvider.restartGame();
                                  Navigator.pushNamed(context, '/game');
                                }
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            if (gameProvider.boardState.movesHistory.isNotEmpty)
                              RaisedButton(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'Continue',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/game'),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
