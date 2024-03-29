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
import "constants.dart";

enum CardType { diamonds, spades, hearts, clubs }

Map<CardType, int> CardIndex = {
  CardType.hearts: 2,
  CardType.clubs: 3,
  CardType.diamonds: 0,
  CardType.spades: 1,
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
        await Sprite.load("playingcards2.png", srcSize: Vector2(168.5, 241));
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
  Vector2? start;
  Card() : super() {
    var size1 = Constants.constants[defaultTargetPlatform]!.cardSize;
    super.size = size1;
    var Pos1 = Vector2(size1.x * cardNumber, size1.y * card);
    sprite = Sprite(mainPicture!.image, srcPosition: Pos1, srcSize: size1);
  }
  Card.Pile({
    required this.card,
    required this.cardNumber,
    required this.pileIndex,
  }) {
    // required this.start
    var size1 = Constants.constants[defaultTargetPlatform]!.cardSize;
    super.size = size1;
    var Pos1 = Vector2(size1.x * transfromCard(cardNumber), size1.y * card);
    sprite = Sprite(mainPicture!.image, srcPosition: Pos1, srcSize: size1);
    scale = Constants.constants[defaultTargetPlatform]!.scale;
  }
  int transfromCard(int card) {
    if (card < 13 && card > 0) return card - 1;
    if (card == 0) return 12;
    return card;
  }

  @override
  bool onDragStart(int pointerId, DragStartInfo info) {
    print("cards position ${position}");
    print("Player drag start on ${info.raw.globalPosition}");
    //save the difference in holding position as a parameter
    _diff.x = position.x - info.raw.globalPosition.dx;
    _diff.y = position.y - info.raw.globalPosition.dy;
    getChildren();
    dv.log("got children with ${childList!.length} elements");

    dv.log(
        "pile has ${Piable.allPiles[pilename]!.getChildren().length} elements");
    return false;
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    // final localCoords = event.eventPosition.game;
    //move all the cards in childlist(including itself)
    int index = 0;
    childList!.forEach((element) {
      //element.position = *;
      element.position.x = _diff.x + info.raw.globalPosition.dx;
      element.position.y =
          _diff.y + info.raw.globalPosition.dy + 30 * index.toDouble();
      index++;
    });

    // dv.log(
    //     "${info.raw.globalPosition.dx} ${info.raw.globalPosition.dy}  is on region  ");
    // Piable.allPiles.forEach((key, value) {
    //   if (value.checkRegion(
    //       Vector2(info.raw.globalPosition.dx, info.raw.globalPosition.dy))) {
    //     dv.log(
    //         "${info.raw.globalPosition.dx} ${info.raw.globalPosition.dy}  is on region $key ");
    //   }
    // });
    // print(
    //     "position ${position.x} ${position.y}   change ${info.raw.globalPosition.dx} ${info.raw.globalPosition.dy}");
    return false;
  }

  @override
  bool onDragEnd(int pointerId, DragEndInfo event) {
    if (childList!.isNotEmpty) {
      bool found = false;
      Piable.allPiles.forEach((key, value) {
        if (!found &&
            value.checkRegion(
                Vector2(position.x - _diff.x, position.y - _diff.y))) {
          dv.log("found drag at $key 's region ");
          found = true;
          //     "${info.raw.globalPosition.dx} ${info.raw.globalPosition.dy}  is on region $key ");
          if (!value.dropCards(childList!)) {
            dv.log("drop not succesfull ");
            Piable.allPiles[pilename]!.reDraw();
          }
        }
      });
      if (!found) Piable.allPiles[pilename]!.reDraw();
    } else {
      dv.log("no children to drag");
      Piable.allPiles[pilename]!.reDraw();
    }
    ;
    return false;
  }

  @override
  bool onDragCancel(int pointerId) {
    //dragDeltaPosition = null;
    return false;
  }

//check if the cards under the dragged card is ordered
//if so return get the cards as children
  bool getChildren() {
    var pile = Piable.allPiles[pilename];
    if (pile!.getMax() == 1) return true; //maximum dep
    childList = List.generate(0, (index) => Card());
    int priority = 30;
    childList!.add(this);
    this.changePriorityWithoutResorting(priority);
    var present = this;
    dv.log("adding itself with ${pileIndex} index");
    for (int i = pileIndex; i < (pile.length() - 1); i++) {
      priority--;
      var next = pile.getChild(i + 1);
      dv.log("trying ${i + 1} index for  proper children");
      if (present.succedingOK2(next)) {
        childList!.add(next);
        this.changePriorityWithoutResorting(priority);
        present = next;
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
    bool carTypeTrue = listSuc!.contains(otherType);
    bool cardNumberTrue = cardIndex == (cardNumber - 1);
    dv.log(" bool  type1 $myCardType  type2 $otherType number $cardNumberTrue");
    if (carTypeTrue && (cardNumber > 0 && cardNumberTrue)) {
      return true;
    }

    return false;
  }
}
