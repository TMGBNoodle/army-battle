import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/army.dart';

typedef ArmyPositionChanged = Function(Army army);
typedef ArmyRemoved = Function(Army army);

class ArmyTile extends StatelessWidget {
  ArmyTile(
    {
      required this.army,
      required this.onListChanged,
      required this.onListRemoved
    }) : super(key: ObjectKey(army));
  final Army army;

  final ArmyPositionChanged onListChanged;
  final ArmyRemoved onListRemoved;
  //Including this just in case I want to make to style changes here later
  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    return const TextStyle(
      color: Colors.black,
      //decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: army.color,
      leading: FloatingActionButton(
        onPressed: () {
          army.activated = false;
          army.position += 1;
          onListChanged(army);
        },
        backgroundColor: Colors.purpleAccent,
        tooltip: "Moves Army Upwards",
        child : const Text(
          "+"
        )
      ),
      title: Column(
        children: [
          Text(
            army.name,
            style: _getTextStyle(context),
          ),
          Text(
            "Pos: ${army.position}",
            style: _getTextStyle(context),
          ),
          Text(
            "HP: ${army.health}",
            style: _getTextStyle(context),
          ),
          Text(
            "ATCK: ${army.attack}"
          )
        ],
      ),
      trailing: FloatingActionButton(
        onPressed: () {
          army.activated = false;
          army.position -= 1;
          onListChanged(army);
        },
        backgroundColor: Colors.amber,
        tooltip: "Moves Army Downwards",
        child: const Text(
          "-"
        ),
      ),
    );
  }
}