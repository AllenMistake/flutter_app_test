import 'package:flutter/material.dart';
import 'package:flutter_app_test/cards/card_tl.dart';

class SetPage extends StatefulWidget {
  final MyCard card1;
  final MyCard card2;
  final MyCard card3;

  SetPage(this.card1,this.card2,this.card3);

  @override
  _SetPageState createState() => new _SetPageState();
}

class _SetPageState extends State<SetPage> {
  final titleStyle = TextStyle(fontSize: 20.0);
  final titleColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    String s1 = widget.card1.cardName;
    String s2 = widget.card2.cardName;
    String s3 = widget.card3.cardName;
    final TextEditingController _controller1 = TextEditingController();
    final TextEditingController _controller2 = TextEditingController();
    final TextEditingController _controller3 = TextEditingController();
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("设置页面"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0), //设置边距
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //内容居中
            children: <Widget>[
              SizedBox(height: 10.0),
              createTitle('自定义卡片名称'),
              TextField(
                controller: _controller1,
                decoration: InputDecoration(
                    icon: Icon(IconData(0xf00b, fontFamily: 'appIconFonts')),
                    hintText: '$s1',
                    border: OutlineInputBorder()
                ),
                //onSubmitted:  _card1Submitted,
              ),
              TextField(
                controller: _controller2,
                decoration: InputDecoration(
                    icon: Icon(IconData(0xf009, fontFamily: 'appIconFonts')),
                    hintText: '$s2',
                    border: OutlineInputBorder()),
              ),
              TextField(
                controller: _controller3,
                decoration: InputDecoration(
                    icon: Icon(IconData(0xf002, fontFamily: 'appIconFonts')),
                    hintText: '$s3',
                    border: OutlineInputBorder()),
              ),
          new RaisedButton(
              color: Colors.blueAccent,
              onPressed: () {
                // 将输入的内容返回
                var s = new List();
                s.add(_controller1.text);
                s.add(_controller2.text);
                s.add(_controller3.text);
                Navigator.of(context).pop(s);
              },
              child: new Text("确认"))
            ]),
      ),
    );
  }

  createTitle(String title) =>
      Title(child: Text(title, style: titleStyle), color: titleColor);

  //_card1Submitted(String s1)
}
