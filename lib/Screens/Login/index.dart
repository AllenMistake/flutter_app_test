import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'styles.dart';
import 'loginAnimation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import '../../Components/SignUpLink.dart';
import '../../Components/Form.dart';
import '../../Components/SignInButton.dart';
import '../../Components/WhiteTick.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController userController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  AnimationController _loginButtonController;
  var animationStatus = 0;
  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Are you sure?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () async {
                  await pop();
                },
                //Navigator.pushReplacementNamed(context, "/home"),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  /*
  Widget _buildBody(BuildContext context) {
    // TODO: get actual snapshot from Cloud Firestore
    //return _buildList(context, dummySnapshot);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('user').where("userName",isEqualTo: "userName"),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        //print(snapshot.data.documents.elementAt(0).toString());
        Firestore.instance.collection('user').document("Allen").get().then((DocumentSnapshot ds) {
          final record = Record.fromSnapshot(ds);
          print(record.name);
        });
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.pw.toString()),
          //版本1：点击事件告诉Colud Firestore 更新数据库的值
          //onTap: () => record.reference.updateData({'votes': record.votes + 1})
          //版本二：资源竞态的解决方法
          /*
          如果在 transaction.get(...) 和 transaction.update(...) 调用之间发生了
          votes 数据的更改，那么当前的事务并不会被提交，而是进行重试，如果重试 5 次还
          是失败，那么这个事务就会失败。
           */
          /*
          onTap: () => Firestore.instance.runTransaction((transaction) async {
            final freshSnapshot = await transaction.get(record.reference);
            final fresh = Record.fromSnapshot(freshSnapshot);
            await transaction
                .update(record.reference, {'votes': fresh.votes + 1});
          }),
          */
        ),
      ),
    );
  }

*/
  Widget _buildBody(BuildContext context) {
    // TODO: get actual snapshot from Cloud Firestore
    //return _buildList(context, dummySnapshot);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  DocumentSnapshot ds;
  List<DocumentSnapshot> l;



  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {

    //  7

//    for(int i = 0;l[i+1]!=null;i++){
//      record = Record.fromSnapshot(l[i]);
//      userMap[record.name] = record.pw;
//      print(record.name);
//    }
//    record = Record.fromSnapshot(l[1]);
//    print(record.name);
    //final record = Record.fromSnapshot(l[0]);
    return (new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
          body: new Container(
              decoration: new BoxDecoration(
                image: backgroundImage,
              ),
              child: new Container(
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                    colors: <Color>[
                      const Color.fromRGBO(162, 146, 199, 0.8),
                      const Color.fromRGBO(51, 51, 63, 0.9),
                    ],
                    stops: [0.2, 1.0],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                  )),
                  child: new ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: <Widget>[
                      new Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Tick(image: tick),
                              new FormContainer(
                                userController: userController,
                                pwController: pwController,
                              ),
                              new SignUp()
                            ],
                          ),
                          animationStatus == 0
                              ? new Padding(
                                  //key: ValueKey(record.name),
                                  padding: const EdgeInsets.only(bottom: 50.0),
                                  child: new InkWell(
                                      onTap: () {
                                        var userMap = Map<String, String>();
                                        l = snapshot.map((data) => ds = data).toList();
                                        record = Record.fromSnapshot(l[1]);
                                        for (int i = 0;i<l.length;i++){
                                          record = Record.fromSnapshot(l[i]);
                                          userMap.putIfAbsent(record.name, () => record.pw);
                                        }
                                        print(userController.text);
                                        print(pwController.text);
                                        if (userMap.containsKey(userController.text)&&userMap[userController.text] == pwController.text) {
                                          setState(() {
                                            animationStatus = 1;
                                          });
                                        }
                                        else if(!userMap.containsKey(userController.text)){
                                          _signInUserError();
                                        }
                                        else if(userMap[userController.text] != pwController.text) _signInPwError();
                                        _playAnimation();
                                      },
                                      child: new SignIn()),
                                )
                              : new StaggerAnimation(
                                  buttonController:
                                      _loginButtonController.view),
                        ],
                      ),
                    ],
                  )))),
    ));
  }

  Record record;
  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      appBar: AppBar(title: Text('登录')),
      body: _buildBody(context),
    );
  }

  //登陆失败
  void _signInUserError() {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('登陆失败'),
          content: new Text("该用户不存在，请重新输入"),
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

  //密码错误
  void _signInPwError() {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('登陆失败'),
          content: new Text("密码错误，请重新输入"),
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
}



class Record {
  final String name;
  final String pw;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['userName'] != null),
        assert(map['passWord'] != null),
        name = map['userName'],
        pw = map['passWord'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$pw>";
}
