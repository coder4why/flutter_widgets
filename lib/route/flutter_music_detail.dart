import 'package:flutter/material.dart';
import '../models/musicDatas.dart';
import 'dart:ui' as ui show ImageFilter;
import '../widgets/needle_anim.dart';
import '../widgets/record_anim.dart';
import 'package:audioplayer/audioplayer.dart';

class MusicDetailPage extends StatefulWidget {
  MusicDetailPage(this.model);

  MusicModel model;

  @override
  _MusicDetailPageState createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage>
    with TickerProviderStateMixin {
  AudioPlayer audioPlayer = new AudioPlayer();
  AnimationController controller_needle;
  Animation<double> animation_needle;
  AnimationController controller_record;
  Animation<double> animation_record;
  final _commonTween = new Tween<double>(begin: 0.0, end: 1.0);
  final _rotateTween = new Tween<double>(begin: -0.15, end: 0.0);

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    print('😂----😄：${widget.model.pic}');
    controller_record = new AnimationController(
        duration: const Duration(milliseconds: 15000), vsync: this);
    animation_record =
        new CurvedAnimation(parent: controller_record, curve: Curves.linear);

    controller_needle = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation_needle =
        new CurvedAnimation(parent: controller_needle, curve: Curves.linear);

    animation_record.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller_record.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller_record.forward();
      }
    });

    _playMusic();
  }

  Future<void> _playMusic() async {
    if (isPlaying == true) {
      await audioPlayer.pause();
      controller_record.stop(canceled: false);
      controller_needle.reverse();
      setState(() {
        isPlaying = false;
      });
    } else {
      await audioPlayer.play(widget.model.url);
      controller_record.forward();
      controller_needle.forward();
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    audioPlayer.stop();
    controller_needle.dispose();
    controller_record.dispose();
    super.dispose();
  }

  _centerCirclePic() {
    return Container(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(150)),
        child: Image.network(
          widget.model.pic,
          width: 300,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _picAni() {
    return new Container(
      child: RotateRecord(
        animation: _commonTween.animate(controller_record),
        imageUrl: widget.model.pic,
      ),
      margin: EdgeInsets.only(top: 100.0),

    );
  }

  _picAnimated() {
    final _rotateTween = new Tween<double>(begin: 0, end: 0.0);
    return new Container(
      child: new PivotTransition(
          turns: _rotateTween.animate(controller_needle),
          alignment: FractionalOffset.topLeft,
          child: _centerCirclePic()),
    );
  }

  _stack() {
    return new Stack(
      alignment: const FractionalOffset(0.7, 0.1),
      children: <Widget>[
        new Container(
          child:
              RotateRecord(animation: _commonTween.animate(controller_record)),
          margin: EdgeInsets.only(top: 100.0),
        ),
        new Container(
          child: new PivotTransition(
            turns: _rotateTween.animate(controller_needle),
            alignment: FractionalOffset.topLeft,
            child: new Container(
              width: 100.0,
              child: new Image.asset("images/play_needle.png"),
            ),
          ),
        ),
      ],
    );
  }

  _bgFlur() {
    List<Widget> widgets = [
      Image.network(
        widget.model.pic,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
      BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.black.withOpacity(0),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _picAni(),
          IconButton(
              iconSize: 40,
              color: Colors.black87,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                _playMusic();
              }),
        ],
      ),
    ];
    return widgets;
  }

  _body() {
    return Center(
      child: Stack(
        alignment: const FractionalOffset(0.5, 0.0),
        children: _bgFlur(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
