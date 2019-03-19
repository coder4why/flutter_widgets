import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/dropdown.dart';

class FlutterButtons extends StatefulWidget {
  @override
  _FlutterButtonsState createState() => _FlutterButtonsState();
}

class _FlutterButtonsState extends State<FlutterButtons>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
//  'MaterialButton',
//  'FloatingActionButton'
//  'FlatButton'
//  'IconButton',
//  'RaisedButton',
//  'PopupMenuButton',
//  'ButtonBar',   //一组带边距的横排显示按钮
//  'CupertinoButton',
//  'DropdownButton'
//  'Radio'
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> getListData() {
      List<DropdownMenuItem> items = new List();
      items.add(DropdownMenuItem(child: Text("北京"), value: "BeiJing"));
      items.add(DropdownMenuItem(child: Text("上海"), value: "ShangHai"));
      return items;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Buttons', style: TextStyle(fontSize: 20.0)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MaterialButton(onPressed: (){},
            child: Icon(Icons.directions_boat,color: Colors.purple,),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          FlatButton(
              color: Colors.green,
              onPressed: () {},
              child: Icon(
                Icons.list,
                color: Colors.white,
              )),
          IconButton(
              iconSize: 38.0,
              color: Colors.purple,
              icon: Icon(Icons.cloud),
              onPressed: () {}),
          RaisedButton(
            onPressed: () {},
            child: Icon(
              Icons.domain,
              color: Colors.white,
            ),
            color: Colors.brown,
          ),
          PopupMenuButton(
              onSelected: (String value) {
                Toast.show(value, context);
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    new PopupMenuItem(
                        value: "Android-Google", child: new Text("Android")),
                    new PopupMenuItem(
                        value: "iOS-Apple", child: new Text("iOS"))
                  ]),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.local_shipping,
                    color: Colors.green,
                  ),
                  label: Text(
                    'A',
                    style: TextStyle(color: Colors.green),
                  )),
              OutlineButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.local_shipping,
                    color: Colors.green,
                  ),
                  label: Text(
                    'B',
                    style: TextStyle(color: Colors.green),
                  )),
            ],
          ),
          CupertinoButton(
              child: Icon(
                Icons.spa,
                color: Colors.teal,
              ),
              onPressed: () {}),
          DropdownButton(
            items: getListData(),
            hint: new Text('下拉选择你想要的数据'),
            //当没有默认值的时候可以设置的提示
//                value: '下拉',
            //下拉菜单选择完之后显示给用户的值
            onChanged: (T) {
              Toast.show(T, context);
            },
            elevation: 24,
            //设置阴影的高度
            style: new TextStyle(
              //设置文本框里面文字的样式
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
            isDense: false,
            //减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
            iconSize: 35.0, //设置三角标icon的大小
          ),
        ],
      ),
    );
  }
}
