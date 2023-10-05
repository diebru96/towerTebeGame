import 'dart:async';

import 'package:flame/game.dart';

enum DefenceSpawn { facileShield, tebeWave, tebeCannon, moneyProducer, heal, powerUpProducer }


class Singleton {
  static Singleton? _instance;

  static get instance {
    _instance ??= Singleton._internal();

    return _instance;
  }

  double healtWidth = 200;
  double wallHealth = 400;
  int coinAmount = 200;

  List<List<bool>> gridSpace = List.generate(4, (ic) => List.generate(4, (ir) => true));

  StreamController<double> healtStream = StreamController.broadcast();
  StreamController<DefenceSpawn> defenceSpawnStream = StreamController.broadcast();
  StreamController<int> coinStream = StreamController.broadcast();
  StreamController<double> wallHealthStream = StreamController.broadcast();
  StreamController<PositionalInfo> spawnPosition = StreamController.broadcast();
  StreamController<bool> showGrid = StreamController.broadcast();
  StreamController<List<List<bool>>> gridStream = StreamController.broadcast();
  


  Singleton._internal();
}

class PositionalInfo{
Vector2 position;
int x_mat;
int y_mat;

PositionalInfo({required this.position,required this.x_mat, required this.y_mat,});
}