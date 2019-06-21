import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => new _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("关于作者"),
        backgroundColor: Colors.redAccent,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            child: new DecoratedBox(
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  image: new ExactAssetImage('images/avatar.jpg'),
                  // ...
                ),
                // ...
              ),
            ),
            width: 200,
            height: 200,
          ),
          new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new ListTile(
                  title: new Text('作者博客'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    _launchBlog();
                  }),
              new ListTile(
                  title: new Text('项目地址'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    _launchGit();
                  }),
            ],
          ),

        ],
      ),
    );
  }

  _launchBlog() async {
    const url = 'https://allenmistake.github.io/';
    if (await canLaunch(url)) {
      print('iswork');
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchGit() async {
    const url = 'https://github.com/AllenMistake/flutter_app_test';
    if (await canLaunch(url)) {
      print('iswork');
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
