import 'dart:async' as aync_pack;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tower_defence/games/attack_house.dart';
import 'package:flutter_tower_defence/games/components/enemyComponents/ghost.dart';
import 'package:flutter_tower_defence/games/components/enemyComponents/thiefs.dart';
import 'package:flutter_tower_defence/games/components/facileshield/facileshield.dart';
import 'package:flutter_tower_defence/games/components/facileshield/wall.dart';
import 'package:flutter_tower_defence/games/components/house.dart';
import 'package:flutter_tower_defence/games/components/tebe/bullet.dart';
import 'package:flutter_tower_defence/games/components/tebe/tebeshooter.dart';
import 'package:flutter_tower_defence/games/components/tebe/wave.dart';

class KillerComponent extends SpriteComponent with HasGameRef<AttackHouse>, CollisionCallbacks{
KillerComponent({required this.startPosition, required this.speed,  this.health=3});
  Vector2 startPosition;
  late Vector2 _velocity;
  double speed=300;
  int health=3;

  bool stopAtWall=false;
  aync_pack.Timer? wallTimer;

  @override
  aync_pack.FutureOr<void> onLoad() async{
    await super.onLoad();

    sprite=await gameRef.loadSprite("killer.png");
    position=startPosition;
    height=50;
    width=50;
    anchor = Anchor.center;
    _velocity=  Vector2(0, 0.2) * speed;

    add(CircleHitbox());


  }

  @override
  void update(double dt) {

    super.update(dt);

      if(!stopAtWall){
          position += _velocity * dt;
      }
  }


    @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if(other is! FacileShieldComponent && other is! ThiefComponent && other is! GhostComponent)
    {
      if(health>0){
      health-=1;
                  add(ColorEffect(
      Colors.red,
      const Offset(
        0.0,
        0.5,
      ), // Means, applies from 0% to 50% of the color
      EffectController(
        duration: 0.3,
      ),
    ));

            Future.delayed( const Duration(milliseconds: 300)).then((value) => add(ColorEffect(
      Colors.red,
      const Offset(
        0.5,
        0,
      ), // Means, applies from 0% to 50% of the color
      EffectController(
        duration: 0.2,
      ),
    )));


    if(other is! HouseComponent && other is! WaveComponent){
        other.removeFromParent();
    }
    }
        else
       {
         removeFromParent();
       }



    }
    else
    {
if(other is FacileShieldComponent){
if(!stopAtWall){
      stopAtWall=true;

      wallTimer=aync_pack.Timer.periodic((const Duration(milliseconds: 750)), ((timer){
        (other).wallHealth-=25;

        if((other).wallHealth<= 1)
        {
          stopAtWall=false;
          if(wallTimer!=null)
          {wallTimer!.cancel();}
        }
       add(ColorEffect(
      Colors.purple,
      const Offset(
        0.0,
        0.5,
      ), // Means, applies from 0% to 50% of the color
      EffectController(
        duration: 0.15,
      ),
    ));

            Future.delayed( const Duration(milliseconds: 150)).then((value) => add(ColorEffect(
      const Color.fromARGB(255, 207, 150, 218),
      const Offset(
        0.5,
        0,
      ), // Means, applies from 0% to 50% of the color
      EffectController(
        duration: 0.1,
      ),
    )));
      }));
 
}
}

    }
  }
}