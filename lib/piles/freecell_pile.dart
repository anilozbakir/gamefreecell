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

class FreeCellPile implements Piable {
  static int pileDepth = 1;
  static int pileCount = 4;
  static Vector2? pileTypeStart = Vector2(50, 0); //start of this pile type
  static Vector2 stepx = Vector2(150, 0); //pile types step for index
  static Vector2 stepy =
      Vector2(0, 0); //pile types step in y direction since freecell type
  Vector2 start = Vector2(0, 0);
  Vector2 end = Vector2(0, 0);
  int index = 0;
  PileType type = PileType.FREECELL;
  List<FreeCellCard.Card>? children;
  String? name;
  FlameGame? parentGame;
  FreeCellPile({required this.index}) {
    children = List.generate(0, (index) => FreeCellCard.Card());
  }
  FreeCellPile.Pile({required this.index}) {
    children = List.generate(0, (index) => FreeCellCard.Card());
    start = pileTypeStart! + Vector2(stepx.x * index.toDouble(), 0);
    end = pileTypeStart! +
        Vector2(stepx.x * (index + 1).toDouble(), 0) +
        Vector2(0, stepy.y * this.getMax().toDouble() + 150.0);
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
    if (children!.isEmpty && newCards.length == 1) {
      var oldpile = newCards.first.pilename;
      newCards.forEach((element) {
        Piable.allPiles[oldpile]!.removeChild(element);
        element.pilename = name;
        element.pileIndex = children!.length;
        children!.add(element);
      });
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

  void reDraw() {
    int cardIndex = 0;
    children!.forEach((element) {
      element.changePriorityWithoutResorting(children!.length - cardIndex);
      element.position = start + stepy * cardIndex.toDouble();
      cardIndex++;
    });
  }

  @override
  void setFlameGame(FlameGame game) {
    parentGame = game;
  }
}
