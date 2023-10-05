import 'package:flutter/material.dart';
import 'package:flutter_tower_defence/main.dart';

class CoinOverlay extends StatefulWidget{
  @override
  State<CoinOverlay> createState() => _CoinOverlayState();
}

class _CoinOverlayState extends State<CoinOverlay> {
  int coinAmount=200;
  int puAmount=0;
  @override
  void initState() {
    singleton.coinStream.stream.listen((event) { 
      setState(() {
        coinAmount=event;

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top:60,
      right: 30,
      child: Row(
        children: [

                    Row(
          children: [
            
               Container(height: 25, width: 25,
       child: Image(image: AssetImage("assets/images/power_up.png")),
       ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(puAmount.toString(), style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ),

          ]),
          SizedBox(width: 10,),
          Row(
          children: [
            
            Icon(Icons.monetization_on, color: Colors.amber, size: 28,  ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(coinAmount.toString(), style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                    )
            
          ],
    ),
        ],
      ));
  }
}