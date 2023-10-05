import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tower_defence/singleton.dart';

import '../main.dart';

// ignore: must_be_immutable
class DefenceSpawnButton extends StatefulWidget {
  Color color;
  Icon icon;
  DefenceSpawn defencetype;
  int cost = 100;

  DefenceSpawnButton(
      {super.key,
      required this.defencetype,
      required this.icon,
      required this.color,
      required this.cost});

  @override
  State<DefenceSpawnButton> createState() => _DefenceSpawnButtonState();
}

class _DefenceSpawnButtonState extends State<DefenceSpawnButton> {
  Color color = Colors.white;
  @override
  void initState() {
    color = widget.color;
    super.initState();
  }
  double opacity=1.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),

        opacity: opacity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          margin: const EdgeInsets.all(8),
          width: 65,
          height: 65,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 1.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: widget.icon),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(
                  Icons.money,
                  color: Colors.yellow,
                  size: 12,
                ),
                Text(
                  widget.cost.toString(),
                  style: const TextStyle(color: Colors.white),
                )
              ])
            ],
          ),
        ),
      ),
      onTap: () {
       if(singleton.coinAmount>=widget.cost){
        //SALUTE PIENA
           if(widget.defencetype==DefenceSpawn.heal && singleton.healtWidth>=200 )
           {
             return;
           }
        //non abbastanza spazi per muro
           if(widget.defencetype==DefenceSpawn.facileShield && singleton.gridSpace.where((element) => listEquals(element, [true, true, true, true])).isEmpty )
                {
                 setState(() {
                     color = Colors.redAccent;
                     opacity=0.0;
                   });
                 Future.delayed(const Duration(milliseconds: 300)).then((_) {
                   setState(() {
                     color = widget.color;
                     opacity=1.0;
                    });
                 });
             return;
           }   
        setState(() {
          color = Colors.white;
        });

        singleton.defenceSpawnStream.sink.add(widget.defencetype);
            singleton.coinAmount -= widget.cost;
        singleton.coinStream.sink.add(singleton.coinAmount);

        if(widget.defencetype==DefenceSpawn.heal)
        {
          singleton.healtWidth=singleton.healtWidth+50;
          singleton.healtStream.sink.add(singleton.healtWidth);
        }

      }
      else
      {
          setState(() {
          color = Colors.redAccent;
          opacity=0.0;
        });
      }



//back to color
       Future.delayed(const Duration(milliseconds: 300)).then((_) {
          setState(() {
            color = widget.color;
            opacity=1.0;
          });
        });
      }
      ,
    );
  }
}
