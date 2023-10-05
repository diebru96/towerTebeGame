import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_tower_defence/games/attack_house.dart';
import 'package:flutter_tower_defence/games/components/tebe/bullet.dart';
import 'package:flutter_tower_defence/games/components/tebe/wave.dart';

class GhostComponent extends SpriteComponent with HasGameRef<AttackHouse>, CollisionCallbacks{
GhostComponent({required this.startPosition, required this.speed});
  Vector2 startPosition;
  late Vector2 _velocity;
  double speed=500;

  @override
  FutureOr<void> onLoad() async{
    await super.onLoad();

    sprite=await gameRef.loadSprite("ghost.png");
    position=startPosition;
    height=25;
    width=25;
    anchor = Anchor.center;
    _velocity=  Vector2(0, 0.2) * speed;

    add(CircleHitbox());


  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _velocity * dt;
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if(other is WaveComponent || other is BulletComponent )
    {
      removeFromParent();
    }
  }
}