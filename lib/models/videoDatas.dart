import '../tools/DioTool.dart';

class VideoModel {
  final String text;
  final String name;
  final String screen_name;
  final String profile_image;
  final String love;
  final String hate;
  final String comment;

  final String repost;
  final String bookmark;

  final String bimageuri;

  final String videouri;
  final String playcount;
  final String image1;

  VideoModel(
    this.text,
    this.name,
    this.screen_name,
    this.profile_image,
    this.love,
    this.hate,
    this.comment,
    this.repost,
    this.bookmark,
    this.bimageuri,
    this.videouri,
    this.playcount,
    this.image1,
  );

  static Future<List<VideoModel>> getVideoData(int page) async {
    Map response =
        await DioTool.get('https://www.apiopen.top/satinApi?type=1&page=$page');

    return jsonToModel(response);
  }

  static List<VideoModel> jsonToModel(Map repsonse) {
    List<VideoModel> datas = new List<VideoModel>();
    List result = repsonse['data'];
    for (int i = 0; i < result.length; i++) {
      Map rowData = result[i];
      VideoModel dataModel = new VideoModel(
        rowData['text'],
        rowData['name'],
        rowData['screen_name'],
        rowData['profile_image'],
        rowData['love'],
        rowData['hate'],
        rowData['comment'],
        rowData['repost'],
        rowData['bookmark'],
        rowData['bimageuri'],
        rowData['videouri'],
        rowData['playcount'],
        rowData['image1'],
      );

      datas.add(dataModel);
    }

    return datas;
  }
}
