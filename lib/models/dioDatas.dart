import '../tools/DioTool.dart';

class DioData {
  final String text;
  final String thumbnail;
  final String video;
  final String up;

  final String down;
  final String forword;
  final String comment;

  final String header;
  final String name;
  final String passtime;

  DioData(this.text, this.thumbnail, this.video, this.up, this.down,
      this.forword, this.comment, this.header, this.name, this.passtime);

  static Future<List<DioData>> getDioData(String url) async {
    Map response = await DioTool.get(url);

    return jsonToModel(response);
  }

  static List<DioData> jsonToModel(Map repsonse) {
    List<DioData> datas = new List<DioData>();
    List result = repsonse['result'];
    for (int i = 0; i < result.length; i++) {
      Map rowData = result[i];
      DioData dataModel = new DioData(
        rowData['text'],
        rowData['thumbnail'],
        rowData['video'],
        rowData['up'],
        rowData['down'],
        rowData['forward'],
        rowData['comment'],
        rowData['header'],
        rowData['name'],
        rowData['passtime'],
      );

      datas.add(dataModel);
    }

    return datas;
  }
}
