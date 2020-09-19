import 'package:Chess/game-engine/game-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckNotifier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
        builder: (context, gameProvider, child) => Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                gameProvider.isChecked() ? "CHECK" : "",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.red,
                ),
              ),
            ));
  }
}
