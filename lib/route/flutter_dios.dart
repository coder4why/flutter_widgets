import 'package:flutter/material.dart';
import '../models/dioDatas.dart';
import 'flutter_dios_detail.dart';

class DioWidgets extends StatefulWidget {
  @override
  _DioWidgetsState createState() => _DioWidgetsState();
}

class _DioWidgetsState extends State<DioWidgets>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  List<DioData> datas = new List<DioData>();
  ScrollController _scrollController = ScrollController(); //listview的控制器
  bool isLoading = false; //是否正在加载数据
  bool isTop = true;

  Future<void> _requestData() async {
    currentIndex++;
    List<DioData> responses = await DioData.getDioData(
        'https://api.apiopen.top/getJoke?page=$currentIndex&count=10&type=video');
    if (responses.length == 0) {
      return;
    }
    setState(() {
      isLoading = false;
      responses.map((f) {
        datas.add(f);
      }).toList();
    });
  }

  Future<void> _loadMore() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1), () {
      _requestData();
    });
  }

  @override
  void initState() {
    super.initState();
    _requestData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isTop = false;
        });
        print('滑动到了最底部');
        _loadMore();
      } else if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        setState(() {
          isTop = true;
        });
        print('滑动到了最顶部');
        _loadMore();
      }
    });
  }

  _content(int index) {
    return Container(
//            padding: EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: Image.network(
                datas[index].header,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              datas[index].name,
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
            ),
            subtitle: Text(
              datas[index].text,
              style: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
          ),
          Image.network(
            datas[index].thumbnail,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _bottoms(datas[index]),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 0.5,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    return index < datas.length && index != 0
        ? GestureDetector(
            child: _content(index),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                return DiosDetail(datas[index]);
              }));
            },
          )
        : havaNoMore();
  }

  _bottoms(DioData dataModel) {
    List modelDatas = [
      dataModel.up,
      dataModel.down,
      dataModel.forword,
      dataModel.comment
    ];
    List iCons = [
      Icons.thumb_up,
      Icons.thumb_down,
      Icons.forward,
      Icons.comment
    ];

    List<Widget> widgets = new List<Widget>();
    for (int i = 0; i < modelDatas.length; i++) {
      widgets.add(Container(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              iCons[i],
              size: 15,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              modelDatas[i].toString(),
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
          ],
        ),
      ));
    }

    return widgets;
  }

  Widget havaNoMore() {
    return Container(
      alignment: Alignment.center,
      child: isLoading
          ? SizedBox(
              height: 180,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
//                    height: 60,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.center,
                    child: Text(
                      '正在拼命加载中...',
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                  )
                ],
              ),
            )
          : isTop
              ? null
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 30.0),
                      child: Text(
                        "没有更过内容了，去别的地方看看吧(^_^)",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    )
                  ],
                ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 140,
      color: Colors.white,
      child: ListView.builder(
        controller: _scrollController,
        padding: new EdgeInsets.all(3),
        itemCount: datas.length + 1,
//        itemExtent: 50.0,
        itemBuilder: _listItemBuilder,
      ),
    );
  }
}
