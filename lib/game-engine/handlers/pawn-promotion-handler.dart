import 'package:Chess/screens/game-widgets/piece.dart';
import 'package:Chess/screens/dialogs/promotion-dialog.dart';
import 'package:Chess/utils/player.dart';
import 'package:Chess/main.dart';
import 'package:flutter/material.dart';

Future<Piece> choosePieceForPromotion(Player player) async {
  return await showDialog<Piece>(
      context: navigatorKey.currentState.overlay.context,
      builder: (_) => PromotionDialog(
            player: player,
          ),
      barrierDismissible: false);
}
