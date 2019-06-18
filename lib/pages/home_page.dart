import 'package:flutter/material.dart';
import 'package:flutter_app_test/cards/card_tl.dart';
import 'package:flutter_app_test/pages/about_page.dart';
import 'package:flutter_app_test/pages/set_page.dart';

class HomePage extends StatefulWidget {
  final MyCard card1 = new MyCard("剪刀");
  final MyCard card2 = new MyCard("石头");
  final MyCard card3 = new MyCard("布");

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String mainString = "Fighting";
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
              mainString,
              style: new TextStyle(fontSize: 35.0),
            ),
            alignment: Alignment.center,
            color: Color.fromARGB(223, 121, 322, 213),
//            width: 300,
            height: 300,
          ),
          new Expanded(
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    onPressed: () {
                      mainString = widget.card1.cardName;
                    },
                    child: new Text(widget.card1.cardName,
                        style: new TextStyle(fontSize: 20.0)),
                  ),
                ),
                new Expanded(
                  child: new FlatButton(
                    onPressed: () {
                      mainString = widget.card2.cardName;
                    },
                    child: new Text(widget.card2.cardName,
                        style: new TextStyle(fontSize: 20.0)),
                  ),
                ),
                new Expanded(
                  child: new FlatButton(
                    onPressed: () {
                      mainString = widget.card2.cardName;
                    },
                    child: new Text(widget.card3.cardName,
                        style: new TextStyle(fontSize: 20.0)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
