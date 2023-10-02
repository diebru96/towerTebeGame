import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter_tower_defence/games/attack_house.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<AttackHouse>{
  @override
  FutureOr<void> onLoad() async{
    await super.onLoad();

    sprite=await gameRef.loadSprite("grass.jpg");
    size=gameRef.size;

  }


}