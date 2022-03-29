import 'package:flame/input.dart';
import 'package:flame/src/game/flame_game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:ui' as d;
import "package:flame/components.dart" as cmp;
import '../card.dart' as FreeCellCard;
import 'piable.dart';
import 'dart:developer' as dv;

//this type is the main piles of freecell that are randomly
//placed on screen
class FiledPile implements Piable {
  static int pileDepth = 20;
  static int pileCount = 6;
  static Vector2 pileTypeStart = Vector2(50, 150);
  static Vector2 stepx = Vector2(150, 0);
  static Vector2 stepy = Vector2(0, 30);
  Vector2 start = Vector2(50, 150);
  Vector2 end = Vector2(0, 0);
  int index = 0;
  PileType type = PileType.FILEDCELL;
  List<FreeCellCard.Card>? children;
  String? name;
  FreeCellCard.Card? placeHolder;
  FiledPile({required this.index}) {
    children = List.generate(0, (index) => FreeCellCard.Card());
  }
  FiledPile.Pile({required this.index}) {
    children = List.generate(0, (index) => FreeCellCard.Card());
    start = pileTypeStart! + Vector2(stepx.x * index.toDouble(), 0);
    end = pileTypeStart! +
        Vector2(stepx.x * (index + 1).toDouble(), 0) +
        Vector2(0, stepy.y * this.getMax().toDouble() + 150.0);
    placeHolder = FreeCellCard.Card.Pile(card: 4, cardNumber: 2, pileIndex: -1);
  }

  @override
  bool checkRegion(Vector2 position) {
    Vector2 start = getStartPoint();
    Vector2 end = getEndPoint();

    if (position.x > start.x && position.x < end.x) {
      if (position.y > start.y && position.y < end.y) {
        //TODO place the card in the pile and create a last move
        //info to be used in undo
        return true;
      }
    }
    return false;
  }

  @override
  bool dropCards(List<FreeCellCard.Card> newCards) {
    int freePiles = pileDepth - children!.length;
    var cardLast;
    if (children!.isEmpty) {
      cardLast = newCards.last;
    } else
      cardLast = children!.last;
    if (children!.isEmpty ||
        (freePiles >= 0 && cardLast.succedingOK2(newCards.first))) {
      var oldpile = newCards.first.pilename;
      dv.log("ok to put them in new pile $name");
      newCards.forEach((element) {
        Piable.allPiles[oldpile]!.removeChild(element);
        dv.log(
            "removed ${element.card}  ${element.cardNumber}   from $oldpile");
        element.pilename = name;
        element.pileIndex = children!.length;
        children!.add(element);
      });
      reDraw();
      return true;
    }
    return false;
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
  bool add(FreeCellCard.Card card) {
    int freePiles = pileDepth - children!.length;
    if (freePiles > 0) {
      this.children!.add(card);
      int cardIndex = 0;
      children!.forEach((element) {
        element.position = start + stepy * cardIndex.toDouble();
        cardIndex++;
      });
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
    return children![index];
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
  FreeCellCard.Card getPlaceHolder() {
    // TODO: implement getPlaceHolder
    return placeHolder!;
  }
}
