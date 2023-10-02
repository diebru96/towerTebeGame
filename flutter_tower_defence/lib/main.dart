import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tower_defence/UI/coin_overlay.dart';
import 'package:flutter_tower_defence/UI/placement_grid.dart';
import 'package:flutter_tower_defence/UI/spawn_buttons.dart';
import 'package:flutter_tower_defence/UI/spawn_button.dart';
import 'package:flutter_tower_defence/games/attack_house.dart';
import 'package:flutter_tower_defence/singleton.dart';

import 'UI/health_bar.dart';

final Singleton singleton = Singleton.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
return Scaffold(body: Stack(
    children: [

      GameWidget(game: AttackHouse()),

      PlacementGrid(),

    HealthBar(),

    SpawnButtons(),
    CoinOverlay(),

    
    ],
  ));
  }
}

