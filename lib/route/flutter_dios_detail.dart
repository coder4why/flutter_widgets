import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/dioDatas.dart';

class DiosDetail extends StatefulWidget {

  DiosDetail(this.dataModel);
  DioData dataModel;

  @override
  _DiosDetailState createState() => _DiosDetailState();
}

class _DiosDetailState extends State<DiosDetail>
    with SingleTickerProviderStateMixin {
  VideoPlayerController controller;
  bool initialized = false;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    //初始化播放控件
    controller = VideoPlayerController.network(widget.dataModel.video);

    //视频初始化
    controller.initialize().then((value) {
      initialized = true;
      //刷新页面显示播放器
      setState(() {
        controller.play();
        isPlaying = true;
      });
    });
  }

  _video() {
    if (initialized) {
      final Size size = controller.value.size;
      return SizedBox(
          width: controller.value.size.width - 10,
          child: AspectRatio(
            aspectRatio: size.width / size.height,
            child: VideoPlayer(controller),
          ));
    } else {
      return new Container();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.pause();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          setState(() {
            isPlaying ? controller.pause() : controller.play();
            isPlaying = !isPlaying;
          });
        },
        child: Icon(
          isPlaying ? Icons.play_arrow : Icons.pause,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text('视频', style: TextStyle(fontSize: 18.0)),
      ),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _video(),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.network(widget.dataModel.header,width: 60,height: 60,),
                ),
                title: Text(widget.dataModel.name),
                subtitle: Text(widget.dataModel.text),
              ),
            ),
          ],
        )
      ]),
    ));
    ;
  }
}
