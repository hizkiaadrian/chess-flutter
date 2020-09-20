import 'package:Chess/game-engine/game-provider.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FabMenu extends StatefulWidget {
  @override
  _FabMenuState createState() => _FabMenuState();
}

class _FabMenuState extends State<FabMenu> with SingleTickerProviderStateMixin {
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
              bubbleColor: Colors.blue,
              icon: Icons.undo,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                print("Undo");
              },
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
