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
  bool _passwordVisible = false;
  final  _keyPhone = TextEditingController();
  final _keyPassword = TextEditingController();
  FocusNode _passwordFocusNode = FocusNode();
  bool _isPhoneEmpty = false;
  bool _isPasswordEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: _userPassword(),
      )
    );
  }
  @override
  void initState(){
    super.initState();
    _passwordFocusNode.addListener(_onFocusPassword);
  }
  void _onFocusPassword(){
    _passwordFocusNode.hasFocus? print('here is password') : null;
  }

  Widget _userPassword(){
    return Container(
      width: 230.0,
      height: 300.0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: 15.0, left: 15.0, right: 25.0),
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
                labelText: "手机号",
                hintText: "请输入手机号码",
                errorText: _isPhoneEmpty? "手机号为空" : null,
                errorStyle: TextStyle(
                    color: Color(0xffff0000),
                    fontSize: 12.0
                ),
                errorMaxLines: 1,
              ),
              onEditingComplete: (){
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              textInputAction: TextInputAction.next,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 5.0, left: 15.0, right: 25.0),
            child: TextField(
              controller: _keyPassword,
              focusNode: _passwordFocusNode,
              obscureText: ! _passwordVisible,
              decoration: InputDecoration(
                icon: Icon(
                  FontAwesomeIcons.solidKeyboard,
                  color: Colors.black,
                  size: 15,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: _passwordVisible ? Colors.blue : Colors.grey,
                  ),
                  onPressed: (){
                    setState(() {
                      _passwordVisible = !_passwordVisible; 
                    });
                  },
                ),
                labelText: "密    码",
                hintText: "请输入密码",
                errorText: _isPasswordEmpty? "密码不能为空" : null,
              ),
              onSubmitted: (val){
                _logIn();
              },
            ),
          ),
          Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: 15.0, left: 15.0, right: 25.0),
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
                  Toast.show("phone: "+_keyPhone.text+", 忘记密码", context);
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
                  _logIn();
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
  void _logIn(){
    setState(() {
      _keyPhone.text.isEmpty? _isPhoneEmpty = true : _isPhoneEmpty = false;
      _keyPassword.text.isEmpty? _isPasswordEmpty = true : _isPasswordEmpty = false; 
    });
    !_isPhoneEmpty && !_isPasswordEmpty? print("phone: "+_keyPhone.text+" password: "+_keyPassword.text) : null;
  }
}
