
import 'package:flutter/material.dart';


typedef ToDoListAddedCallback = Function(
    int armyHealth, int armyAttack, int armyPos, String armyText, TextEditingController textController,TextEditingController textController1,TextEditingController textController2,TextEditingController textController3);

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
  return int.tryParse(str) != null;
}

class _ToDoDialogState extends State<ToDoDialog> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController NameInput = TextEditingController();
  final TextEditingController PositionInput = TextEditingController();
  final TextEditingController HealthInput = TextEditingController();
  final TextEditingController AttackInput = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";

  String positionText = "";

  String healthText = "";

  String attackText = "";

  int assignedPosition = 0;

  int assignedHealth = 0;

  int assignedAttack = 0;

  String errorMessageA = '';
  String errorMessageH = '';
  String errorMessageP = '';

  bool allTextIsValid(){
    return (_isNumeric(positionText) && _isNumeric(healthText) && _isNumeric(attackText));

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adding an Army'),
      content: Column(
          children: [TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: NameInput,
            decoration: const InputDecoration(hintText: "Input Army Name Here"),
          ),
          TextField(
            onChanged: (value) {
              setState((){
                positionText = value;
                if(_isNumeric(positionText)){
                  print("Successful parse");
                  assignedPosition = int.parse(positionText);
                  if(allTextIsValid()){
                    errorMessageP = '';
                  }

                }
                else{
                  errorMessageP = 'Please enter a number';
                }
              });
            },
            controller: PositionInput,
            decoration: const InputDecoration(hintText: "Input Army Position Here"),
          ),
          Text(errorMessageP,
          style: const TextStyle(
            color: Colors.red
          )),
          TextField(
            onChanged: (value) {
              setState((){
                healthText = value;
                if(_isNumeric(healthText)){
                  assignedHealth = int.parse(healthText);
                  if(allTextIsValid()){
                    errorMessageH = '';
                  }
                }
                else{
                  errorMessageH = 'Please Enter a Number';
                }
              });
            },
            controller: HealthInput,
            decoration: const InputDecoration(hintText: "Input Army Health Here"),
          ),
          Text(errorMessageH,
          style: const TextStyle(
            color: Colors.red
          )),
          TextField(
            onChanged: (value) {
              setState((){
                attackText = value;
                if(_isNumeric(attackText)){
                  assignedAttack = int.parse(attackText);
                  if(allTextIsValid()){
                    errorMessageA = '';
                  }
                }
                else{
                  errorMessageA = 'Please enter a number';
                }
              });
            },
            controller: AttackInput,
            decoration: const InputDecoration(hintText: "Input Army Attack Here"),
          ),
            Text(errorMessageA,
          style: const TextStyle(
            color: Colors.red
          )),
          ]
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
          valueListenable: NameInput,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: (value.text.isNotEmpty && allTextIsValid())
                  ? () {
                      setState(() {
                        widget.onListAdded(assignedHealth, assignedAttack, assignedPosition, valueText, NameInput, HealthInput, AttackInput, PositionInput);
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
