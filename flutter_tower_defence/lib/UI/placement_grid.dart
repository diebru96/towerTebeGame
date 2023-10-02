import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tower_defence/main.dart';
import 'package:flutter_tower_defence/singleton.dart';

class PlacementGrid extends StatefulWidget{

  @override
  State<PlacementGrid> createState() => _PlacementGridState();
}

class _PlacementGridState extends State<PlacementGrid> {
  List<List<GlobalKey>> gk= List.generate(4, (ic) => List.generate(4, (ir) => GlobalKey()));
  bool showGrid=false;

@override
  void initState() {

    singleton.showGrid.stream.listen((event) { 
      setState(() {
showGrid=event;
      });
    });

    singleton.gridStream.stream.listen((event) { 
      setState(() {
        singleton.gridSpace= event;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return 
    showGrid? 
    Positioned(
      bottom: 120,
      left:0,
      right: 0,
      child: Center(
        child: Container(
          height: 500,
          child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
             children: 
            List.generate(4, (indexC) =>  
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:      
              List.generate(4, (indexR) =>  
              InkWell(
                onTap: (){
                  if(singleton.gridSpace[indexC][indexR]){

                  RenderBox box = gk[indexC][indexR].currentContext!.findRenderObject() as RenderBox;
                  Offset position = box.localToGlobal(Offset.zero);
                  double y = position.dy +45; 
                  double x= position.dx +45;

                  Vector2 pos= Vector2(x,y);
                  singleton.spawnPosition.sink.add(PositionalInfo(position: pos, x_mat: indexC, y_mat: indexR));
                  singleton.gridSpace[indexC][indexR]=false;
                  singleton.gridStream.sink.add(singleton.gridSpace);
                  singleton.showGrid.sink.add(false);
                  }
                },
                child: Container(
                  key: gk[indexC][indexR],
                  color: singleton.gridSpace[indexC][indexR]?  Colors.lightGreenAccent.withOpacity(0.35) : Colors.redAccent.withOpacity(0.35),
                  margin: EdgeInsets.all(10),
                  height: 70,
                width: 70,
                ),
              )
            ),)
            )
           
            
          ,),
        ),
      ),
    )
    :
    SizedBox()
    ;

    
  }
}