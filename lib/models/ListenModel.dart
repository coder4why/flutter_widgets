import '../tools/DioTool.dart';
class ListenModel{

//  https://api.apiopen.top/musicRankings
  String pic_s210;
  String bg_pic;
  String pic_s444;

  String count;
  String type;
  List<ContentModel> content;
  String name;

  String comment;
  String pic_s192;
  String pic_s260;

  ListenModel(this.pic_s210,
      this.bg_pic,
      this.pic_s444,
      this.count,
      this.type,
      this.content,
      this.name,
      this.comment,
      this.pic_s192,
      this.pic_s260,
      );

 static Future<List<ListenModel>> getMusics() async {
//    https://api.apiopen.top/musicRankings
    Map response = await DioTool.get('https://api.apiopen.top/musicRankings');
    return ListenModel.jsonToModel(response);
  }

  static List<ListenModel> jsonToModel(Map repsonse) {
    List<ListenModel> datas = new List<ListenModel>();
    List result = repsonse['result'];
    for (int i = 0; i < result.length; i++) {
      Map rowData = result[i];
      List<Map> content = new List.from(rowData['content']);
      ListenModel dataModel = new ListenModel(
        rowData['pic_s210'],
        rowData['bg_pic'],
        rowData['pic_s444'],
        rowData['count'].toString(),
        rowData['type'].toString(),
        ContentModel.contentToModel(content),
        rowData['name'],
        rowData['comment'],
        rowData['pic_s192'],
        rowData['pic_s260'],
      );

      datas.add(dataModel);
    }

    return datas;
  }
}

class ContentModel {
  String song_id;
  String author;
  String album_id;

  String pic_small;
  String title;
  String pic_s260;

  String pic_big;
  String album_title;

  ContentModel(this.song_id,
      this.author,
      this.album_id,
      this.pic_small,
      this.title,
      this.pic_s260,
      this.pic_big,
      this.album_title);

  static List<ContentModel> contentToModel(List<Map> content) {
    List<ContentModel> listModels = new List<ContentModel>();
    content.map((f) {
      ContentModel model = new ContentModel(
          f['song_id'],
          f['author'],
          f['album_id'],
          f['pic_small'],
          f['title'],
          f['pic_s260'],
          f['pic_big'],
          f['album_title'],);
      listModels.add(model);
    }).toList();

    return listModels;
  }

}

