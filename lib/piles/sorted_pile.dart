import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:ui' as d;
import "package:flame/components.dart" as cmp;
import '../card.dart' as FreeCellCard;
import 'piable.dart';

class SortedCell implements Piable {
  static int pileDepth = 1;
  static int pileCount = 4;
  static Vector2? pileTypeStart = Vector2(300, 0);
  static Vector2 stepx = Vector2(150, 0);
  static Vector2 stepy = Vector2(0, 0);
  Vector2 start = Vector2(0, 0);
  Vector2 end = Vector2(0, 0);
  int index = 0;
  PileType type = PileType.SORTEDCELL;
  List<FreeCellCard.Card>? children;
  String? name;
  SortedCell({required this.index}) {
    children = List.generate(0, (index) => FreeCellCard.Card());
  }
  SortedCell.Pile({required this.index}) {
    children = List.generate(0, (index) => FreeCellCard.Card());
    this.start = pileTypeStart! + Vector2(stepx.x * index.toDouble(), 0);
    this.end = pileTypeStart! +
        Vector2(stepx.x * (index + 1).toDouble(), 0) +
        Vector2(0, stepy.y * this.getMax().toDouble() + 150.0);
  }

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
  bool dropCards(List<FreeCellCard.Card> card) {
    // TODO: implement dropCards
    throw UnimplementedError();
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
    return start;
  }

  @override
  Vector2 getStartPoint() {
    return end;
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
}
