import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class InterActives extends StatefulWidget {
  int index;

  InterActives(this.index);

  @override
  _InterActivesState createState() => _InterActivesState();
}

class _InterActivesState extends State<InterActives>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldState;

  @override
  void initState() {
    super.initState();
    scaffoldState = new GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    super.dispose();
  }

//  'LongPressDraggable',
//  'GestureDetector',
//  'DragTarget',
//  'Dismissible',
//  'IgnorePointer',
//  'AbsorbPointer',
//  'Navigator',
//  'Scrollable',
  @override
  Widget build(BuildContext context) {
    //长按
    _longPressDraggable() {

      return LongPressDraggable(
          onDragCompleted: () {
            Toast.show('onDragCompleted', context);
          },
          child: Icon(
            Icons.add_alert,
            color: Colors.green,
            size: 30,
          ),
          feedback: Icon(Icons.mouse,color: Colors.grey,) );
    }

    _gestureDetector() {
      return GestureDetector(
        onLongPress: (){
          Toast.show('我长按了一下', context);
        },
        onTap: () {
          Toast.show('点击手势', context);
        },
        child: Icon(
          Icons.wb_sunny,
          color: Colors.indigo,
          size: 30,
        ),
      );
    }

    _dismissibel() {
      return Dismissible(
          key: Key('dismissible'),
          secondaryBackground: Text(
            'Delete',
            style: TextStyle(color: Colors.red, fontSize: 33),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            Toast.show('删除成功', context);
            scaffoldState.currentState.showSnackBar(SnackBar(
              content: Text(
                'Dismissible Processed...',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
              action: SnackBarAction(
                  textColor: Colors.white, label: 'Ok', onPressed: () {}),
            ));
          },
          background: new Container(
            color: Colors.red,
          ),
          child: ListTile(
            title: new Text('Options A'),
            subtitle: new Text('Click Me And Dismissed'),
            leading: Icon(
              Icons.check_box,
              color: Colors.grey,
              size: 20,
            ),
            trailing: Icon(
              Icons.explore,
              color: Colors.grey,
              size: 20,
            ),
          ));
    }

    _widgets() {
      List<Widget> widgets = [
        _longPressDraggable(),
        _gestureDetector(),
        _dismissibel()
      ];
      return widgets;
    }

    return Scaffold(
      appBar: AppBar(
        key: scaffoldState,
        title: Text('Flutter InterActives', style: TextStyle(fontSize: 20.0)),
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _widgets(),
      )),
    );
  }
}
