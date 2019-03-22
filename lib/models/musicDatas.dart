import '../tools/DioTool.dart';

class MusicModel {
  final String author;
  final String link;
  final String pic;
  final String type;
  final String title;
  final String lrc;
  final String songid;
  final String url;


  MusicModel(this.author, this.link, this.pic, this.type, this.title,
      this.lrc, this.songid, this.url);

  static Future<List<MusicModel>> getMusicData(String searchText) async {
    Map response = await DioTool.get('https://api.apiopen.top/searchMusic?name=$searchText');
    return jsonToModel(response);
  }

  static List<MusicModel> jsonToModel(Map repsonse) {
    List<MusicModel> datas = new List<MusicModel>();
    List result = repsonse['result'];
    for (int i = 0; i < result.length; i++) {
      Map rowData = result[i];
      MusicModel dataModel = new MusicModel(
        rowData['author'],
        rowData['link'],
        rowData['pic'],
        rowData['type'],
        rowData['title'],
        rowData['lrc'],
        rowData['songid'].toString(),
        rowData['url'],
      );

      datas.add(dataModel);
    }

    return datas;
  }
}
