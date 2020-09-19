import 'package:Chess/utils/square.dart';
import 'package:Chess/screens/game-widgets/piece.dart';

class Move {
  final Piece piece;
  final SquareNumber destination;

  Move({this.piece, this.destination});
}
