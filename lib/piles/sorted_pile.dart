import 'package:flame/input.dart';
import 'package:flame/src/game/flame_game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:ui' as d;
import "package:flame/components.dart" as cmp;
import 'package:gamefreecell/game_board.dart';
import '../card.dart' as FreeCellCard;
import 'piable.dart';
import 'dart:developer' as dv;
import "package:gamefreecell/card.dart";

class SortedCell implements Piable {
  static int pileDepth = 1;
  static int pileCount = 4;
  static Vector2? pileTypeStart = Vector2(800, 0);
  static Vector2 stepx = Vector2(150, 0);
  static Vector2 stepy = Vector2(0, 0);
  Vector2 start = Vector2(0, 0);
  Vector2 end = Vector2(0, 0);
  int index = 0;
  PileType type = PileType.SORTEDCELL;
  CardType cardType = FreeCellCard.CardType.clubs;
  List<FreeCellCard.Card>? children;
  String? name;
  FreeCellCard.Card? placeHolder;
  List<CardType> SortedCardIndex = [
    CardType.hearts,
    CardType.diamonds,
    CardType.clubs,
    CardType.spades,
  ];
  SortedCell({required this.index}) {
    children = List.generate(0, (index) => FreeCellCard.Card());
  }
  SortedCell.Pile({required this.index}) {
    children = List.generate(0, (index) => FreeCellCard.Card());
    this.start = pileTypeStart! + Vector2(stepx.x * index.toDouble(), 0);
    this.end = pileTypeStart! +
        Vector2(stepx.x * (index + 1).toDouble(), 0) +
        Vector2(0, stepy.y * this.getMax().toDouble() + 150.0);
    cardType = SortedCardIndex[index];
    placeHolder = FreeCellCard.Card.Pile(card: 4, cardNumber: 2, pileIndex: -1);
  }

  @override
  bool checkRegion(Vector2 position) {
    // Vector2 start = getStartPoint();
    // Vector2 end = getEndPoint();

    if (position.x > start.x && position.x < end.x) {
      if (position.y > start.y && position.y < end.y) {
        //TODO place the card in the pile and create a last move
        //info to be used in undo
        dv.log("found for $name");
        return true;
      }
    }
    return false;
  }

  @override
  bool dropCards(List<FreeCellCard.Card> newCards) {
    var element = newCards.first;
    var myelement;
    if (children!.isEmpty)
      myelement = newCards!.first;
    else {
      myelement = children!.last;
    }
    var firstCondition = cardType == CardType.values[element.card];
    var generalCondition = element.cardNumber == (myelement.cardNumber + 1);
    dv.log("$name");
    dv.log("$firstCondition $generalCondition $cardType  ${element.card}");
    if (newCards.length == 1 &&
        firstCondition &&
        ((generalCondition) ||
            (children!.isEmpty && element.cardNumber == 0))) {
      var oldpile = newCards.first.pilename;

      Piable.allPiles[oldpile]!.removeChild(element);
      element.pilename = name;
      element.pileIndex = children!.length;
      children!.add(element);

      reDraw();
      return true;
    }
    return false;
  }

  bool add(FreeCellCard.Card card) {
    int freePiles = pileDepth - children!.length;
    if (freePiles > 0) {
      this.children!.add(card);
    } else
      return false;
    return true;
  }

  @override
  bool removeChild(FreeCellCard.Card card) {
    children!.remove(card);
    return true;
  }

  @override
  int getMax() {
    return pileDepth;
  }

  @override
  PileType getType() {
    return type;
  }

  @override
  Vector2 getEndPoint() {
    return end;
  }

  @override
  Vector2 getStartPoint() {
    return start;
  }

  @override
  FreeCellCard.Card getChild(int index) {
    return this.children![index];
  }

  @override
  int length() {
    return children!.length;
  }

  @override
  List<FreeCellCard.Card> getChildren() {
    return children!;
  }

  @override
  void reDraw() {
    int cardIndex = 0;
    placeHolder!.position = start + stepy * cardIndex.toDouble();
    placeHolder!.changePriorityWithoutResorting(cardIndex);
    children!.forEach((element) {
      element.changePriorityWithoutResorting(cardIndex);
      element.position = start + stepy * cardIndex.toDouble();
      cardIndex++;
    });
  }

  @override
  FreeCellCard.Card getPlaceHolder() {
    // TODO: implement getPlaceHolder
    return placeHolder!;
  }
}
