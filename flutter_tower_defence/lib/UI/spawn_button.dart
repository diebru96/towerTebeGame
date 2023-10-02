import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tower_defence/singleton.dart';

import '../main.dart';

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
                  duration: Duration(milliseconds: 400),

        opacity: opacity,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          margin: EdgeInsets.all(8),
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
                Icon(
                  Icons.money,
                  color: Colors.yellow,
                  size: 12,
                ),
                Text(
                  widget.cost.toString(),
                  style: TextStyle(color: Colors.white),
                )
              ])
            ],
          ),
        ),
      ),
      onTap: () {
       if(singleton.coinAmount>=widget.cost){
        if(widget.defencetype==DefenceSpawn.heal && singleton.healtWidth>=200)
        {
          
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
       Future.delayed(Duration(milliseconds: 300)).then((_) {
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
