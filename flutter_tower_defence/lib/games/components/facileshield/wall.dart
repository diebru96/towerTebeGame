import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tower_defence/games/attack_house.dart';
import 'package:flutter_tower_defence/games/components/enemies.dart';
import 'package:flutter_tower_defence/singleton.dart';

class WallComponent extends SpriteComponent with HasGameRef<AttackHouse>{
WallComponent({required this.image, required this.placement});
PositionalInfo placement;

  String image="wall.png";
  @override
  FutureOr<void> onLoad() async{
    await super.onLoad();

    sprite=await gameRef.loadSprite(image);
    position=Vector2(gameRef.size.x/2, placement.position.y);
    height=90;
    width=270;
    anchor = Anchor.center;


  }





}