import 'package:flutter/material.dart';
import '../models/dioDatas.dart';
import 'package:video_player/video_player.dart';


class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  VideoPlayerController controller;
  bool initialized = false;
  int pageNumber = 0;
  bool isPlaying = false;
  int currentIndex = 0;
  List<DioData> videoModels = new List<DioData>();

  Future<void> _requetModels() async {
    pageNumber++;
    List<DioData> responses = await DioData.getDioData(
        'https://api.apiopen.top/getJoke?page=$pageNumber&count=10&type=video');
    if (responses.length == 0) {
      return;
    }
    setState(() {
      responses.map((f) {
        videoModels.add(f);
      }).toList();
    });
    if(initialized == false){
      _initVideoPlayer(0);
    }
  }

  @override
  void initState() {
    super.initState();
    _requetModels();
  }

  _initVideoPlayer(int index){
    setState(() {
      currentIndex = index;
    });
    if(isPlaying==true){
      controller.pause();
      setState(() {
        isPlaying = false;
      });
    }
    //初始化播放控件
    controller = VideoPlayerController.network(videoModels[index].video)
    // 播放状态
    ..addListener(() {
      final bool playing = controller.value.isPlaying;
      setState(() {
        isPlaying = playing;
      });
    });
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _pageBuilder(BuildContext context, int index) {

    return Container(
      color: Colors.black.withOpacity(0.3),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: _stack(index),
    );
  }

  _bgImage(int index){

    return Image.network(
      videoModels[index].thumbnail,
      fit: BoxFit.cover,
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
    );
  }
  _video(int index){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: SizedBox(
          child: AspectRatio(
            aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
            child: VideoPlayer(controller),
          )),
    );
  }

  _stack(int index){

    return Stack(
      children: <Widget>[
//        _bgImage(index),
        isPlaying && index==currentIndex?_video(index):_bgImage(index),
      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.arrow_back,size: 30,),
          onPressed: () {
        Navigator.pop(context);
      }),
      body: PageView.builder(
        onPageChanged: (int index){
          _initVideoPlayer(index);
        },
        scrollDirection: Axis.vertical,
        itemBuilder: _pageBuilder,
        itemCount: videoModels.length,
      ),
    );
  }
}
