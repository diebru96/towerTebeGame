import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_tower_defence/games/attack_house.dart';

class BulletComponent extends SpriteComponent with HasGameRef<AttackHouse>{
BulletComponent({required this.startPosition});
  Vector2 startPosition;
  late Vector2 _velocity;
  double speed=2500;
  

  @override
  FutureOr<void> onLoad() async{
    await super.onLoad();

    sprite=await gameRef.loadSprite("bullet.png");
    position=startPosition;
    height=12;
    width=12;
    anchor = Anchor.center;
    _velocity=  Vector2(    (Random().nextInt(15) *0.01)  - 0.075, -0.1) * speed;

    add(CircleHitbox());

    

  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _velocity * dt;
  }
}