import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tower_defence/games/attack_house.dart';
import 'package:flutter_tower_defence/games/components/enemyComponents/thiefs.dart';
import 'package:flutter_tower_defence/games/components/facileshield/wall.dart';
import 'package:flutter_tower_defence/main.dart';
import 'package:flutter_tower_defence/singleton.dart';

class FacileShieldComponent extends SpriteComponent with HasGameRef<AttackHouse>, CollisionCallbacks{
  FacileShieldComponent({required this.placement});
PositionalInfo placement;
  WallComponent? wall;
  int wallHealth=400;
  @override
  FutureOr<void> onLoad() async{
    await super.onLoad();
    singleton.gridSpace[placement.x_mat]=[false, false, false, false];
    singleton.gridStream.sink.add(singleton.gridSpace);
    sprite=await gameRef.loadSprite("line.png");
    position=Vector2(gameRef.size.x/2, placement.position.y);
    height=80;
    width=270;
    anchor = Anchor.center;
    add(RectangleHitbox());
    wall= WallComponent(image: "wall.png", placement: placement);
    parent!.add(wall!);

  }



  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    Singleton s = Singleton.instance;
    print("muro colliso");
    if(other is ThiefComponent)
    {


  if(wallHealth>0)
  {

  wallHealth=  wallHealth- 50;


if(wallHealth>300)
{

       wall!.add(ColorEffect(
      Colors.red,
      const Offset(
        0.0,
        0.5,
      ), // Means, applies from 0% to 50% of the color
      EffectController(
        duration: 0.3,
      ),
    ));

            Future.delayed(const Duration(milliseconds: 300)).then((value) => wall!..add(ColorEffect(
      Colors.red,
      const Offset(
        0.5,
        0,
      ), // Means, applies from 0% to 50% of the color
      EffectController(
        duration: 0.2,
      ),
    )));
          
}
/*
else
if(wallHealth==300){
  if(wall!=null)
   { parent!.remove(wall!);}
   wall=WallComponent(image: "muro0danneggiato.png", placement: placement);
   parent!.add(wall!);
}
else
if(wallHealth==200){
    if(wall!=null)
   { parent!.remove(wall!);}
   wall=WallComponent(image: "muro1danneggiato.png", placement: placement);
   parent!.add(wall!);
    
}
else
if(wallHealth==150){
      if(wall!=null)
   { parent!.remove(wall!);}
   wall=WallComponent(image: "muro2danneggiato.png", placement: placement);
   parent!.add(wall!);
}
else
if(wallHealth==100){
      if(wall!=null)
   { parent!.remove(wall!);}
   wall=WallComponent(image: "muro3danneggiato.png", placement: placement);
   parent!.add(wall!);
}
else
if(wallHealth==50){
          if(wall!=null)
   { parent!.remove(wall!);}
   wall=WallComponent(image: "muro4danneggiato.png", placement: placement);
   parent!.add(wall!);
}
*/
        }

  // if(wallHealth-1<=0)
  //   {
  //               if(wall!=null)
  //  { parent!.remove(wall!);}
  //     removeFromParent();
  //     wallHealth=400;
  //   }
    
  
//   s.wallHealthStream.sink.add(wallHealth.toDouble());

      other.removeFromParent();     
    }
  }

@override
  void onRemove() {

    singleton.gridSpace[placement.x_mat]=[true, true, true, true];
    singleton.gridStream.sink.add(singleton.gridSpace);
    super.onRemove();
  }


bool replace1=true;
bool replace2=true;
bool replace3=true;
bool replace4=true;
bool replace5=true;



  @override
  void update(double dt) {

if(wallHealth==300 && replace1){
  replace1=false;
  if(wall!=null)
   { parent!.remove(wall!);}
   wall=WallComponent(image: "muro0danneggiato.png", placement: placement);
   parent!.add(wall!);
}
else
if(wallHealth==200 && replace2){
  replace2=false;
    if(wall!=null)
   { parent!.remove(wall!);}
   wall=WallComponent(image: "muro1danneggiato.png", placement: placement);
   parent!.add(wall!);
    
}
else
if(wallHealth==150 && replace3){
  replace3=false;
      if(wall!=null)
   { parent!.remove(wall!);}
   wall=WallComponent(image: "muro2danneggiato.png", placement: placement);
   parent!.add(wall!);
}
else
if(wallHealth==100 && replace4){
  replace4=false;
      if(wall!=null)
   { parent!.remove(wall!);}
   wall=WallComponent(image: "muro3danneggiato.png", placement: placement);
   parent!.add(wall!);
}
else
if(wallHealth==50 && replace5){
  replace5=false;
          if(wall!=null)
   { parent!.remove(wall!);}
   wall=WallComponent(image: "muro4danneggiato.png", placement: placement);
   parent!.add(wall!);
}

        

  if(wallHealth-1<=0)
    {
                if(wall!=null)
   { parent!.remove(wall!);}
      removeFromParent();
   }

    super.update(dt);
  }

}