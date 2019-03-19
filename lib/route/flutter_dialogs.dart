import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';
//import 'package:flutter/src/animation/animation.dart';

class FlutterDiaglos extends StatefulWidget {
  @override
  _FlutterDiaglosState createState() => _FlutterDiaglosState();
}

class _FlutterDiaglosState extends State<FlutterDiaglos>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    _simpleDiaglos() {
      return SimpleDialog(
        title: Text('SimpleDialog'),
        children: <Widget>[
          SimpleDialogOption(
            child: Text('Options A'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SimpleDialogOption(
            child: Text('Options B'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }

    _alertDialogs() {
      return AlertDialog(
        title: Text('SimpleDialog'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('静夜诗'),
              Text('床前明月光'),
              Text('疑是地上霜'),
              Text('举头望明月'),
              Text('低头思故乡'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('确定')),
        ],
      );
    }

    _showSimpleDialogs() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return _simpleDiaglos();
          });
    }

    _showAlertDialogs() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return _alertDialogs();
          });
    }

    _listTiles() {
      var tiles = new List<Widget>();
      var icons = [Icons.message, Icons.favorite, Icons.settings];
      var titles = ['Messages', 'Favorite', 'Settings'];
      for (int i = 0; i < titles.length; i++) {
        tiles.add(ListTile(
          title: Text(
            titles[i],
            textAlign: TextAlign.left,
          ),
          trailing: Icon(icons[i], color: Colors.black12, size: 22.0),
          onTap: () => Navigator.pop(context),
        ));
      }
      return tiles;
    }

    _showBottomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return new BottomSheet(
              onClosing: () {},
              builder: (BuildContext context) {
                return Container(
                  height: 240,
                  child: Column(
                    children: _listTiles(),
                  ),
                );
              },
            );
          });
    }

    var _scaffoldkey = new GlobalKey<ScaffoldState>();

    _showSnackBar() {
      _scaffoldkey.currentState.showSnackBar(SnackBar(
//        backgroundColor: Colors.red,
        content: Text(
          'Processing...',
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
        action: SnackBarAction(
            textColor: Colors.white, label: 'Ok', onPressed: () {}),
      ));
    }

    _pannel() {
      var _isExp = false;
      return //
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionPanelList(
                expansionCallback: ((index, exp) {
                  setState(() {
                    _isExp = !_isExp;
                  });
                }),
                children: <ExpansionPanel>[
                  new ExpansionPanel(
                      isExpanded: _isExp,
                      body: new Padding(
                        padding: EdgeInsets.all(10.0),
                        child: new ListBody(
                          children: <Widget>[
                            new Text('这是标题A的内容'),
                          ],
                        ),
                      ),
                      headerBuilder: (context, isExpanded) {
                        return new ListTile(
                          title: new Text('这是标题A'),
                        );
                      }),
                ],
              ));
    }

    _flats() {
      return <Widget>[
        FlatButton(
            onPressed: _showSimpleDialogs,
            color: Colors.green,
            child: Text(
              'SimpleDialog',
              style: TextStyle(color: Colors.white),
            )),
        FlatButton(
            onPressed: _showAlertDialogs,
            color: Colors.green,
            child: Text(
              'AlertDialog',
              style: TextStyle(color: Colors.white),
            )),
        FlatButton(
            onPressed: _showBottomSheet,
            color: Colors.green,
            child: Text(
              'BottomSheet',
              style: TextStyle(color: Colors.white),
            )),
        FlatButton(
            onPressed: _showSnackBar,
            color: Colors.green,
            child: Text(
              'SnackBar',
              style: TextStyle(color: Colors.white),
            )),
        _pannel(),
      ];
    }

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Flutter Dialogs', style: TextStyle(fontSize: 20.0)),
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _flats(),
      )),
    );
  }
}
