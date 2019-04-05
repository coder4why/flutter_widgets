import '../tools/DioTool.dart';

class WYNewsModel {
  List<PicInfoModel> picInfo;
  String link;
  String source;
  String title;
  String unlikeReason;
  String digest;
  String category;
  String ptime;
  
  WYNewsModel(
    this.picInfo,
    this.link,
    this.source,
    this.title,
    this.unlikeReason,
    this.digest,
    this.category,
    this.ptime,
  );

  static Future<List<WYNewsModel>> getWYNews() async {
    Map response = await DioTool.get('https://www.apiopen.top/journalismApi');
    return WYNewsModel.jsonToModel(response);
  }

  static List<WYNewsModel> jsonToModel(Map repsonse) {
    List<WYNewsModel> datas = new List<WYNewsModel>();
    Map result = Map.from(repsonse['data']);

    List<Map>tech = List.from(result['tech']);
    List<Map>auto = List.from(result['auto']);
    List<Map>money = List.from(result['money']);
    List<Map>sports = List.from(result['sports']);
    List<Map>dy = List.from(result['dy']);
    List<Map>war = List.from(result['war']);
    List<Map>ent = List.from(result['ent']);
    List<Map>toutiao = List.from(result['toutiao']);

    List<Map>results = new List<Map>();
    tech.map((item){
      results.add(item);
    }).toList();
    auto.map((item){
      results.add(item);
    }).toList();
    money.map((item){
      results.add(item);
    }).toList();
    sports.map((item){
      results.add(item);
    }).toList();
    dy.map((item){
      results.add(item);
    }).toList();
    war.map((item){
      results.add(item);
    }).toList();
    ent.map((item){
      results.add(item);
    }).toList();
    war.map((item){
      results.add(item);
    }).toList();

    for (int i = 0; i < results.length; i++) {
      Map rowData = results[i];
      WYNewsModel dataModel = new WYNewsModel(
        PicInfoModel.jsonToModel(List.from(rowData['picInfo'])),
        rowData['link']==null?'':rowData['link'],
        rowData['source']==null?'':rowData['source'],
        rowData['title']==null?'':rowData['title'],
        rowData['unlikeReason']==null?'':rowData['unlikeReason'],
        rowData["digest"]==null?'':rowData['digest'],
        rowData['category']==null?'':rowData['category'],
        rowData['ptime']==null?'':rowData['ptime'],
      );

      datas.add(dataModel);
    }

    return datas;
  }
}

class PicInfoModel {
  String url;
  PicInfoModel(
    this.url,
  );
  
  static List<PicInfoModel> jsonToModel(List<Map> result) {
    List<PicInfoModel> datas = new List<PicInfoModel>();
    for (int i = 0; i < result.length; i++) {
      Map rowData = result[i];
      PicInfoModel dataModel = new PicInfoModel(
        rowData['url'],
      );
      datas.add(dataModel);
    }

    return datas;
  }
  
  
}
