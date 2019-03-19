import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class FlutterOthers extends StatefulWidget {
  @override
  _FlutterOthersState createState() => _FlutterOthersState();
}

//'Slider',
//'Switch',
//'SwitchListTile',
//'DatePicker',
//'TimePicker',
//'Radio',
//'RadioListTile',
//'CheckBox',
//'CheckBoxListTile',
class _FlutterOthersState extends State<FlutterOthers>
    with SingleTickerProviderStateMixin {
  double sliderValue = 10;
  bool switched = false;
  List<bool> switchTiles = [false, false];
  List<bool> checkBoxTiles = [false, false];
  var groupIndex = 3;
  bool checkBox = false;

  _slider() {
    return Container(
      padding: EdgeInsets.only(top: 60),
      child: Slider(
        value: sliderValue,
        activeColor: Colors.blue[900],
        inactiveColor: Colors.blue[900].withOpacity(0.3),
        divisions: 10,
        label: '${sliderValue.toInt()}',
        onChanged: (value) {
          setState(() {
            sliderValue = value;
          });
        },
        max: 100,
        min: 0,
      ),
    );
  }

  _label() {
    return Text('SliderValue:${sliderValue.toInt()}');
  }

  _switch() {
    return Switch(
        value: switched,
        onChanged: (isSwitch) {
          setState(() {
            switched = isSwitch;
          });
        });
  }

  _switchListTile() {
    List<Widget> switchLists = new List<Widget>();
    List titles = ['ShangHai', 'BeiJing', 'ShenZheng'];
    for (int i = 0; i < switchTiles.length; i++) {
      switchLists.add(SwitchListTile(
          activeColor: Colors.green[600],
          inactiveTrackColor: Colors.red,
          inactiveThumbColor: Colors.white,
          title: Text(titles[i]),
          subtitle: Text(switchTiles[i] ? "Cloudy" : "Sunny"),
          value: switchTiles[i],
          selected: switchTiles[i],
          secondary: Icon(switchTiles[i] ? Icons.cloud : Icons.wb_sunny),
          onChanged: (isSwitched) {
            setState(() {
              switchTiles[i] = isSwitched;
            });
          }));
      switchLists.add(Divider(
        height: 6,
        color: Colors.grey,
      ));
    }
    return switchLists;
  }

  _showDatePicker() async {
    final DateTime time = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030)
    );


    if(time==null){
      return;
    }

    Toast.show(time.toLocal().toString(), context);

  }

  _showTimePicker() async {
     final TimeOfDay day = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 10, minute: 58),
    );

     if(day==null){
       return;
     }

     Toast.show(day.hour.toString()+':'+day.minute.toString(), context);

  }

  _datePicker() {
    return FlatButton(
        color: Colors.green,
        onPressed: _showDatePicker,
        child: Icon(
          Icons.date_range,
          color: Colors.white,
        ));
  }

  _timePicker() {
    return FlatButton(
        color: Colors.green,
        onPressed: _showTimePicker,
        child: Icon(
          Icons.access_time,
          color: Colors.white,
        ));
  }

  _radio() {
    return Radio(value: 1, groupValue: 10, onChanged: (value) {});
  }

  _radioListTiles() {
    List<Widget> tiles = new List<Widget>();
    for (int i = 0; i < 2; i++) {
      tiles.add(RadioListTile(
        value: i,
        groupValue: groupIndex,
        onChanged: (value) {
          setState(() {
            groupIndex = value;
          });
        },
        title: Text(i == 0 ? 'Options A' : 'Options B'),
        subtitle: Text('Description'),
        secondary: Icon(i == 0 ? Icons.filter_1 : Icons.filter_2),
        selected: groupIndex == i,
      ));
    }
    return tiles;
  }

  _checkBox() {
    return Checkbox(
      activeColor: Colors.black,
      value: checkBox,
      onChanged: (value) {
        setState(() {
          checkBox = value;
        });
      },
    );
  }

  _checkBoxListTile() {
    List checks = new List<Widget>();
    for (int i = 0; i < checkBoxTiles.length; i++) {
      checks.add(
          CheckboxListTile(
            activeColor: Colors.orange,
              title: Text(i == 0 ? 'CheckBox A' : 'CheckBox B'),
              subtitle: Text(i == 0 ? 'Description A' : 'Description B'),
              secondary: Icon(Icons.wb_sunny),
              selected: checkBoxTiles[i],
              value: checkBoxTiles[i],
              onChanged: (value) {
                setState(() {
                  checkBoxTiles[i] = value;
                });
              })
      );
    }
    return checks;
  }

  _sizeBox() {
    return SizedBox(
      height: 20,
    );
  }

  _widgets() {
    List<Widget> widgets = new List<Widget>();
    widgets.add(_slider());
    widgets.add(_label());
    widgets.add(_sizeBox());
    widgets.add(_switch());
    widgets.add(_sizeBox());
    _switchListTile().map((item) {
      widgets.add(item);
    }).toList();

    widgets.add(_datePicker());
    widgets.add(_timePicker());

    widgets.add(_radio());
    _radioListTiles().map((item) {
      widgets.add(item);
    }).toList();

    widgets.add(_checkBox());

    _checkBoxListTile().map((item){
      widgets.add(item);
    }).toList();

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Others', style: TextStyle(fontSize: 20.0)),
      ),
      body: Container(
//          padding: EdgeInsets.only(top: 70),
          color: Colors.grey.withOpacity(0.04),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _widgets(),
              )
            ],
          )),
    );
  }
}
