import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/game-engine/provider/typedefs/move.dart';
import 'package:Chess/game-engine/utils/square.dart';

class BoardState {
  Map<SquareNumber, Piece> piecePosition;
  List<Move> movesHistory;

  BoardState({this.piecePosition, this.movesHistory});
}
