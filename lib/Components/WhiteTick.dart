import 'package:flutter/material.dart';

class Tick extends StatelessWidget {
  final DecorationImage image;
  Tick({this.image});
  @override
  Widget build(BuildContext context) {
    return (new Column(children: [
      new SizedBox(
        height: 100,
      ),
      new Container(
        width: 100.0,
        height: 100.0,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: image,
        ),
      ),
    ]));
  }
}
