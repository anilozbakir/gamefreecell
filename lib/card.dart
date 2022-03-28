//import 'dart:html';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'dart:ui' as d;
import "package:flame/components.dart" as cmp;
import 'piles/piable.dart';
import 'piles/filed_pile.dart';
import 'dart:developer' as dv;

enum CardType { hearts, clubs, diamonds, spades }
Map<CardType, int> CardIndex = {
  CardType.hearts: 2,
  CardType.clubs: 0,
  CardType.diamonds: 1,
  CardType.spades: 3,
};

Map<CardType, List<CardType>> Succeding = {
  CardType.hearts: [
    CardType.clubs,
    CardType.spades,
  ],
  CardType.clubs: [
    CardType.hearts,
    CardType.diamonds,
  ],
  CardType.diamonds: [
    CardType.clubs,
    CardType.spades,
  ],
  CardType.spades: [
    CardType.hearts,
    CardType.diamonds,
  ],
};

class Card extends SpriteComponent with cmp.Draggable {
  static Sprite? mainPicture;
  static Vector? imageDimensions;
  static Vector2 positionOfFileCels = Vector2(0, 0);
  static loadMainImage() async {
    //for performance load the main picture once.
    //then cut and move the frame window for what color you want.
    mainPicture =
        await Sprite.load("playcards.png", srcSize: Vector2(168.5, 241));
  }

  // Future<void>? onLoad() async {
  //   await super.onLoad();
  // }

  String? pilename;
  Vector2 _diff = Vector2(0, 0); //the difference of dragging point from
  //the top left.it will be applied to all the children when dragging.
  int card = 0;
  int cardNumber = 0;
  int pileIndex = 0;
  List<Card>? childList;
  Card() : super() {
    var size1 = Vector2(168, 240);
    super.size = size1;
    var Pos1 = Vector2(size1.x * cardNumber, size1.y * card);
    sprite = Sprite(mainPicture!.image, srcPosition: Pos1, srcSize: size1);
  }
  Card.Pile(
      {required this.card, required this.cardNumber, required this.pileIndex}) {
    var size1 = Vector2(168, 240);
    super.size = size1;
    var Pos1 = Vector2(size1.x * cardNumber, size1.y * card);
    sprite = Sprite(mainPicture!.image, srcPosition: Pos1, srcSize: size1);
    scale = Vector2(0.5, 0.5);
  }
  @override
  bool onDragStart(int pointerId, DragStartInfo info) {
    print("cards position ${position}");
    print("Player drag start on ${info.raw.globalPosition}");
    _diff.x = position.x - info.raw.globalPosition.dx;
    _diff.y = position.y - info.raw.globalPosition.dy;
    return false;
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    // final localCoords = event.eventPosition.game;
    position.x = _diff.x + info.raw.globalPosition.dx;
    position.y = _diff.y + info.raw.globalPosition.dy;
    // dv.log(
    //     "${info.raw.globalPosition.dx} ${info.raw.globalPosition.dy}  is on region  ");
    Piable.allPiles.forEach((key, value) {
      if (value.checkRegion(
          Vector2(info.raw.globalPosition.dx, info.raw.globalPosition.dy))) {
        dv.log(
            "${info.raw.globalPosition.dx} ${info.raw.globalPosition.dy}  is on region $key ");
      }
    });
    // print(
    //     "position ${position.x} ${position.y}   change ${info.raw.globalPosition.dx} ${info.raw.globalPosition.dy}");
    return false;
  }

  @override
  bool onDragEnd(int pointerId, DragEndInfo event) {
    // if (position.x > positionOfFileCels.x &&
    //     position.y > positionOfFileCels.y) {
    //   int positionx = (position.x / positionOfFileCels.x).toInt() *
    //       positionOfFileCels.x.toInt();
    //   //   Vector2 newPosition = print("Player drag end on ");
    // }
    return false;
  }

  @override
  bool onDragCancel(int pointerId) {
    //dragDeltaPosition = null;
    return false;
  }

  bool GetChildren() {
    var pile = Piable.allPiles[pilename];
    if (pile!.getMax() == 1) return true; //maximum dep
    childList = List.generate(0, (index) => Card());
    childList!.add(this);
    for (int i = pileIndex; i < (pile.length() - 1); i++) {
      var next = pile.getChild(i + 1);
      if (succedingOK2(next)) {
        childList!.add(next);
      } else {
        childList!.clear();
        return false;
      }
    }
    return true;
  }

  bool succedingOK2(Card next) {
    return succedingOK(next.cardNumber, next.card);
  }

  bool succedingOK(int cardIndex, int cardType) {
    var myCardType = CardType.values[card];
    var otherType = CardType.values[cardType];
    var listSuc = Succeding[myCardType];
    if (listSuc!.contains(otherType) &&
        (cardNumber > 0 && (cardIndex == (cardNumber - 1)))) {
      return true;
    }

    return false;
  }
}
