import 'package:flutter/material.dart';
import 'package:flutter_app_test/cards/card_tl.dart';

class SetPage extends StatefulWidget {
  final MyCard card1;
  final MyCard card2;
  final MyCard card3;

  SetPage(this.card1, this.card2, this.card3);

  @override
  _SetPageState createState() => new _SetPageState();
}

class _SetPageState extends State<SetPage> {
  final titleStyle = TextStyle(fontSize: 20.0);
  final titleColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller1 = TextEditingController();
    final TextEditingController _controller2 = TextEditingController();
    final TextEditingController _controller3 = TextEditingController();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("设置页面"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 80.0),
              new Center(
                child: createTitle('自定义卡片名称'),
              ),
              const SizedBox(height: 10.0),
              _buildTextField(0, widget.card1.cardName, _controller1, 0xf00b,
                  'appIconFonts'),
              SizedBox(height: 10.0),
              _buildTextField(1, widget.card2.cardName, _controller2, 0xf009,
                  'appIconFonts'),
              SizedBox(height: 10.0),
              _buildTextField(2, widget.card3.cardName, _controller3, 0xf002,
                  'appIconFonts'),
              SizedBox(height: 10.0),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    var s = new List();
                    s.add(_controller1.text);
                    s.add(_controller2.text);
                    s.add(_controller3.text);
                    Navigator.of(context).pop(s);
                  },
                  child: Text('确认'),
                  color: Colors.white,
                )
              ],
            ),
              /*
              new RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    // 将输入的内容返回

                  },
                  child: new Text("确认"))
                  */
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(int i, String s, TextEditingController controller,
      int iconNum, String iconFamily) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            icon: Icon(IconData(iconNum, fontFamily: iconFamily)),
            filled: true,
            labelText: "$s",
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  createTitle(String title) =>
      Title(child: Text(title, style: titleStyle), color: titleColor);

  //_card1Submitted(String s1)
}
