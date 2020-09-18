import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/game-engine/move-history.dart';
import 'package:Chess/game-engine/utils/square.dart';

class BoardState {
  Map<SquareNumber, Piece> piecePosition;
  List<MoveHistory> movesHistory;

  BoardState({this.piecePosition, this.movesHistory});
}
