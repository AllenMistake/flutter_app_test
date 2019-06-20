import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/cards/card_tl.dart';
import 'package:flutter_app_test/pages/about_page.dart';
import 'package:flutter_app_test/pages/set_page.dart';

class HomePage extends StatefulWidget {
  final MyCard card1 = new MyCard("剪刀", 0);
  final MyCard card2 = new MyCard("石头", 1);
  final MyCard card3 = new MyCard("布", 2);
  String mainString = "Fighting";


  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyCard aiCard;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("石头剪刀布"),
        backgroundColor: Colors.redAccent,
      ), //头部的标题AppBar
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              //Material内置控件
              accountName: new Text('weitanori'), //用户名
              accountEmail: new Text('weitanori@hotmail.com'), //用户邮箱
              currentAccountPicture: new GestureDetector(
                //用户头像
                onTap: () => print('current user'),
                child: new CircleAvatar(
                    //圆形图标控件
                    backgroundImage: new ExactAssetImage('images/avatar.jpg')),
              ),
              decoration: new BoxDecoration(
                //用一个BoxDecoration装饰器提供背景图片
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  // image: new NetworkImage('https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg')
                  //可以试试图片调取自本地。调用本地资源，需要到pubspec.yaml中配置文件路径
                  image: new ExactAssetImage('images/sss.png'),
                ),
              ),
            ),
            new ListTile(
                //第一个功能项
                title: new Text('设置'),
                trailing: new Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push<List>(
                    context,
                    new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new SetPage(widget.card1, widget.card2, widget.card3),
                    ),
                  ).then((List result) {
                    if (result[0] != '') widget.card1.cardName = result[0];
                    if (result[1] != '') widget.card2.cardName = result[1];
                    if (result[2] != '') widget.card3.cardName = result[2];
                  });
                }),
            new ListTile(
                //第二个功能项
                title: new Text('关于作者'),
                trailing: new Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new AboutPage()));
                }),
            new Divider(), //分割线控件
            new ListTile(
              //退出按钮
              title: new Text('Close'),
              trailing: new Icon(Icons.cancel),
              onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
            ),
          ],
        ),
      ), //侧边栏按钮Drawer
      body: new Column(
        //中央内容部分body
        children: [
          new Container(
            child: new Text(
              widget.mainString,
              style: new TextStyle(fontSize: 35.0),
            ),
            alignment: Alignment.center,
            color: Color.fromARGB(223, 121, 322, 213),
//            width: 300,
            height: 550,
          ),
          new Expanded(
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: Column(children: [
                    Image(
                      image: ExactAssetImage("images/cards/cut.jpg"),
                      width: 40,
                      height: 40,
                    ),
                    new MaterialButton(
                      onPressed: () {
                        _pressCard(widget.card1);
                      },
                      child: new Text(widget.card1.cardName,
                          style: new TextStyle(fontSize: 20.0)),
                    ),
                  ]),
                ),
                new Expanded(
                  child: new Column(
                    children: <Widget>[
                      Image(
                        image: ExactAssetImage("images/cards/stone.jpg"),
                        width: 40,
                        height: 40,
                      ),
                      new FlatButton(
                        onPressed: () {
                          _pressCard(widget.card2);
                        },
                        child: new Text(widget.card2.cardName,
                            style: new TextStyle(fontSize: 20.0)),
                      ),
                    ],
                  ),
                ),
                new Expanded(
                  child: new Column(
                    children: <Widget>[
                      Image(
                        image: ExactAssetImage("images/cards/paper.jpg"),
                        width: 40,
                        height: 40,
                      ),
                      new FlatButton(
                        onPressed: () {
                          _pressCard(widget.card3);
                        },
                        child: new Text(widget.card3.cardName,
                            style: new TextStyle(fontSize: 20.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  MyCard _aiCard() {
    var n = Random().nextInt(3);
    if (n == 0) {print('0');return new MyCard("${widget.card1.cardName}", 0);}
    if (n == 1) {print('1');return new MyCard("${widget.card2.cardName}", 1);}
    print('$n');
    return new MyCard("${widget.card3.cardName}", 2);
  }

  String _cardCompare(int n, int m) {
    if (n == m) return "平局";
    if (n == 0 && m == 1 || n == 1 && m == 2 || n == 2 && m == 1)
      return "您赢了！";
    else
      return "电脑赢了！";
  }

  void _pressCard(MyCard card){
    setState(() {
      widget.mainString = card.cardName;
    });
    aiCard = _aiCard();
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('比赛结果'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('您出的是${card.cardName}'),
                new Text('电脑出的是${aiCard.cardName}'),
                new Text(_cardCompare(
                    aiCard.cardId, card.cardId)),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }
}
