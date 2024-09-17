// Data class to keep the string and have an abbreviation function
import 'package:flutter/material.dart';

class Army {
  Army({required this.name,
   required this.position, 
   required this.health, 
   required this.attack});

  bool activated = false;
  int position;
  int health;
  int attack;
  Color color = Colors.transparent;
  final String name;

  String abbrev() {
    return name.substring(0, 1);
  }

  void AddPrior() {
    position +=1;
    print(position);
  }
  void subPrior(){
    position -=1;
  }

  int getPrior(){
    return position;
  }
  
  @override
  String toString() {
    return "$name $position";
  }
}
