import 'dart:io';
import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/Screens/pages/about_page.dart';
import 'package:flutter_app_test/Screens/pages/set_page.dart';
import 'package:flutter_app_test/cards/card_tl.dart';

class HomePage extends StatefulWidget {
  final MyCard card1 = new MyCard("剪刀", 0);
  final MyCard card2 = new MyCard("石头", 1);
  final MyCard card3 = new MyCard("布", 2);
  String mainString = "Fighting";
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Animation<double> animationAI;
  bool disableButton = true;
  String playerPicPath = "images/cards/stone.jpg";
  String aiPicPath = "images/cards/stone.jpg";
  MyCard myCard = new MyCard('Fighting', 0);
  MyCard aiCard;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    animation = new Tween(begin: -1.0, end: -0.25).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _pressCard(myCard);
          disableButton = true;
        }
//        else if (status == AnimationStatus.dismissed) {
//          controller.forward();
//        }
      });
    animationAI = new Tween(begin: 1.0, end: 0.25).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _showDialog() {
    showDialog<Null>(
      context: context,
      child: new AlertDialog(content: new Text('退出当前界面'), actions: <Widget>[
        new FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
            child: new Text('确定'))
      ]),
    );
  }

  Future<bool> _outPop() {
    _showDialog();
    return new Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return new WillPopScope(
        onWillPop: _outPop,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text(
              "石头剪刀布",
            ),
            backgroundColor: Color.fromRGBO(119, 136, 153, 1.0),
          ), //头部的标题AppBar
          drawer: new Drawer(
            child: new ListView(
              shrinkWrap: true,
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
                        backgroundImage:
                            new ExactAssetImage('images/avatar.jpg')),
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
                          builder: (BuildContext context) => new SetPage(
                              widget.card1, widget.card2, widget.card3),
                        ),
                      ).then((List result) {
                        if (result[0] != '') widget.card1.cardName = result[0];
                        if (result[1] != '') widget.card2.cardName = result[1];
                        if (result[2] != '') widget.card3.cardName = result[2];
                      });
                    }),
                new ListTile(
                    //第二个功能项
                    title: new Text('关于'),
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
              new Expanded(
                child: new Column(children: <Widget>[
                  AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return Transform(
                          transform: Matrix4.translationValues(
                              animation.value * width, 0.0, 0.0),
                          child: new Center(
                            child: Container(
                              padding: const EdgeInsets.only(top: 16.0),
                              width: 100.0,
                              height: 100.0,
                              child: Image(
                                image: ExactAssetImage("$playerPicPath"),
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        );
                      }),
                  AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return Transform(
                          transform: Matrix4.translationValues(
                              animationAI.value * width, 0.0, 0.0),
                          child: new Center(
                            child: Container(
                              padding: const EdgeInsets.only(top: 16.0),
                              width: 100.0,
                              height: 100.0,
                              child: Image(
                                image: ExactAssetImage("$aiPicPath"),
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        );
                      }),
                ]),
              ),
              new SizedBox(height: 10),
              new Expanded(
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: Column(children: [
                        new FlatButton(
                          child: Image(
                            image: ExactAssetImage("images/cards/cut.jpg"),
                            width: 50.0,
                            height: 50.0,
                          ),
                          onPressed: () {
                            if (disableButton) {
                              controller.reset();
                              controller.forward();
                              setState(() {
                                playerPicPath = "images/cards/cut.jpg";
                                myCard = widget.card1;
                                aiCard = _aiCard();
                                aiPicPath = _setPicPath(aiCard);
                                disableButton = false;
                              });
                            }
                          },
                        ),
                        new MaterialButton(
                          onPressed: () {
                            if (disableButton) {
                              controller.reset();
                              controller.forward();
                              setState(() {
                                playerPicPath = "images/cards/cut.jpg";
                                myCard = widget.card1;
                                aiCard = _aiCard();
                                aiPicPath = _setPicPath(aiCard);
                                disableButton = false;
                              });
                            }
                          },
                          child: new Text(widget.card1.cardName,
                              style: new TextStyle(fontSize: 20.0)),
                        ),
                      ]),
                    ),
                    new Expanded(
                      child: new Column(
                        children: <Widget>[
                          new FlatButton(
                            child: Image(
                              image: ExactAssetImage("images/cards/stone.jpg"),
                              width: 50.0,
                              height: 50.0,
                            ),
                            onPressed: () {
                              if (disableButton) {
                                setState(() {
                                  playerPicPath = "images/cards/stone.jpg";
                                  myCard = widget.card2;
                                  aiCard = _aiCard();
                                  aiPicPath = _setPicPath(aiCard);
                                  disableButton = false;
                                });
                                controller.reset();
                                controller.forward();
                              }
                            },
                          ),
                          new FlatButton(
                            onPressed: () {
                              if (disableButton) {
                                setState(() {
                                  playerPicPath = "images/cards/stone.jpg";
                                  myCard = widget.card2;
                                  aiCard = _aiCard();
                                  aiPicPath = _setPicPath(aiCard);
                                  disableButton = false;
                                });
                                controller.reset();
                                controller.forward();
                              }
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
                          new FlatButton(
                            child: Image(
                              image:
                                  new ExactAssetImage("images/cards/paper.jpg"),
                              width: 50.0,
                              height: 50.0,
                            ),
                            onPressed: () {
                              if (disableButton) {
                                controller.reset();
                                controller.forward();
                                setState(() {
                                  playerPicPath = "images/cards/paper.jpg";
                                  myCard = widget.card3;
                                  aiCard = _aiCard();
                                  aiPicPath = _setPicPath(aiCard);
                                  disableButton = false;
                                });
                              }
                            },
                          ),
                          new FlatButton(
                            onPressed: () {
                              if (disableButton) {
                                controller.reset();
                                controller.forward();
                                setState(() {
                                  playerPicPath = "images/cards/paper.jpg";
                                  myCard = widget.card3;
                                  aiCard = _aiCard();
                                  aiPicPath = _setPicPath(aiCard);
                                  disableButton = false;
                                });
                              }
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
          resizeToAvoidBottomPadding: false,
        ));
  }

  MyCard _aiCard() {
    var n = Random().nextInt(3);
    if (n == 0) {
      print('0');
      return new MyCard("${widget.card1.cardName}", 0);
    }
    if (n == 1) {
      print('1');
      return new MyCard("${widget.card2.cardName}", 1);
    }
    print('$n');
    return new MyCard("${widget.card3.cardName}", 2);
  }

  String _cardCompare(int n, int m) {
    if (n == m) return "平局";
    if (n == 0 && m == 1 || n == 1 && m == 2 || n == 2 && m == 0)
      return "您赢了！";
    else
      return "电脑赢了！";
  }

  void _pressCard(MyCard card) {
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
                new Text(_cardCompare(aiCard.cardId, card.cardId)),
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
    );
  }

  String _setPicPath(MyCard card) {
    if (card.cardId == 0) return "images/cards/cut.jpg";
    if (card.cardId == 1) return "images/cards/stone.jpg";
    return "images/cards/paper.jpg";
  }
}
