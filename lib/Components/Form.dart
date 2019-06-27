import 'package:flutter/material.dart';
import './InputFields.dart';

class FormContainer extends StatelessWidget {
//  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//  String _name;
//  String _password;
  final TextEditingController userController;
  final TextEditingController pwController;
  FormContainer({this.userController,this.pwController});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
            //key: _formKey,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new InputFieldArea(
                  hint: "Username",
                  obscure: false,
                  icon: Icons.person_outline,
                  controller: userController,
                ),
                new InputFieldArea(
                  hint: "Password",
                  obscure: true,
                  icon: Icons.lock_outline,
                  controller: pwController,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
