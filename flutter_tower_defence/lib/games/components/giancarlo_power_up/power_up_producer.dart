import 'dart:async' as aync_pack;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flutter_tower_defence/games/attack_house.dart';
import 'package:flutter_tower_defence/games/components/coins/coin.dart';
import 'package:flutter_tower_defence/games/components/giancarlo_power_up/power_up.dart';
import 'package:flutter_tower_defence/singleton.dart';


import '../../../main.dart';

class PowerUpProducerComponent extends SpriteComponent with HasGameRef<AttackHouse>, CollisionCallbacks{
PowerUpProducerComponent({required this.placement});
PositionalInfo placement;
 aync_pack.Timer? t; 
  @override
  aync_pack.FutureOr<void> onLoad() async{
    await super.onLoad();

    sprite=await gameRef.loadSprite("tancre.png");
    position=placement.position;
    height=50;
    width=50;
    anchor = Anchor.center;
    add(CircleHitbox());




    t=aync_pack.Timer.periodic(const Duration(milliseconds: 5000), (timer) {  
              singleton.coinAmount += 50;
      singleton.coinStream.sink.add(singleton.coinAmount);

     PowerUpComponent pu= PowerUpComponent(startPosition: position);
      parent!.add(pu);
     aync_pack.Future.delayed(const Duration(milliseconds: 800)).then((_) => parent!.remove(pu));
});
    
    
  }


@override
  void onRemove() {
    super.onRemove();
    if(t!=null)
    {
      t!.cancel();
    }

    singleton.gridSpace[placement.x_mat][placement.y_mat]=true;
    singleton.gridStream.sink.add(singleton.gridSpace);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

      removeFromParent();
      other.removeFromParent();     
    }
  

}