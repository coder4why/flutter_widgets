import 'package:flutter/material.dart';
import 'DetailPage.dart';
import 'WidgetJSON.dart';

void main() => runApp(MyApp());

Color themeColor = Colors.red;

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
      for (int i = 0; i < posts[x].widgets.length; i++) {
        items.add(
          GestureDetector(
            onTap:  () =>  Navigator.of(context).push(new MaterialPageRoute(builder: (context){
              return new DetailPage(posts[x].widgets[i]);
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
      listViews.add(new ListView(
        children: items,
      ));
    }
    return listViews;
  }

  _listTiles() {
    var tiles = new List<Widget>();
    var icons = [Icons.message, Icons.favorite, Icons.settings];
    var titles = ['Messages', 'Favorite', 'Settings'];
    for (int i = 0; i < titles.length; i++) {
      tiles.add(ListTile(
        title: Text(
          titles[i],
          textAlign: TextAlign.right,
        ),
        trailing: Icon(icons[i], color: Colors.black12, size: 22.0),
        onTap: () => Navigator.pop(context),
      ));
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
              color: Colors.red[200],
              image: DecorationImage(
                image: NetworkImage(
                    'https://gss2.bdstatic.com/-fo3dSag_xI4khGkpoWK1HF6hhy/baike/h%3D250/sign=65c54448c4ea15ce5eeee70c86023a25/fcfaaf51f3deb48feaaa8b13fd1f3a292cf5783f.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.red[200].withOpacity(0.6), BlendMode.hardLight),
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
