import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:ui' as d;
import "package:flame/components.dart" as cmp;
import "../card.dart" as FreeCellCard;
import "piable.dart";

class FreeCellPile implements Piable {
  static int pileDepth = 1;
  static int pileCount = 4;
  Vector2 start = Vector2(0, 0);
  Vector2 end = Vector2(0, 0);
  int index;
  static Vector2 stepx = Vector2(0, 0);
  static Vector2 stepy = Vector2(0, 0);
  List<FreeCellCard.Card>? children;
  FreeCellPile({required this.index}) {
    children = List.generate(0, (index) => FreeCellCard.Card());
  }
  PileType type = PileType.FREECELL;

  @override
  bool checkRegion(Vector2 position) {
    Vector2 start = getStartPoint();
    Vector2 end = getEndPoint();

    if (position.x > start.x && position.x < end.x) {
      if (position.y > start.y && position.y < end.x) {
        //TODO place the card in the pile and create a last move
        //info to be used in undo
        return true;
      }
    }
    return false;
  }

  @override
  List<FreeCellCard.Card> startDrag(FreeCellCard.Card card) {
    return children! ?? List.generate(0, (index) => Card());
  }

  @override
  List<FreeCellCard.Card> dropCards(FreeCellCard.Card card) {
    if (children!.length < pileDepth) {
      children!.add(card);
    }
    return children! ?? List.generate(0, (index) => Card());
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
    // TODO: implement getEndPoint
    return start;
  }

  @override
  Vector2 getStartPoint() {
    // TODO: implement getStartPoint
    return end;
  }
}
