
import '../tools/DioTool.dart';

class HotModel {
//  type=text : 文字
//  type=image : 图片
//  type=gif : Gif
//  type=video: 视频
  String type;
  String text;
  String username;
  String uid;

  String header;
  String comment;
  String top_commentsVoiceuri;
  String top_commentsContent;

  String top_commentsHeader;
  String top_commentsName;
  String passtime;
  String soureid;

  String up;
  String down;
  String forward;
  String image;

  String gif;
  String thumbnail;
  String video;

  HotModel(
    this.type,
    this.text,
    this.username,
    this.uid,
    this.header,
    this.comment,
    this.top_commentsVoiceuri,
    this.top_commentsContent,
    this.passtime,
    this.soureid,
    this.up,
    this.down,
    this.forward,
    this.image,
    this.gif,
    this.thumbnail,
    this.video,
  );

 static Future<List<HotModel>> getHotModels() async {
    
    Map response = await DioTool.get('https://www.apiopen.top/satinGodApi?type=1&page=1');
    return jsonToModel(response);
  }


  static List<HotModel> jsonToModel(Map repsonse) {
    List<HotModel> datas = new List<HotModel>();
    List result = repsonse['data'];
    for (int i = 0; i < result.length; i++) {
      Map rowData = result[i];
      HotModel dataModel = new HotModel(
        rowData['type'].toString(),
        rowData['text'],
        rowData['username'],
        rowData['uid'],
        rowData['header'],
        rowData['comment'].toString(),
        rowData['top_commentsVoiceuri'],
        rowData['top_commentsContent'],
        rowData['passtime'],
        rowData['soureid'].toString(),
        rowData['up'].toString(),
        rowData['down'].toString(),
        rowData['forward'].toString(),
        rowData['image'],
        rowData['gif'],
        rowData['thumbnail'],
        rowData['video'],
      );

      datas.add(dataModel);
    }

    return datas;
  }
}
