import 'package:flutter/material.dart';
import '../models/MusicDetailModel.dart';
import '../models/musicDatas.dart';
import 'flutter_music_detail.dart';

class ListenMusicDetailPage extends StatefulWidget {
  String type;
  String rankName;

  ListenMusicDetailPage(this.type, this.rankName);

  @override
  _ListenMusicDetailPageState createState() => _ListenMusicDetailPageState();
}

class _ListenMusicDetailPageState extends State<ListenMusicDetailPage>
    with SingleTickerProviderStateMixin {
  List<MusicDetailModel> listenModels = new List<MusicDetailModel>();

  _requestModels() async {
    List<MusicDetailModel> models =
        await MusicDetailModel.getMusics(widget.type);
    if (models.length > 0) {
      setState(() {
        models.map((model) {
          listenModels.add(model);
        }).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _requestModels();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _playIndex(int index) async{

      MusicXQModel xqModel = await MusicXQModel.getMusics(listenModels[index].song_id);
      if (xqModel.songList.length > 0) {
        SongListModel songModel = xqModel.songList[0];
        MusicModel model = new MusicModel(
            songModel.albumName,
            '',
            songModel.songPicBig,
            '',
            songModel.albumName,
            songModel.lrcLink,
            '',
            songModel.songLink);

        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new MusicDetailPage(model);
        }));
      }

  }

  Widget _listItem(BuildContext context, int index) {
    return  ListTile(
        leading: Image.network(
          listenModels[index].pic_big,
          width: 50,
        ),
        title: Text(listenModels[index].title),
        subtitle: Text(listenModels[index].author),
      onTap: ()=>_playIndex(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rankName),
      ),
      body: ListView.builder(
          itemBuilder: _listItem,
          itemCount: listenModels.length
      ),
    );
  }
}
