import 'package:Chess/screens/game-widgets/piece.dart';
import 'package:Chess/game-engine/typedefs/board-state.dart';
import 'package:Chess/game-engine/typedefs/move.dart';
import 'package:Chess/utils/player.dart';

abstract class Bot {
  Move makeMove(BoardState boardState, Player botColor);

  Piece choosePieceForPromotion(BoardState boardState, Player botColor);
}
