import 'package:flutter/material.dart';

class SetPage extends StatefulWidget {
  @override
  _SetPageState createState() => new _SetPageState();
}

class _SetPageState extends State<SetPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("设置页面"),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
