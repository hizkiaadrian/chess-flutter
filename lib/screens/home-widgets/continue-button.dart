import 'package:Chess/constants/routes.dart';
import 'package:Chess/game-engine/game-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) =>
          gameProvider.getMovesHistory().isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Continue', style: TextStyle(fontSize: 20.0)),
                    onPressed: () => Navigator.pushNamed(context, Routes.Game),
                  ),
                )
              : Container(),
    );
  }
}
