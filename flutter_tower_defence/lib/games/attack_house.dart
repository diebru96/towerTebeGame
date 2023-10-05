import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart' hide Timer;
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tower_defence/games/components/background.dart';
import 'package:flutter_tower_defence/games/components/coins/coinmaker.dart';
import 'package:flutter_tower_defence/games/components/enemyComponents/ghost.dart';
import 'package:flutter_tower_defence/games/components/enemyComponents/killer.dart';
import 'package:flutter_tower_defence/games/components/enemyComponents/thiefs.dart';
import 'package:flutter_tower_defence/games/components/facileshield/facileshield.dart';
import 'package:flutter_tower_defence/games/components/house.dart';
import 'package:flutter_tower_defence/games/components/tebe/tebeshooter.dart';
import 'package:flutter_tower_defence/games/components/tebe/tebewave.dart';
import 'package:flutter_tower_defence/main.dart';
import 'package:flutter_tower_defence/singleton.dart';

class AttackHouse extends FlameGame with HasCollisionDetection, TapCallbacks {
  HouseComponent house = HouseComponent();
  Timer? enemy_time_spawn;
  Timer? killer_time_spawn;
  Timer? ghost_time_spawn;

  int variable_speed = 300;
  DefenceSpawn? selectedDefence;
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());
    add(house);
    
    enemySpawn();

  //add(KillerComponent(
  //        startPosition: Vector2(math.Random().nextInt(280).toDouble() + 50,
  //            math.Random().nextInt(50).toDouble()),
  //        speed: 200));

  //add(GhostComponent(
  //        startPosition: Vector2(math.Random().nextInt(280).toDouble() + 50,
  //            math.Random().nextInt(50).toDouble()),
  //        speed: 300));


    //DEFAULT MONEY SPAWN
    moneySpawn();

    singleton.defenceSpawnStream.stream.listen((event) {
      if (event == DefenceSpawn.heal) {
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

        Future.delayed(const Duration(milliseconds: 300)).then((value) => house
          ..add(ColorEffect(
            Colors.green,
            const Offset(
              0.5,
              0,
            ), // Means, applies from 0% to 50% of the color
            EffectController(
              duration: 0.25,
            ),
          )));
      } else {
        singleton.showGrid.sink.add(true);
        selectedDefence = event;
      }
    });

    singleton.spawnPosition.stream.listen((event) {
      if (selectedDefence != null) {
        switch (selectedDefence) {
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


moneySpawn()
{
      Timer.periodic(const Duration(milliseconds: 4000), (timer) {
      singleton.coinAmount += 50;
      singleton.coinStream.sink.add(singleton.coinAmount);
    });

}


int waveNumb=1;
  enemySpawn() {
//ENEMY SPAWN
    
   showWaveText( "Wave 1");
///////1 wave
    enemy_time_spawn =
        Timer.periodic(const Duration(milliseconds: 3500), (timer) {
      addEnemy();
    });

    //enemyvelocity increase
    Timer.periodic(const Duration(seconds: 30), (timer) {
      variable_speed += 50;
    });


///// 2 wave
    Future.delayed(const Duration(seconds: 45)).then((value) {
         showWaveText( "Wave 2");

      if (enemy_time_spawn != null) {
        enemy_time_spawn!.cancel();
      }

      killerSpawn(200);

      enemy_time_spawn =
          Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      addEnemy();
          });


////////  3 wave
        Future.delayed(const Duration(minutes: 1)).then((value) {
             showWaveText( "Wave 3");

          if (enemy_time_spawn != null) {
            enemy_time_spawn!.cancel();
          }
           ghostSpawn(600, 6000);

          enemy_time_spawn =
              Timer.periodic(const Duration(milliseconds: 2500), (timer) {
        addEnemy();
        addEnemy();
          });


////// 4 wave
          Future.delayed(const Duration(minutes: 1)).then((value) {
               showWaveText( "Wave 4");

            if (enemy_time_spawn != null) {
              enemy_time_spawn!.cancel();
            }
             killerSpawn(100);
             ghostSpawn(800, 9000);


            enemy_time_spawn =
                Timer.periodic(const Duration(milliseconds: 2000), (timer) {
             addEnemy();
             addEnemy();
            });

///////// 5 wave
            Future.delayed(const Duration(minutes: 1)).then((value) {
                 showWaveText( "Wave 5");

              if (enemy_time_spawn != null) {
                enemy_time_spawn!.cancel();
              }
               killerSpawn(200);
               ghostSpawn(600, 12000);
               

              enemy_time_spawn =
                  Timer.periodic(const Duration(milliseconds: 1500), (timer) {

            addEnemy();
            addEnemy();


              });

////////// 6 wave
              Future.delayed(const Duration(minutes: 1)).then((value) {
                   showWaveText( "Wave 6 to infinity");

                if (enemy_time_spawn != null) {
                  enemy_time_spawn!.cancel();
                }
                 killerSpawn(700);
                 ghostSpawn(1000, 5000);

                enemy_time_spawn =
                    Timer.periodic(const Duration(milliseconds: 500), (timer) {
                 addEnemy();
                 addEnemy();
                 
                });

                Timer.periodic(Duration(seconds: 70), (timer) { 
                    showWaveText( "Wave ${waveNumb+6}");
 
                 killerSpawn(400);
                 ghostSpawn(1000, 5000);
                });
              });
            });
          });
        });
      });
    
  }

  


  showWaveText(String text)
  {
    TextComponent t= TextBoxComponent(text: text, position: Vector2(150, 200));
        add(t);
        Future.delayed(Duration(seconds: 3)).then((value) => remove(t));
  }

addEnemy()
{
  add(ThiefComponent(
                      startPosition: Vector2(
                          math.Random().nextInt(280).toDouble() + 50,
                          math.Random().nextInt(100).toDouble()),
                      speed: math.Random().nextInt(variable_speed).toDouble() +
                          300));
}

  killerSpawn(double speed)
  {
    
        Timer.periodic(const Duration(milliseconds: 7000), (timer) {
      add(KillerComponent(
          startPosition: Vector2(math.Random().nextInt(280).toDouble() + 50,
              math.Random().nextInt(50).toDouble()),
          speed: speed));
    });
  }

ghostSpawn(double speed, int delay)
  {
    
        Timer.periodic( Duration(milliseconds: delay), (timer) {
      add(GhostComponent(
          startPosition: Vector2(math.Random().nextInt(280).toDouble() + 50,
              math.Random().nextInt(50).toDouble()),
          speed: speed));
    });
  }
}
