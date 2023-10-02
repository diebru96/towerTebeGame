import 'dart:async';
import 'dart:math' as math;

import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tower_defence/games/components/background.dart';
import 'package:flutter_tower_defence/games/components/coins/coinmaker.dart';
import 'package:flutter_tower_defence/games/components/enemies.dart';
import 'package:flutter_tower_defence/games/components/facileshield/facileshield.dart';
import 'package:flutter_tower_defence/games/components/house.dart';
import 'package:flutter_tower_defence/games/tebe/tebeshooter.dart';
import 'package:flutter_tower_defence/games/tebe/tebewave.dart';
import 'package:flutter_tower_defence/main.dart';
import 'package:flutter_tower_defence/singleton.dart';

class AttackHouse extends FlameGame with HasCollisionDetection, TapCallbacks{
HouseComponent house= HouseComponent();

DefenceSpawn? selectedDefence;
  @override
  FutureOr<void> onLoad() async{
    await super.onLoad();

    add(BackgroundComponent());
    add(house);

    Timer.periodic(const Duration(milliseconds: 3500), (timer) {    
       add(EnemyComponent(startPosition: Vector2(math.Random().nextInt(200).toDouble()+100, math.Random().nextInt(200).toDouble() ), speed:math.Random().nextInt(300).toDouble()+ 300 ));
});


  Timer.periodic(const Duration(milliseconds: 4000), (timer) { 

    singleton.coinAmount += 50;
    singleton.coinStream.sink.add(singleton.coinAmount);
  });

  

  singleton.defenceSpawnStream.stream.listen((event) {

    if(event== DefenceSpawn.heal){
              house.add(ColorEffect(
      Colors.green,
      const Offset(
        0.0,
        0.5,
      ), // Means, applies from 0% to 50% of the color
      EffectController(
        duration: 0.4,
      ),
    ));

            Future.delayed(const Duration(milliseconds: 300)).then((value) => house..add(ColorEffect(
      Colors.green,
      const Offset(
        0.5,
        0,
      ), // Means, applies from 0% to 50% of the color
      EffectController(
        duration: 0.25,
      ),
    )));
          
    }
else
{
    singleton.showGrid.sink.add(true);
    selectedDefence= event;
}    

   });


singleton.spawnPosition.stream.listen((event){
  if(selectedDefence!=null){
   switch(selectedDefence){
    case DefenceSpawn.moneyProducer:
     add(CoinMakerComponent(placement: event));
    break;
    case DefenceSpawn.facileShield:
             add(FacileShieldComponent(placement: event));

    break;
    case DefenceSpawn.tebeWave:
         add(TebeWaveComponent(placement: event));

    break;
    case DefenceSpawn.tebeCannon:
         add(TebeShooterComponent(placement: event));

    break;
   
        
    default:
    break;
    }
  }
});

  }


 //@override
 //void render(Canvas canvas) {
 //      final paint = Paint()
 //    ..color = Colors.green
 //    ..strokeWidth = 2.0
 //    ..style = PaintingStyle.fill;

 //  // Example: Draw a rectangle on the canvas
 // final borderRadius = BorderRadius.circular(20.0);
 //  final roundedRect = RRect.fromRectAndCorners(
 //    Rect.fromPoints(Offset(50, 50), Offset(150, 150)),
 //    topLeft: borderRadius.topLeft,
 //    topRight: borderRadius.topRight,
 //    bottomLeft: borderRadius.bottomLeft,
 //    bottomRight: borderRadius.bottomRight,
 //  );
 //      canvas.drawRRect(roundedRect, paint);

 //  super.render(canvas);
 //}
}