通过这个界面熟悉熟悉 dart 语言, flutter 界面布局方式

文章主要列出比较关键的点

## 主要组件:

1. Row: 横向排列组件
2. TextField: 文本框
3. GestureDetector: 为文本添加事件
4. Text: 文本
5. FlatButton: 按钮

> 以上都可以通过 google: Flutter + 组件名 查询到对应的文档

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
- [ ] 其他