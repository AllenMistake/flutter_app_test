import 'package:flutter/material.dart';

class SmallCards extends StatefulWidget {
  @override
  _SmallCardsState createState() => new _SmallCardsState();
}

class _SmallCardsState extends State<SmallCards> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        new Text("1", style: new TextStyle(fontSize: 35.0)),
        new Text("2", style: new TextStyle(fontSize: 35.0)),
        new Text("3", style: new TextStyle(fontSize: 35.0)),
      ],
    );
  }
}
