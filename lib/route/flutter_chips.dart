import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class FlutterChips extends StatefulWidget {
  @override
  _FlutterChipsState createState() => _FlutterChipsState();
}

class _FlutterChipsState extends State<FlutterChips>
    with SingleTickerProviderStateMixin {
  List texts;
  List images;
  List colors;
  List selected;
  int selectIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _resetData();
  }

  _resetData() {
    selected = new List<String>();
    texts = <String>[
      'Apple',
      'Google',
      'Amazon',
    ];
    images = [
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1552970295055&di=79f268bfaf1b9a14fbf671c9b6895470&imgtype=0&src=http%3A%2F%2Fimg0.pconline.com.cn%2Fpconline%2F1508%2F27%2F6879418_1955_thumb.jpg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1552970295055&di=cd93cf1cc9861e5304b2aa4604fc146e&imgtype=0&src=http%3A%2F%2Fimg0.pconline.com.cn%2Fpconline%2F1511%2F29%2F7257120_901_thumb.jpg',
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1552970295050&di=e4dfff4fa62228ad343e81f78447ccef&imgtype=0&src=http%3A%2F%2Fpic85.nipic.com%2Ffile%2F20151217%2F19738529_153944186231_2.jpg',
    ];
    colors = [
      Colors.red,
      Colors.grey,
      Colors.teal,
    ];
  }

  _chips() {
    var chips = new List<Widget>();
    for (int i = 0; i < colors.length; i++) {
      String text = texts[i];
      Color color = colors[i];
      String image = images[i];
      chips.add(Chip(
        label: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        avatar: i==0?CircleAvatar(backgroundImage: NetworkImage(image)):null,
        backgroundColor: color,
        deleteButtonTooltipMessage: 'Delete',
        deleteIcon: i==1?Icon(
          Icons.delete_forever,
          color: Colors.white,
        ):null,
        onDeleted: () {
          setState(() {
            colors.remove(color);
            texts.remove(text);
            images.remove(image);
          });
        },
      ));
      chips.add(SizedBox(
        width: 8,
      ));
    }
    return chips;
  }

  _actionChips() {
    List actionChips = new List<Widget>();
    actionChips.add(Divider(
      color: Colors.grey,
      height: 32.0,
    ));
    for (int i = 0; i < colors.length; i++) {
      actionChips.add(ActionChip(
          label: Text(texts[i]),
          onPressed: () {
            Toast.show(texts[i], context);
          }));
      actionChips.add(SizedBox(
        width: 8,
      ));
    }

    return actionChips;
  }

  _filterChips() {
    List filterChips = new List<Widget>();
    filterChips.add(Divider(
      color: Colors.grey,
      height: 32.0,
    ));

    for (int i = 0; i < texts.length; i++) {
      filterChips.add(FilterChip(
        label: Text(texts[i]),
        selected: selected.contains(texts[i]),
        onSelected: (value) {
          Toast.show(texts[i], context);
          setState(() {
            if (selected.contains(texts[i])) {
              selected.remove(texts[i]);
            } else {
              selected.add(texts[i]);
            }
          });
        },
      ));
      filterChips.add(SizedBox(
        width: 8,
      ));
    }

    return filterChips;
  }

  _choiceChips() {
    List choiceChips = new List<Widget>();
    choiceChips.add(Divider(
      color: Colors.grey,
      height: 32.0,
    ));

    for (int i = 0; i < texts.length; i++) {
      choiceChips.add(ChoiceChip(
        backgroundColor: Colors.grey,
        label: Text(texts[i],style: TextStyle(color: Colors.white),),
        selected: selectIndex == i,
        selectedColor: Colors.black,
        onSelected: (value) {
          setState(() {
           selectIndex = i;
          });
        },
      ));
      choiceChips.add(SizedBox(
        width: 8,
      ));
    }

    return choiceChips;
  }

  _widgets() {
    List widgets = new List<Widget>();
    _chips().map((chip) {
      widgets.add(chip);
    }).toList();
    _actionChips().map((item) {
      widgets.add(item);
    }).toList();

    _filterChips().map((item) {
      widgets.add(item);
    }).toList();

    _choiceChips().map((item){
      widgets.add(item);
    }).toList();
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _resetData();
          });
        },
        backgroundColor: Colors.red,
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text('Flutter Chips', style: TextStyle(fontSize: 20.0)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Wrap(
            children: _widgets(),
          )
        ],
      )),
    );
  }
}
