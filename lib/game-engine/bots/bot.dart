import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/game-engine/provider/typedefs/board-state.dart';
import 'package:Chess/game-engine/provider/typedefs/move.dart';
import 'package:Chess/game-engine/utils/player.dart';

abstract class Bot {
  Move makeMove(BoardState boardState, Player botColor);

  Piece choosePieceForPromotion(BoardState boardState, Player botColor);
}
