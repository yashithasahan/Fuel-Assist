import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StationSelecter extends StatefulWidget {
  const StationSelecter({super.key});

  @override
  State<StationSelecter> createState() => _StationSelecterState();
}

class _StationSelecterState extends State<StationSelecter> {
  get selectedItem => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        DropdownButton<String>(
          value: selectedItem,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (nul) {},
          items: <String>['Item 1', 'Item 2', 'Item 3', 'Item 4']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
      ]),
    );
  }
}
