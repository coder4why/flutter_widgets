import '../tools/DioTool.dart';
import 'dart:convert';
class MusicDetailModel{

//  https://api.apiopen.top/musicRankingsDetails?type=2
  String country;
  String artist_name;
  String language;

  String album_1000_1000;
  String pic_huge;
  String song_id;
  String album_500_500;

  String rank;
  String pic_premium;
  String si_proxycompany;

  String author;
  String all_artist_ting_uid;
  String publishtime;

  String album_id;
  String pic_big;
  String title;

  String lrclink;
  String pic_radio;
  String pic_s500;

  String pic_small;
  String album_title;

  MusicDetailModel(this.country,
      this.artist_name,
      this.language,
      this.album_1000_1000,
      this.pic_huge,
      this.song_id,
      this.album_500_500,
      this.rank,
      this.pic_premium,
      this.si_proxycompany,

      this.author,
      this.all_artist_ting_uid,
      this.publishtime,
      this.album_id,
      this.pic_big,
      this.title,
      this.lrclink,
      this.pic_radio,
      this.pic_s500,
      this.pic_small,
      this.album_title,
      );

  static Future<List<MusicDetailModel>> getMusics(String type) async {
//    https://api.apiopen.top/musicRankings
    Map response = await DioTool.get('https://api.apiopen.top/musicRankingsDetails?type=$type');
    return MusicDetailModel.jsonToModel(response);
  }

  static List<MusicDetailModel> jsonToModel(Map repsonse) {
    List<MusicDetailModel> datas = new List<MusicDetailModel>();
    List result = repsonse['result'];
    for (int i = 0; i < result.length; i++) {
      Map rowData = result[i];
      MusicDetailModel dataModel = new MusicDetailModel(
        rowData['country'],
        rowData['artist_name'],
        rowData['language'],
        rowData['album_1000_1000'],
        rowData['pic_huge'],
        rowData['song_id'],
        rowData['album_500_500'],
        rowData['rank'],
        rowData['pic_premium'],
        rowData['si_proxycompany'],
        rowData['author'],
        rowData['all_artist_ting_uid'],
        rowData['publishtime'],
        rowData['album_id'],
        rowData['pic_big'],
        rowData['title'],
        rowData['lrclink'],
        rowData['pic_radio'],
        rowData['pic_s500'],
        rowData['pic_small'],
        rowData['album_title'],
      );

      datas.add(dataModel);
    }

    return datas;
  }
}

class MusicXQModel{
//  https://api.apiopen.top/musicDetails?id=604392760
    List<SongListModel>songList;
    MusicXQModel(this.songList);
    static Future<MusicXQModel> getMusics(String song_id) async {
//    https://api.apiopen.top/musicRankings
      Map response = await  DioTool.get('https://api.apiopen.top/musicDetails?id=$song_id');
      return MusicXQModel.jsonToModel(response);
    }
    static MusicXQModel jsonToModel(Map repsonse) {
      MusicXQModel xqModel = new MusicXQModel([]);
      Map result = new Map.from(repsonse['result']);
      List<Map> songList = new List.from(result['songList']);
      for (int i = 0; i < songList.length; i++) {
        SongListModel model = SongListModel.jsonToModel(songList[i]);
        xqModel.songList.add(model);
      }
      return xqModel;
    }
}

class SongListModel{
  String songName;
  String albumName;
  String albumId;
  String songPicBig;

  String songLink;
  String lrcLink;
  String artistName;

  String songPicSmall;
  String songPicRadio;
  String showLink;

  SongListModel(this.songName,
      this.albumName,
      this.albumId,
      this.songPicBig,
      this.songLink,
      this.lrcLink,
      this.artistName,
      this.songPicSmall,
      this.songPicRadio,
      this.showLink,
      );

  static SongListModel jsonToModel(Map repsonse) {
    List<SongListModel> datas = new List<SongListModel>();
      Map rowData = repsonse;
    SongListModel dataModel = new SongListModel(
        rowData['songName'],
        rowData['albumName'],
        rowData['albumId'].toString(),
        rowData['songPicBig'],
        rowData['songLink'],
        rowData['lrcLink'],
        rowData['artistName'],
        rowData['songPicSmall'],
        rowData['songPicRadio'],
        rowData['showLink'],
      );

    return dataModel;
  }
}