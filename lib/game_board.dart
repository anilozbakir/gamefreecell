import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import "package:flame/game.dart";

// import "package:flame/game.dart";
import 'package:flame/input.dart';
// import 'package:flame/sprite.dart';

// import "dart:math";

// import 'dart:developer' as dv;
// import "RecTouch.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamefreecell/piles/piable.dart';
import 'dart:developer' as dv;
import "card.dart" as FreeCellCard;
import "package:flame/components.dart" as cmp;
import "dart:math";
import '../piles/filed_pile.dart';

class GameBoard extends PositionComponent {
  @override
  // onLoad() async {
  //   await super.onLoad();
  //   await gCArd.Card.loadMainImage();
  //   // size = Vector2(400, 600);
  //   // var c = gCArd.Card(sizeof: Vector2(100, 100));
  //   // c.position = Vector2(400, 400);
  //   // add(c);
  // }
  // var positionOfFileCels = Vector2(50, 150);
  // List<FreeCellCard.Card>? freeCells;
  // List<List<FreeCellCard.Card>>? fileCells;

  // List<List<FreeCellCard.Card>>? fileOrdered;
  GameBoard({size}) : super(size: size) {
    dealCardPile();

    ///FreeCellCard.Card.positionOfFileCels = positionOfFileCels;
  }
  dealCardPile() {
    List<int> cardsRandom = List.generate(52, (index) => index);

    // var fileCellCol = List.generate(0, (element) => FreeCellCard.Card());
    // fileCells = List.generate(6, (index) => fileCellCol);
    var r = Random();
    int index = 0;
    String pileName = "FILEDCELL_";
    while (index < 52 && cardsRandom.isNotEmpty) {
      var rnd2 = r.nextInt(cardsRandom.length);
      var rnd = cardsRandom[rnd2];
      var place = getColRow(
          rnd, 13); //get the number (ace,2,3,4) and type(clubs,hearts)
      var place2 = getColRow(index, 9);
      var freecard = FreeCellCard.Card.Pile(
          card: place.y.toInt(),
          cardNumber: place.x.toInt(),
          pileIndex: place2.x.toInt());

      String pileNameFinal = pileName + place2.y.toInt().toString();
      // var pile = FiledPile(name: fileCells![index ~/ 9], cardIndex: index);
      freecard.pilename = pileName;

      cardsRandom.remove(rnd);
      //  dv.log("${cardsRandom.length}");
      var targetPile = Piable.allPiles[pileNameFinal];
      targetPile!.add(freecard);
      index++;
    }
  }

  Vector2 getColRow(int index, int col) {
    var v = Vector2((index % col).toDouble(), (index ~/ col).toDouble());
    return v;
  }
}
