import 'package:flutter/material.dart';
import 'package:flutter_tower_defence/UI/spawn_button.dart';
import 'package:flutter_tower_defence/main.dart';

import '../singleton.dart';

class SpawnButtons extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return     Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
          DefenceSpawnButton(defencetype: DefenceSpawn.moneyProducer, icon: Icon(Icons.monetization_on), color: Colors.orange, cost: 100,),
          DefenceSpawnButton(defencetype: DefenceSpawn.heal, icon: Icon(Icons.healing), color: Colors.green.shade300, cost: 100,),
          DefenceSpawnButton(defencetype: DefenceSpawn.facileShield, icon: Icon(Icons.shield), color: const Color.fromARGB(255, 133, 216, 255), cost: 150,),
          DefenceSpawnButton(defencetype: DefenceSpawn.tebeCannon, icon: Icon(Icons.fire_extinguisher), color: Colors.red, cost: 200,),
          DefenceSpawnButton(defencetype: DefenceSpawn.tebeWave, icon: Icon(Icons.waves), color: Colors.purpleAccent, cost: 250,),
          DefenceSpawnButton(defencetype: DefenceSpawn.powerUpProducer, icon: Icon(Icons.build), color: Color.fromARGB(255, 35, 146, 92), cost: 300,),

          InkWell(
            onTap: (){
              singleton.showGrid.sink.add(false);
            },
            child: Container( margin: EdgeInsets.only(left:5),
               height: 70, width: 70, child: Center(child:Icon(Icons.remove_circle, color: Colors.grey,)), 
               )
              )
        ],),
      ));
  }
  
}