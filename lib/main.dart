import 'package:flutter/material.dart';
import 'DetailPage.dart';
import 'package:flutter_widgets/models/WidgetJSON.dart';
import 'route/flutter_buttons.dart';
import 'route/flutter_dialogs.dart';
import 'route/flutter_chips.dart';
import 'route/flutter_dataTables.dart';
import 'route/flutter_others.dart';
import 'route/flutter_interActives.dart';
import 'route/flutter_dios.dart';
import 'route/flutter_dios_detail.dart';
import 'models/dioDatas.dart';
import 'route/flutter_musics.dart';
import 'route/flutter_music_detail.dart';

void main() => runApp(MyApp());

Color themeColor = Colors.green;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgets',
      theme: ThemeData(
        primarySwatch: themeColor,
      ),
      debugShowCheckedModeBanner: true,
      home: MyHomePage(),
      //设置路由：
      routes: {
        'DetailPage': (BuildContext context) => new DetailPage(''),
        'FlutterButtons': (BuildContext context) => new FlutterButtons(),
        'FlutterDiaglos': (BuildContext context) => new FlutterDiaglos(),
        'FlutterChips': (BuildContext context) => new FlutterChips(),
        'FlutterDataTables': (BuildContext context) => new FlutterDataTables(0),
        'FlutterOthers': (BuildContext context) => new FlutterOthers(),
        'InterActives': (BuildContext context) => new InterActives(0),
        'DiosDetail': (BuildContext context) =>
            new DiosDetail(DioData('', '', '', '', '', '', '', '', '', '')),
        'MusicPage': (BuildContext context) => new MusicPage(),
        'MusicDetailPage': (BuildContext context) => new MusicDetailPage(null),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  static TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: posts.length, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _listItems(BuildContext context) {
    var listViews = new List<Widget>();
//    var tabBarViews = new List<Widget>();
    for (int x = 0; x < posts.length; x++) {
      var items = new List<Widget>();
      if (x == 0) {
        items.add(DioWidgets());
      } else {
        for (int i = 0; i < posts[x].widgets.length; i++) {
          items.add(
            GestureDetector(
                onTap: () => Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (context) {
                      if (x == 7) {
                        //交互模型
                        return new InterActives(i);
                      } else if (x == posts.length - 5) {
                        return new FlutterButtons(); //按钮
                      } else if (x == posts.length - 4) {
                        return new FlutterDiaglos(); //对话框
                      } else if (x == posts.length - 3) {
                        return new FlutterChips(); //Chips
                      } else if (x == posts.length - 2) {
                        return new FlutterDataTables(i); //列表
                      } else if (x == posts.length - 1) {
                        return new FlutterOthers(); //其他
                      } else {
                        return new DetailPage(posts[x].widgets[i]); //详情
                      }
                    })),
                child: Container(
                  color: Colors.black12,
                  padding: EdgeInsets.only(left: 2, top: 10, bottom: 10),
                  margin: EdgeInsets.all(10),
                  child: Text(
                    posts[x].widgets[i],
                    style: TextStyle(fontSize: 17.0),
                  ),
                )),
          );
        }
      }
      listViews.add(new ListView(
        children: items,
      ));
    }
    return listViews;
  }

  _listTiles() {
    var tiles = new List<Widget>();
    var icons = [Icons.message, Icons.favorite, Icons.settings];
    var titles = ['听音乐', '听音乐', '听音乐'];
    for (int i = 0; i < titles.length; i++) {
      tiles.add(ListTile(
          title: Text(
            titles[i],
            textAlign: TextAlign.right,
          ),
          trailing: Icon(icons[i], color: Colors.black12, size: 22.0),
          onTap: () {
            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) {
              return new MusicPage();
            }));
          }));
    }
    return tiles;
  }

  _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName:
                Text('Ds.Hpk', style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text('https://gtihub.com/hupingkang'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://gss3.bdstatic.com/7Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=cec6b575a944ad343ab28fd5b1cb6791/d4628535e5dde711cf0a546eafefce1b9c166149.jpg'),
            ),
            decoration: BoxDecoration(
              color: Colors.green[200],
              image: DecorationImage(
                image: NetworkImage(
                    'https://gss2.bdstatic.com/-fo3dSag_xI4khGkpoWK1HF6hhy/baike/h%3D250/sign=65c54448c4ea15ce5eeee70c86023a25/fcfaaf51f3deb48feaaa8b13fd1f3a292cf5783f.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.green[200].withOpacity(0.6), BlendMode.hardLight),
              ),
            ),
          ),
          _listTiles()[0],
          _listTiles()[1],
          _listTiles()[2]
        ],
      ),
    );
  }

  _appBars() {
    var style = TextStyle(fontSize: 14.0, color: Colors.white);
    var items = new List<Widget>();
    for (int i = 0; i < posts.length; i++) {
      items.add(new Tab(
        icon: Text(
          posts[i].title,
          style: style,
        ),
      ));
    }
    return new TabBar(
      tabs: items,
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      controller: _tabController,
    );
  }

  _appBar(BuildContext context) {
    return new DefaultTabController(
        length: posts.length,
        child: Scaffold(
          drawer: _drawer(),
          appBar: AppBar(
            title: Text('Flutter Widgets Use'),
            bottom: _appBars(),
          ),
          body: new TabBarView(
            children: _listItems(context),
            controller: _tabController,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _appBar(context);
  }
}
