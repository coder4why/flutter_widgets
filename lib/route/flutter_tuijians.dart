import 'package:flutter/material.dart';
import '../models/HotModel.dart';

class TuiJianDemo extends StatefulWidget {
  bool isHome;

  TuiJianDemo(this.isHome);

  @override
  _TuiJianDemoState createState() => _TuiJianDemoState();
}

class _TuiJianDemoState extends State<TuiJianDemo>
    with SingleTickerProviderStateMixin {
  List<HotModel> hotModels = new List<HotModel>();

  _requestModels() async {
    List<HotModel> models = await HotModel.getHotModels();
    if (models.length > 0) {
      setState(() {
        models.forEach((f) {
          hotModels.add(f);
        });
      });
    }

    print('输出一下：${hotModels.length}');
  }

  @override
  void initState() {
    super.initState();
    _requestModels();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _textEdit() {
    var _textEditController = TextEditingController();
    return Container(
//        color: Colors.white,
        width: MediaQuery.of(context).size.width / 1.1,
        padding: EdgeInsets.all(10),
//        height: 55.0,
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            color: Colors.white,
          ),
          height: 50.0,
          child: TextField(
            onSubmitted: (inputText) {
//              _requestMusics(inputText);
            },
            controller: _textEditController,
            style: TextStyle(
              decorationColor: Colors.black,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              fillColor: Colors.black26,
              prefixStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
              //去掉下划线
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              hintText: '歌曲名、专辑名称、歌手',
              hintStyle: TextStyle(color: Colors.black26),
//                labelText: '左上角',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black26,
              ),
            ),
          ),
        ));
  }

  _textBox(int index) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Image.network(
                hotModels[index].header,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
              title: Text(hotModels[index].username),
              subtitle: Text(hotModels[index].text),
            ),
            Text(
              hotModels[index].text,
              style: TextStyle(fontSize: 17),
            ),
            Divider()
          ],
        ));
  }

  _imageBox(int index) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Image.network(
                hotModels[index].header,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
              title: Text(hotModels[index].username),
              subtitle: Text(hotModels[index].text),
            ),
            Image.network(
              hotModels[index].thumbnail,
              fit: BoxFit.cover,
            ),
            Divider()
          ],
        ));
  }

  _gifBox(int index) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Image.network(
                hotModels[index].header,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
              title: Text(hotModels[index].username),
              subtitle: Text(hotModels[index].text),
            ),
            Image.network(
              hotModels[index].gif,
              fit: BoxFit.cover,
            ),
            Divider()
          ],
        ));
  }

  _videoBox(int index) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Image.network(
                hotModels[index].header,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
              title: Text(hotModels[index].username),
              subtitle: Text(hotModels[index].text),
            ),
            Image.network(
              hotModels[index].thumbnail,
              fit: BoxFit.cover,
            ),
            Divider()
          ],
        ));
  }

  Widget _listMusics(BuildContext context, int index) {
    HotModel model = hotModels[index];
    if (model.type.toLowerCase() == 'video') {
      return _videoBox(index);
    } else if (model.type.toLowerCase() == 'image') {
      return _imageBox(index);
    } else if (model.type.toLowerCase() == 'gif') {
      return _gifBox(index);
    } else {
      return _textBox(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isHome) {
      return Container(
//        color: Colors.black,
        height: MediaQuery.of(context).size.height - 127,
        child: ListView.builder(
          itemBuilder: _listMusics,
          itemCount: hotModels.length,
        ),
      );

    } else {
      return Scaffold(
        appBar: AppBar(
          title: _textEdit(),
        ),
        body: ListView.builder(
          itemBuilder: _listMusics,
          itemCount: hotModels.length,
        ),
      );
    }
  }
}
