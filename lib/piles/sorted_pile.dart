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
import "../constants.dart";

class SortedCell implements Piable {
  var constants = PileProperties.filePile(TargetPlatform.android);

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
    constants = PileProperties.sortedPile(defaultTargetPlatform);
    children = List.generate(0, (index) => FreeCellCard.Card());
    this.start =
        constants.pileBase + Vector2(constants.stepx.x * index.toDouble(), 0);
    this.end = constants.pileBase +
        Vector2(constants.stepx.x * (index + 1).toDouble(), 0) +
        Vector2(
            0,
            constants.stepx.y * this.getMax().toDouble() +
                constants.constants.cardSize.y);
    cardType = SortedCardIndex[index];
    placeHolder =
        FreeCellCard.Card.Pile(card: 2, cardNumber: 13, pileIndex: -1);
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
      myelement = newCards.first; //if pile is empty it will accept
    //with proper condition no matter what
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
    int freePiles = constants.depthy - children!.length;
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
    return constants.depthy;
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
    placeHolder!.position = start + constants.stepy * cardIndex.toDouble();
    placeHolder!.changePriorityWithoutResorting(cardIndex);
    children!.forEach((element) {
      element.changePriorityWithoutResorting(cardIndex);
      element.position = start + constants.stepy * cardIndex.toDouble();
      cardIndex++;
    });
  }

  @override
  FreeCellCard.Card getPlaceHolder() {
    // TODO: implement getPlaceHolder
    return placeHolder!;
  }
}
