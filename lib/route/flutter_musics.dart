import 'package:flutter/material.dart';
import '../models/musicDatas.dart';
import 'flutter_music_detail.dart';

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage>
    with SingleTickerProviderStateMixin {

  List<MusicModel> musicDatas = new List<MusicModel>();
  int playIndex = 0;

  @override
  void initState() {
    super.initState();
    _requestMusics('薛之谦');
  }

  Future<void> _requestMusics(String searchText) async {
    List<MusicModel> responses = await MusicModel.getMusicData(searchText);
    if (responses.length == 0) {
      return;
    }
    setState(() {
      musicDatas = responses;
    });
  }
  @override
  void dispose() {
    super.dispose();

  }

  _textEdit(){
    var _textEditController = TextEditingController();
    return Container(
//        color: Colors.white,
        padding: EdgeInsets.all(10),
//        height: 55.0,
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            color: Colors.white,
          ),
          height: 50.0,
          child: TextField(
            onSubmitted: (inputText){
                _requestMusics(inputText);
            },
            controller: _textEditController,
            style: TextStyle(
              decorationColor: Colors.black,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              fillColor: Colors.black26,
              prefixStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
              //去掉下划线
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              hintText: '查找精彩动态内容',
              hintStyle: TextStyle(color: Colors.black26),
//                labelText: '左上角',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black26,
              ),
            ),
          ),
        ));
  }

  _appBar() {
    return _textEdit();
  }

  Future<void> _playMusic(int index) async{

    Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) {

          return MusicDetailPage(musicDatas[index]);

      }));
//    return;
//    if(isPlaying==true && playIndex ==index){
//        await audioPlayer.pause();
//        setState(() {
//          isPlaying = false;
//        });
//    }else {
//      await audioPlayer.play(musicDatas[index].url);
//      setState(() {
//        isPlaying = true;
//        playIndex = index;
//      });
//    }

  }

  Widget _itemBuilder(BuildContext context, int index) {

    return ListTile(
      onTap: (){
        _playMusic(index);
      },
      trailing: Icon(Icons.play_circle_filled),
      leading: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: Image.network(musicDatas[index].pic,width: 60,height: 60,),
      ),
      title: Text(musicDatas[index].title),
      subtitle: Text(musicDatas[index].author),
    );
  }

  _body() {
    return ListView.builder(
      itemBuilder: _itemBuilder,
      itemCount: musicDatas.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBar(),
      ),
      body: _body(),
    );
  }
}
