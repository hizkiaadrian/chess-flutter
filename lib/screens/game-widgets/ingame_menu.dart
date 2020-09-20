import 'package:Chess/game-engine/game-provider.dart';
import 'package:Chess/utils/square.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InGameMenu extends StatefulWidget {
  @override
  _InGameMenuState createState() => _InGameMenuState();
}

class _InGameMenuState extends State<InGameMenu>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) => FloatingActionBubble(
          items: <Bubble>[
            Bubble(
              title: "Undo",
              iconColor: Colors.white,
              bubbleColor: gameProvider.getPreviousBoardState() == null
                  ? Colors.grey
                  : Colors.blue,
              icon: Icons.undo,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () => gameProvider.getPreviousBoardState() == null
                  ? null
                  : gameProvider.undoMove(),
            ),
          ],
          onPress: () {
            _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward();
          },
          icon: AnimatedIcons.menu_close,
          iconColor: Colors.blue,
          animation: _animation),
    );
  }
}
