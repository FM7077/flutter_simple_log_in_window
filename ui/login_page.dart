import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}
  
class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  String _phone = null;
  String _password = null;
  final  _keyPhone = TextEditingController();
  final _keyPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Center(
        child: _userPassword(),
      )
    );
  }

  Widget _userPassword(){
    return Container(
      width: 230.0,
      height: 230.0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: 20.0, bottom: 10.0, left: 15.0, right: 25.0),
            child: TextField(
              controller: _keyPhone,
              keyboardType: TextInputType.phone,
              maxLength: 11,
              decoration: InputDecoration(
                icon: Icon(
                  FontAwesomeIcons.phone,
                  color: Colors.black,
                  size: 15,
                ),
                hintText: "手机号",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 10.0, left: 15.0, right: 25.0),
            child: TextField(
              controller: _keyPassword,
              obscureText: ! passwordVisible,
              decoration: InputDecoration(
                icon: Icon(
                  FontAwesomeIcons.solidKeyboard,
                  color: Colors.black,
                  size: 15,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: passwordVisible ? Colors.blue : Colors.grey,
                  ),
                  onPressed: (){
                    setState(() {
                      passwordVisible = !passwordVisible; 
                    });
                  },
                ),
                hintText: "密    码",
              ),
            ),
          ),
          Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 10.0, bottom: 15.0, left: 15.0, right: 25.0),
              child: GestureDetector(
                child: Text(
                  '忘 记 密 码',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    decoration: TextDecoration.underline
                  ),
                ),
                onTap: (){
                  Toast.show("忘记密码", context);
                },
              )
            ),
            
            Padding(
              padding: EdgeInsets.only(
                bottom: 15.0, left: 15.0, right: 25.0),
              child: FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: (){
                  Toast.show("手机号: "+_keyPhone.text+"  密码: "+_keyPassword.text, context);
                },
                child: Text(
                  "登录",
                  style: TextStyle(fontSize: 15.0),
                )
              ),
            ),
          ],)
        ],
      ),
    );
  }
}
