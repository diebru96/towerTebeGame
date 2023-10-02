import 'dart:async' as aync_pack;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_tower_defence/games/attack_house.dart';
import 'package:flutter_tower_defence/games/tebe/bullet.dart';
import 'package:flutter_tower_defence/main.dart';
import 'package:flutter_tower_defence/singleton.dart';

class TebeShooterComponent extends SpriteComponent with HasGameRef<AttackHouse>, CollisionCallbacks{
   aync_pack.Timer? t; 
  TebeShooterComponent({required this.placement});
PositionalInfo placement;
  @override
  aync_pack.FutureOr<void> onLoad() async{
    await super.onLoad();

    sprite=await gameRef.loadSprite("cannon.png");
    position=placement.position;
    height=100;
    width=100;
    anchor = Anchor.center;
        add(CircleHitbox());


        t=aync_pack.Timer.periodic(const Duration(milliseconds: 400), (timer) {  

     BulletComponent bullet= BulletComponent(startPosition: position);
      parent!.add(bullet);
     aync_pack.Future.delayed(const Duration(milliseconds: 2000)).then((_) => parent!.remove(bullet));
});
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

      removeFromParent();
      other.removeFromParent();     
    }


    @override
  void onRemove() {
        singleton.gridSpace[placement.x_mat][placement.y_mat]=true;
    singleton.gridStream.sink.add(singleton.gridSpace);
    super.onRemove();
  }
  }


