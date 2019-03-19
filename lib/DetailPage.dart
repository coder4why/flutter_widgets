import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:math';

class DetailPage extends StatefulWidget {
  //外部参数
  DetailPage(this.title);

  String title;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var bsJSon;
  String imageUrl = '';

  _loadDatas() async {
    //https://jsonplaceholder.typicode.com/posts
//    http://d.api.budejie.com/topic/list/zuixin/41/bs0315-ios-4.5.9/0-20.json
    String dataURL =
        "http://d.api.budejie.com/topic/list/zuixin/41/bs0315-ios-4.5.9/0-20.json";
    http.Response response = await http.get(dataURL);
    setState(() {
      bsJSon = json.decode(response.body);
      imageUrl = bsJSon['list'][Random().nextInt(19)]['video']['thumbnail'][0]
          .toString();
    });

//    _alertMegs(bsJSon['list'][Random().nextInt(19)]['video']['thumbnail'][0].toString());
  }

  _alertMegs(String text) {
    Toast.show(text, context,
        gravity: 0,
        backgroundRadius: 4,
        backgroundColor: Colors.black87,
        duration: 2);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _loadDatas();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title, style: TextStyle(fontSize: 15.0)),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 20.0),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fitWidth,
                    width: 250,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
