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
          new Container(
            child: new MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text(
                "作者博客",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              onPressed: _launchURL,
              height: 40,
              minWidth: 50,
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://allenmistake.github.io/';
    if (await canLaunch(url)) {
      print('iswork');
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
