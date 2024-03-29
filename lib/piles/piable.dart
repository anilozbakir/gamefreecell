import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:ui' as d;
import "package:flame/components.dart" as cmp;
import 'package:gamefreecell/piles/filed_pile.dart';
import 'package:gamefreecell/piles/sorted_pile.dart';
import "../card.dart" as FreeCellCard;
import "piable.dart";
import "freecell_pile.dart";

//there is three piles in freecell game
enum PileType { FREECELL, FILEDCELL, SORTEDCELL }

abstract class Piable {
  static Map<PileType, String> pileNames = {
    PileType.FREECELL: "FREECELL",
    PileType.FILEDCELL: "FILEDCELL",
    PileType.SORTEDCELL: "SORTEDCELL"
  };
  static Map<String, Piable> allPiles = {};
  //static Map<PileType, int> pileTypeIndex = {};
  static void initFreeCellGame() {
    var v = FreeCellPile.Pile(index: 1);
    for (int i = 0; i < v.constants.depthx; i++) {
      FreeCellPile f = FreeCellPile.Pile(index: i);
      String pileName = (pileNames[PileType.FREECELL] ?? "FREECELL");
      pileName += "_" + i.toString();
      f.name = pileName;
      allPiles[pileName] = f;
      print(" ${f.name} : start ${f.start}   end ${f.end}");
    }
    var v2 = FiledPile.Pile(index: 1);

    for (int i = 0; i < v2.constants.depthx; i++) {
      FiledPile f = FiledPile.Pile(index: i);
      String pileName = (pileNames[PileType.FILEDCELL] ?? "FILEDCELL");
      pileName += "_" + i.toString();
      f.name = pileName;
      allPiles[pileName] = f;
      print(" ${f.name} : start ${f.start}   end ${f.end}");
    }
    var v3 = SortedCell.Pile(index: 1);
    for (int i = 0; i < v3.constants.depthx; i++) {
      SortedCell f = SortedCell.Pile(index: i);
      String pileName = (pileNames[PileType.SORTEDCELL] ?? "SORTEDCELL");
      pileName += "_" + i.toString();
      f.name = pileName;
      allPiles[pileName] = f;
      print(" ${f.name} : start ${f.start}   end ${f.end}");
    }
  }

  bool checkRegion(Vector2 position);

  Vector2 getStartPoint();
  Vector2 getEndPoint();
  bool dropCards(List<FreeCellCard.Card> card);
  bool add(FreeCellCard.Card card);
  FreeCellCard.Card getChild(int index);
  List<FreeCellCard.Card> getChildren();
  bool removeChild(FreeCellCard.Card card);
  int getMax();
  PileType getType();
  int length();
  FreeCellCard.Card getPlaceHolder();
  //void setFlameGame(FlameGame game);
  void reDraw();
}
