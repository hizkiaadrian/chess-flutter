import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/dialogs/promotion-dialog.dart';
import 'package:Chess/game-engine/utils/player.dart';
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
