import 'package:Chess/screens/game-widgets/piece.dart';
import 'package:Chess/game-engine/typedefs/move.dart';
import 'package:Chess/utils/square.dart';

class BoardState {
  Map<SquareNumber, Piece> piecePosition;
  List<Move> movesHistory;

  BoardState({this.piecePosition, this.movesHistory});
}
