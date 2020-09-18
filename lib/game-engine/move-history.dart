import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/game-engine/utils/square.dart';

class MoveHistory {
  final Piece piece;
  final SquareNumber destination;

  MoveHistory({this.piece, this.destination});
}
