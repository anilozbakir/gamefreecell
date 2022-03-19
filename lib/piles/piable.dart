import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:ui' as d;
import "package:flame/components.dart" as cmp;
import "../card.dart" as FreeCellCard;
import "piable.dart";

//there is three piles in freecell game
enum PileType { FREECELL, FILEDCELL, SORTEDCELL }

abstract class Piable {
  static Map<String, Piable> freeCellPiles = {};
  static void initFreeCellGame() {}
  int checkRegion(Vector2 position);
  List<FreeCellCard.Card> dragCards(FreeCellCard.Card card);
  List<FreeCellCard.Card> dropCards(FreeCellCard.Card card);
  int getMax();
  PileType getType();
}
