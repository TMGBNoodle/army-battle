// Data class to keep the string and have an abbreviation function

class Item {
  Item({required this.name,
   required this.priority});

  int priority;
  final String name;

  String abbrev() {
    return name.substring(0, 1);
  }

  void AddPrior() {
    priority +=1;
  }
  void subPrior(){
    priority -=1;
  }

  int getPrior(){
    return priority;
  }
  
  int Compare(Item b) {
    if(priority > b.getPrior()){
      return 1;
    } else if(priority < b.getPrior()){
      return -1;
    }
    return 0;
  }
  @override
  String toString() {
    return name + " " + priority.toString();
  }
}
