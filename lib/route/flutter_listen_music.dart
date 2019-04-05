import 'package:flutter/material.dart';
import '../models/ListenModel.dart';
import 'flutter_listen_music_detail.dart';
import '../models/MusicDetailModel.dart';
import '../models/musicDatas.dart';
import 'flutter_music_detail.dart';

class ListenMusicPage extends StatefulWidget {
  @override
  _ListenMusicPageState createState() => _ListenMusicPageState();
}

class _ListenMusicPageState extends State<ListenMusicPage>
    with SingleTickerProviderStateMixin {
  List<ListenModel> listenModels = new List<ListenModel>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _requestMusic() async {
    List<ListenModel> models = await ListenModel.getMusics();
    if (models.length > 0) {
      setState(() => _loadModels(models));
    }
  }

  _loadModels(List<ListenModel> models){
    models.map((model) {
      listenModels.add(model);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _requestMusic();
  }

  @override
  void dispose() {
    super.dispose();
  }
  _playMusic(ContentModel model) async {
    MusicXQModel xqModel = await MusicXQModel.getMusics(
        model.song_id);
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

  _playIndex(int index) {
    String type = listenModels[index].type;
    String name = listenModels[index].name;
    print(name);
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ListenMusicDetailPage(type, name);
    }));
  }

  List<Widget> _gridViewChilds(int index) {
    List<ContentModel> models = listenModels[index].content;
    List<Widget> widgets = new List<Widget>();
    for (int i = 0; i < models.length; i++) {
      widgets.add(
        GestureDetector(
          onTap: ()=>_playMusic(models[i]),
          child: Container(
//        height: 180,
//          aspectRatio: 1.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
//              color: Colors.red,
                  width: (MediaQuery.of(context).size.width - 10) / 2.0,
                  height: 110,
                  child: ClipRRect(
                    child: Image.network(
                      models[i].pic_big,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  models[i].author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  models[i].album_title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        )
      );
    }
    return widgets;
  }

  Widget _musicWidget(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            ListTile(
              contentPadding: EdgeInsets.only(
                left: 0,
              ),
              leading: ClipRRect(
                child: Image.network(
                  listenModels[index].pic_s260,
                  width: 50,
                  height: 50,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              trailing: FlatButton(
                  onPressed: ()=>_playIndex(index),
                  child: Text(
                    '查看更多>',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  )),
              title: Text(
                listenModels[index].name,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                listenModels[index].comment,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                primary: false,
//                    padding: const EdgeInsets.all(5.0),
                crossAxisSpacing: 10.0,
                crossAxisCount: 2,
                children: _gridViewChilds(index),
              ),
            ),
            Divider(color: Colors.black26,),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('一起来听歌'),
      ),
      body: ListView.builder(
        itemBuilder: _musicWidget,
        itemCount: listenModels.length,
      ),
    );
  }
}
