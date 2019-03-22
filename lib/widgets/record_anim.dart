import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class RotateRecord extends AnimatedWidget {

  String imageUrl;
  RotateRecord({Key key,this.imageUrl, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      height: 250.0,
      width: 250.0,
      child: new RotationTransition(
          turns: animation,
          child: new Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    imageUrl),
              ),
            ),
          )),
    );
  }
}
