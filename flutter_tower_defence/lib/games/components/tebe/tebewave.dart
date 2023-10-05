import 'dart:async' as aync_pack;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_tower_defence/games/attack_house.dart';
import 'package:flutter_tower_defence/games/components/enemyComponents/thiefs.dart';
import 'package:flutter_tower_defence/games/components/tebe/wave.dart';
import 'package:flutter_tower_defence/main.dart';
import 'package:flutter_tower_defence/singleton.dart';

class TebeWaveComponent extends SpriteComponent with HasGameRef<AttackHouse>, CollisionCallbacks{
   aync_pack.Timer? t; 
  TebeWaveComponent({required this.placement});
PositionalInfo placement;
  @override
  aync_pack.FutureOr<void> onLoad() async{
    await super.onLoad();

    sprite=await gameRef.loadSprite("tebe.png");
    position=placement.position;
    height=50;
    width=50;
    anchor = Anchor.center;
    add(CircleHitbox());

        t=aync_pack.Timer.periodic(const Duration(milliseconds: 9000), (timer) {  
              singleton.coinAmount += 50;
      singleton.coinStream.sink.add(singleton.coinAmount);

     WaveComponent wave= WaveComponent(startPosition: position);
      parent!.add(wave);
     aync_pack.Future.delayed(const Duration(milliseconds: 2000)).then((_) => parent!.remove(wave));
});
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    print("COLLLLISOOOOO");
    super.onCollision(intersectionPoints, other);
      if(other is ThiefComponent){
      removeFromParent();
      other.removeFromParent();
      }     
    }
  
@override
  void onRemove() {
        singleton.gridSpace[placement.x_mat][placement.y_mat]=true;
    singleton.gridStream.sink.add(singleton.gridSpace);
    super.onRemove();
  }


}