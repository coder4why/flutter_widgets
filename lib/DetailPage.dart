import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  //外部参数
  DetailPage(this.title);
  String title;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title,style: TextStyle(fontSize: 15.0)),
        ),
        body: Center(
          child: Text(widget.title,style: TextStyle(fontSize: 20.0),),
        ),
      ),
    );
  }
}
