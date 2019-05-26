import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _logInWindow()
    );
  }

  Widget _logInWindow(){
    List<Widget> childrens = [];
    final _mainContainer = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("img/water.png"),
          fit: BoxFit.cover,
        )
      ),
      child: new Container(
        decoration: new BoxDecoration(
          color: Colors.grey.shade200.withOpacity(0.7),
        ),
        child:  Center(
          child: new Container(
            width: 235.0,
            height: 280.0,
            child: Column(
              children: <Widget>[
                _phonePassword(),
                _buttons(),
              ],
            ),
          ),
        ),
      )
    );
    final _loadingContainer = Container(
      constraints: BoxConstraints.expand(),
      color: Colors.black12,
      child: Center(
        child: Opacity(
          opacity: 0.9,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
    childrens.add(_mainContainer);
    _isLoading? childrens.add(_loadingContainer) : null;
    return Stack(
      children: childrens,
    );
  }
  Widget _phonePassword(){
    return new Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(0x3F3F3F), width: 0.5),
        color: Colors.grey.shade200.withOpacity(0.8),
        borderRadius: new BorderRadius.vertical(top: Radius.elliptical(20, 20), bottom: Radius.elliptical(20, 20)),
      ),
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: 15.0, right: 25.0),
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
            bottom: 20.0, left: 15.0, right: 25.0),
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
      ],),
    );
  }
  Widget _buttons(){
    return new Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 15.0, left: 15.0, right: 25.0),
          child: GestureDetector(
            child: Text(
              '忘 记 密 码',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
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
            top: 15.0, left: 15.0, right: 25.0),
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: (){
              _logIn();
            },
            child: Text(
              "登    录",
              style: TextStyle(fontSize: 15.0),
            )
          ),
        ),
      ],
    );
  }
  void _logIn(){
    setState(() {
      _keyPhone.text.isEmpty? _isPhoneEmpty = true : _isPhoneEmpty = false;
      _keyPassword.text.isEmpty? _isPasswordEmpty = true : _isPasswordEmpty = false; 
    });
    if(!_isPhoneEmpty && !_isPasswordEmpty){
      FocusScope.of(context).requestFocus(FocusNode());//unfocus

      setState(() {
        _isLoading = true;
      });
      _logInProcess().then((onValue){
        setState(() {
          _isLoading = false; 
        });
        // var result = json.decode(onValue);
        print(onValue);
        print("log in end");
        if(onValue['code'] == 0){
          Toast.show('登录成功', context);
        }else{
          Toast.show(onValue['msg'], context);
        }
      });
    }
  }
  Future _logInProcess() async{
    print("log in button is tapped");

    var url = 'http://localhost:8080';
    var result;

    Dio dio = new Dio();
    dio.options.baseUrl = url;
    dio.options.connectTimeout = 8000;
    dio.options.receiveTimeout = 8000;

    FormData formData = new FormData.from({
      "username": _keyPhone.text,
      "password": _keyPassword.text,
    });
    Response<Map> response;
    try{
      response = await dio.post("/login", data: formData);
      result = response.data;
    }on DioError catch(e){
      result = {'msg': '登陆超时, 请重试', 'code': 408};
    }
    return result;
  }
}
