import 'package:flutter/material.dart';
import '../models/WYNewsModel.dart';
import 'flutter_wynews_detail.dart';

class WYNewsPage extends StatefulWidget {
  @override
  _WYNewsPageState createState() => _WYNewsPageState();
}

class _WYNewsPageState extends State<WYNewsPage>
    with SingleTickerProviderStateMixin {

  List<WYNewsModel> newsModels = new List<WYNewsModel>();

  _request() async {
    List<WYNewsModel>models = await WYNewsModel.getWYNews();
    if (models.length > 0) {
      setState(() {
        models.map((f) {
          newsModels.add(f);
        }).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _request();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _picWidgets(WYNewsModel model) {
    List<Widget>widgets = new List<Widget>();
    widgets.add(Text(model.title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),));
    for (int i = 0; i < model.picInfo.length; i++) {
      widgets.add(
          Image.network(
            model.picInfo[i].url, fit: BoxFit.cover, width: MediaQuery
              .of(context)
              .size
              .width,)
      );
    }
    widgets.add(Text(model.digest));
    widgets.add(Text(model.unlikeReason));
    widgets.add(Text(model.ptime));
    widgets.add(Divider(color: Colors.black26,));

    return widgets;
  }

  _newsDetail(WYNewsModel model) {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context)
    {
      return new WYNewsDetailPage(model);
    }));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    WYNewsModel model = newsModels[index];
    return GestureDetector(
      onTap: () => _newsDetail(model),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _picWidgets(model),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height - 120,
      child: ListView.builder(
        itemBuilder: _itemBuilder, itemCount: newsModels.length,),
    );
  }
}
