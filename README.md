通过这个界面熟悉熟悉 dart 语言, flutter 界面布局方式

文章主要列出比较关键的点

# 主要组件:

1. Row: 横向排列组件
2. TextField: 文本框
3. GestureDetector: 为文本添加事件
4. Text: 文本
5. FlatButton: 按钮

以上都可以通过 google: Flutter + 组件名 查询到对应的文档

# home 指定

dart 通过 main.dart 中的 runApp() 函数来指定程序入口, 在入口类里通过设置 home 属性确定入口页面.

当页面指定为其他 dart 文件中的类时, 需要在 main 中 import 该 dart 文件.

# 主要的几个点

## 获取 TextField 的值

1. 设置一个 key: final  _key = TextEditingController();
2. 在 TextField 中添加属性: controller: _key,
3. 在别的组件的事件中使用: _key.text

## 为 Text 添加点击事件

由于 dart 并没有给 Text 直接添加点击事件的属性, 因此需要借助 GestureDetector, 在 GestureDetector 中嵌套 Text, 同时为 GestureDector 添加点击事件.

## 登录时判断电话 / 密码是否为空, 并根据判断设置 errorText

这里直接通过 [获取 TextField 的值](#获取 TextField 的值) 判断值是否为空: _key.text.isEmpty

errorText: 使 TextField 显示错误提示文字( 默认为红色, 位于输入框下方 ). 当使用该属性时, labelText 也会变色( 跟随默认色 ). errorText 设置值为 null 时不起作用.

1. 设置 flag: _isPhoneEmpty = false;

2. 设置 errorText: errorText: _isPhoneEmpty? "手机号为空" : null,

3. 为登录按钮添加事件: 

	```dart
	onTap:(){
		setState((){
	      _keyPhone.text.isEmpty? _isPhoneEmpty = true : _isPhoneEmpty = false;
	    })
	}
	```

根据提示( 鼠标移过去 )说明, 该函数可以向框架声明某一对象的属性已被修改, 从而使该属性做出相应动作. 具体等看文档

## TextField 获取焦点

1. 设置 FocusNode _passwordFocusNode = FocusNode();

2. 为密码设置 focusNode: focus Node: _passwordFocusNode

3. 为 phone 设置完成事件:

	```dart
	onEditingComplete: (){
	    FocusScope.of(context).requestFocus(_passwordFocusNode);
	},
	```

4. 为 phone 设置回车按钮样式: textInputAction: TextInputAction.next ( 这一步只是为了好看 )

这样当输完号码后, 点击回车就自动跳转到密码输入框了.

密码输入框用类似的方法实现, 回车 -> 登录.

根据提示说明, FocusNode 是焦点树的叶, 可以获取到焦点( 英文原文: A leaf node in the focus tree that can receive focus. ). 

## 为密码输入框添加 可见/不可见 按钮

1. 定义一个 bool 参数: bool passwordVisible = false;

2. 密码 TextField 中添加属性: 

	```dart
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
	```

	

# TODO

- [ ] 添加背景
- [ ] 添加方框并美化