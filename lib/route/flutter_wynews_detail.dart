
import 'package:flutter/material.dart';
import '../models/WYNewsModel.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WYNewsDetailPage extends StatefulWidget {
  WYNewsModel model;
  WYNewsDetailPage(this.model);
  @override
  _WYNewsDetailPageState createState() => _WYNewsDetailPageState();
}

class _WYNewsDetailPageState extends State<WYNewsDetailPage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.model.link,
      appBar: AppBar(
        title: Text(widget.model.title),
      ),
    );
  }
}
