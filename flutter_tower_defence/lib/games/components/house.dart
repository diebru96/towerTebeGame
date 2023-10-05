import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_noise/flame_noise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tower_defence/games/attack_house.dart';
import 'package:flutter_tower_defence/games/components/enemyComponents/ghost.dart';
import 'package:flutter_tower_defence/games/components/enemyComponents/killer.dart';
import 'package:flutter_tower_defence/games/components/enemyComponents/thiefs.dart';
import 'package:flutter_tower_defence/singleton.dart';

class HouseComponent extends SpriteComponent with HasGameRef<AttackHouse>, CollisionCallbacks{
  @override
  FutureOr<void> onLoad() async{
    await super.onLoad();

    sprite=await gameRef.loadSprite("home.png");
        position=Vector2(gameRef.size.x/2, gameRef.size.y -180);
    height=150;
    width=250;
    anchor = Anchor.center;
    add(RectangleHitbox());



  }



  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    Singleton s = Singleton.instance;
    print("colliso");
    if(other is ThiefComponent || other is KillerComponent || other is GhostComponent)
    {
      gameRef.camera.viewfinder.add(
          MoveEffect.by(
            Vector2(20, 20),
            PerlinNoiseEffectController(duration: 0.5, frequency: 800),
          ),
        );



        if(s.healtWidth>0)
        {


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
          
          if(other is KillerComponent)
          {
            s.healtWidth =  s.healtWidth- 100;
          }
          else
          {
           s.healtWidth=  s.healtWidth- 50;
          }
        }

  if(s.healtWidth-1<=0)
    {
      //removeFromParent();
      add(TextComponent(text: "GAME OVER"));
    }
           s.healtStream.sink.add(s.healtWidth);

      other.removeFromParent();     
    }
  }


}