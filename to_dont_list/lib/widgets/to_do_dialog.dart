import 'dart:ffi';

import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(
    int priority, String value, TextEditingController textConroller);

class ToDoDialog extends StatefulWidget {
  const ToDoDialog({
    super.key,
    required this.onListAdded,
  });

  final ToDoListAddedCallback onListAdded;

  @override
  State<ToDoDialog> createState() => _ToDoDialogState();
}

bool _isNumeric(String str) {
  if(str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}

class _ToDoDialogState extends State<ToDoDialog> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _inputController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";

  String priorityText = "";

  int AssignedPriority = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Item To Add'),
      content: Column(
          children: [TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _inputController,
            decoration: const InputDecoration(hintText: "type something here"),
          ),
          TextField(
            onChanged: (value) {
              setState((){
                priorityText = value;
                print(priorityText);
                if(_isNumeric(priorityText)){
                  print("Successful parse");
                  AssignedPriority = int.parse(priorityText);
                }
              });
            },
          ),]
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),

        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(AssignedPriority, valueText, _inputController);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('Ok'),
            );
          },
        ),
      ],
    );
  }
}
