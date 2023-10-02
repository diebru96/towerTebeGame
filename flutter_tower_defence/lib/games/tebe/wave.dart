import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_tower_defence/games/attack_house.dart';

class WaveComponent extends SpriteComponent with HasGameRef<AttackHouse>{
WaveComponent({required this.startPosition});
  Vector2 startPosition;
  late Vector2 _velocity;
  double speed=900;
  

  @override
  FutureOr<void> onLoad() async{
    await super.onLoad();

    sprite=await gameRef.loadSprite("wave.png");
    position=startPosition;
    height=100;
    width=150;
    anchor = Anchor.center;
    _velocity=  Vector2(-0.02, -0.1) * speed;

    add(CircleHitbox());



  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _velocity * dt;
  }
}