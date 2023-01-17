// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class CustomRollingButton extends StatelessWidget {
  

  
  
  const CustomRollingButton({
    Key? key,
    
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    
    return LiteRollingSwitch(
      value: false,
      textOn: "Available",
      textOff: "Unavailable",
      colorOn: Colors.greenAccent,
      colorOff: Colors.redAccent,
      iconOn: Icons.oil_barrel,
      iconOff: Icons.stop_circle_outlined,
      
      
      onChanged: (bool possiton) {
        print(possiton);
        
        }, onDoubleTap: (){}, onSwipe: (){}, onTap: (){},
        
        

    );
  }
}

