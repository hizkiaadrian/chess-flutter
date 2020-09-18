import 'package:Chess/constants/config.dart';
import 'package:Chess/game-engine/game-widgets/piece.dart';
import 'package:Chess/game-engine/game-widgets/pieces/bishop.dart';
import 'package:Chess/game-engine/game-widgets/pieces/knight.dart';
import 'package:Chess/game-engine/game-widgets/pieces/queen.dart';
import 'package:Chess/game-engine/game-widgets/pieces/rook.dart';
import 'package:Chess/game-engine/utils/image.dart';
import 'package:Chess/game-engine/utils/piece.dart';
import 'package:Chess/game-engine/utils/player.dart';
import 'package:flutter/material.dart';

class PromotionDialog extends StatefulWidget {
  final Player player;

  PromotionDialog({this.player});

  @override
  _PromotionDialogState createState() => _PromotionDialogState();
}

class _PromotionDialogState extends State<PromotionDialog> {
  final Key key = UniqueKey();

  List<Piece> pieceChoices;
  Piece chosenPiece;

  void setChosenPiece(Piece piece) {
    setState(() => chosenPiece = piece);
  }

  Border renderBorderIfSelected(PieceName pieceName) =>
      chosenPiece?.pieceName == pieceName
          ? Border.all(color: Colors.green, width: 2.0)
          : null;

  void submit() =>
      chosenPiece == null ? null : Navigator.pop(context, chosenPiece);

  @override
  Widget build(BuildContext context) {
    pieceChoices = [
      Queen(
        player: widget.player,
        key: key,
      ),
      Rook(
        player: widget.player,
        key: key,
      ),
      Bishop(
        player: widget.player,
        key: key,
      ),
      Knight(
        player: widget.player,
        key: key,
      )
    ];

    return AlertDialog(
      title: Text("Promote to?"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: pieceChoices
            .map((piece) => Material(
                  child: InkWell(
                    onTap: () => setChosenPiece(piece),
                    child: Container(
                      height: squareSize,
                      width: squareSize,
                      decoration: BoxDecoration(
                          border: renderBorderIfSelected(piece?.pieceName)),
                      child: getSprite(widget.player, piece.pieceName),
                    ),
                  ),
                ))
            .toList(),
      ),
      actions: [FlatButton(onPressed: () => submit(), child: Text("Confirm"))],
    );
  }
}
