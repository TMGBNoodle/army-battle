// Data class to keep the string and have an abbreviation function

class Army {
  Army({required this.name,
   required this.position, 
   required this.health, 
   required this.attack});

  int position;
  int health;
  int attack;
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
  
  int Compare(Army b) {
    if(position > b.getPrior()){
      return 1;
    } else if(position < b.getPrior()){
      return -1;
    }
    return 0;
  }
  @override
  String toString() {
    return "$name $position";
  }
}
