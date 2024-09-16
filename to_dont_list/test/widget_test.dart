// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';

void main() {
  test('Item abbreviation should be first letter', () {
    Army item = Army(name: "add more todos", priority: 1);
    expect(item.abbrev(), "a");
  });

  test("Item compare function works", () {
    Army thisitem = Army(name: "This", priority: 1);
    Army theOtherItem = Army(name:"Other", priority:2);
    Army theSameItem = Army(name:"Similar", priority: 1);
    expect(theOtherItem.Compare(thisitem), 1);
    expect(thisitem.Compare(theOtherItem), -1);
    expect(thisitem.Compare(theSameItem), 0);
  });

  test("Sorting a list of items", () {
    Army a = Army(name: "A", priority: 3);
    Army b = Army(name: "B", priority: 1);
    Army c = Army(name: "C", priority: 2);
    List<Army> mock = [a, b, c];

    mock.sort((a, b){
      return a.Compare(b);
    });
    expect(mock, [b, c, a]);
  });

  // Yes, you really need the MaterialApp and Scaffold
  testWidgets('ToDoListItem has a text', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ToDoListItem(
                item: Army(name: "test", priority: 2),
                completed: true,
                onListChanged: (Army item, bool completed) {},
                onDeleteItem: (Army item) {}))));
    final textFinder = find.text('test');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
  });

  // testWidgets('ToDoListItem has a Circle Avatar with abbreviation',
  //     (tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //       home: Scaffold(
  //           body: ToDoListItem(
  //               item: Item(name: "test", priority: 1),
  //               completed: true,
  //               onListChanged: (Item item, bool completed) {},
  //               onDeleteItem: (Item item) {}))));
                
  //   final abbvFinder = find.text('t');
  //   final avatarFinder = find.byType(CircleAvatar);

  //   CircleAvatar circ = tester.firstWidget(avatarFinder);
  //   Text ctext = circ.child as Text;

  //   // Use the `findsOneWidget` matcher provided by flutter_test to verify
  //   // that the Text widgets appear exactly once in the widget tree.
  //   expect(abbvFinder, findsOneWidget);
  //   expect(circ.backgroundColor, Colors.black54);
  //   expect(ctext.data, "t");
  // });

  testWidgets('Default ToDoList has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    final listItemFinder = find.byType(ToDoListItem);

    expect(listItemFinder, findsOneWidget);
  });

  // testWidgets('Clicking and Typing adds item to ToDoList', (tester) async {
  //   await tester.pumpWidget(const MaterialApp(home: ToDoList()));

  //   expect(find.byType(TextField), findsNothing);

  //   await tester.tap(find.byType(FloatingActionButton));
  //   await tester.pump(); // Pump after every action to rebuild the widgets
  //   expect(find.text("hi"), findsNothing);

  //   await tester.enterText(find.byType(TextField), 'hi');
  //   await tester.pump();
  //   expect(find.text("hi"), findsOneWidget);

  //   await tester.tap(find.byKey(const Key("OKButton")));
  //   await tester.pump();
  //   expect(find.text("hi"), findsOneWidget);

  //   final listItemFinder = find.byType(ToDoListItem);

  //   expect(listItemFinder, findsNWidgets(2));
  // });

  // One to test the tap and press actions on the items?
}
