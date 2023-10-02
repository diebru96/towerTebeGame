import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter_tower_defence/games/attack_house.dart';

class CoinComponent extends SpriteComponent with HasGameRef<AttackHouse>{
CoinComponent({required this.startPosition});
  Vector2 startPosition;
  late Vector2 _velocity;
  double speed=900;

  @override
  FutureOr<void> onLoad() async{
    await super.onLoad();

    sprite=await gameRef.loadSprite("coin.png");
    position=startPosition;
    height=25;
    width=25;
    anchor = Anchor.center;
    _velocity=  Vector2(0, -0.1) * speed;



  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _velocity * dt;
  }
}