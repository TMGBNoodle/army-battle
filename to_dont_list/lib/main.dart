// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/army.dart';
import 'package:to_dont_list/widgets/army_tile.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<Army> armies = [Army(name: "add more todos", position: 1, health:100, attack: 10)];


  void advanceTime() {
    setState(() {
      armies.sort((a, b){
        if(a.position > b.position){
          return 1;
        } else if(a.position < b.position){
          return -1;
        } else {
          a.health -= b.attack;
          b.health -= a.attack;
          return 0;
        }
    });
    });
  }
  
  void _handleListChanged(Army item) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.
      armies.sort((a, b){
        if(a.position > b.position){
          return 1;
        } else if(a.position < b.position){
          return -1;
        } else {
          return 0;
        }
      });
    });
  }

  void _handleDeleteItem(Army item) {
    setState(() {
      armies.remove(item);
      armies.sort((a, b){
        if(a.position > b.position){
          return 1;
        } else if(a.position < b.position){
          return -1;
        } else {
          return 0;
        }
      });
    });
  }

  void _handleNewItem(int armyHealth, int armyAttack, int armyPos, String armyText, TextEditingController textController1, TextEditingController textController2, TextEditingController textController3, TextEditingController textController4) {
    setState(() {
      print("New List Item Added with priority of $armyPos and a name of $armyText");
      Army item = Army(name: armyText, position: armyPos, health: armyHealth, attack: armyAttack);
      armies.insert(0, item);
      textController1.clear();
      textController2.clear();
      textController4.clear();
      textController3.clear();
      armies.sort((a, b){
        if(a.position > b.position){
          return 1;
        } else if(a.position < b.position){
          return -1;
        } else {
          return 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Army Warfare'),
          leading: FloatingActionButton(
            onPressed: advanceTime,
            child: const Text("+ Time"),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: armies.map((army) {
            return ArmyTile(
              army: army,
              onListChanged: _handleListChanged,
              onListRemoved: _handleDeleteItem,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ToDoDialog(onListAdded: _handleNewItem);
                  });
          }),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'To Do List',
    home: ToDoList(),
  ));
}
