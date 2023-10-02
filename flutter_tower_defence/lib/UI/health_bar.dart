
import 'package:flutter/material.dart';

import '../main.dart';

class HealthBar extends StatefulWidget
{
  @override
  State<HealthBar> createState() => _HealthBarState();
}

class _HealthBarState extends State<HealthBar> {

    double health=200;

  @override
  void initState() {
singleton.healtStream.stream.listen((event) { 
  setState(() {
    health=event;
  });
});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return   Positioned(
        top: 65,
        left: 45,
        right: 80,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(height: 20,
            width: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                  color: Colors.white70,
      
            border: Border.all(color: Colors.white, width: 2)
            ),
            ),
            Container(height: 20,
            width: health,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                  color: Colors.green.shade300,
      
            border: Border.all(color: Colors.white, width: 2)
            ),
            )
          ],
        ),
      );
  }
}