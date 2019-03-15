class Post {
  Post({
    this.title,
    this.widgets,
  });

  final String title;
  final List<String> widgets;
}

final List<Post> posts = [

  Post(
    title: 'Material Components',
    widgets: [
      'Scaffold',
      'Appbar',
      'BottomNavigationBar',
      'TabBar',
      'TabBarView',
      'MaterialApp',
      'WidgetsApp',

      'Drawer',
      'FloatingActionButton',
      'FlatButton',
      'IconButton',
      'RaisedButton',
      'PopupMenuButton',
      'ButtonBar',
      'TextField',
      'Checkbox',
      'Radio',
      'Switch',
      'Slider',
      'Date & Time Pickers',
      'SimpleDialog',
      'AlertDialog',
      'BottomSheet',
      'ExpansionPanel',
      'SnackBar',
      'Icon',
      'Chip',
      'Tooltip',
      'DataTable',
      'Card',
      'LinearProgressIndicator',
      'ListTile',
      'Stepper',
      'Divider',
      'FlutterLogo',
      'Placeholder',
    ],
  ),
  Post(
    title: 'Cupertino(iOS风格的widget)',
    widgets: [
      'CupertinoActivityIndicator',
      'CupertinoAlertDialog',
      'CupertinoButton',
      'CupertinoDialog',
      'CupertinoDialogAction',
      'CupertinoSlider',
      'CupertinoSwitch',

      'CupertinoPageTransition',
      'CupertinoFullscreenDialogTransition',
      'CupertinoNavigationBar',
      'CupertinoTabBar',
      'CupertinoPageScaffold',
      'CupertinoTabScaffold',
      'CupertinoTabView',

    ],
  ),

  Post(
    title: 'Layout',
    widgets: [
      'Container',
      'Row',
      'Column',
      'Padding',
      'Center',
      'Align',
      'FittedBox',
      'AspectRatio',
      'ConstrainedBox',
      'Baseline',
      'FractionallySizedBox',
      'IntrinsicHeight',
      'IntrinsicWidth',

      'LimitedBox',
      'Offstage',
      'OverflowBox',
      'SizedBox',
      'SizedOverflowBox',
      'Transform',
      'CustomSingleChildLayout',
      'Stack',
      'IndexedStack',

      'Flow',
      'Table',
      'Wrap',
      'ListBody',
      'ListView',
      'LayoutBuilder',

    ],
  ),
  Post(
    title: 'Text',
    widgets: [
      'Text',
      'RichText',
      'DefaultTextStyle',
    ],
  ),
  Post(
    title: 'Assets、图片、Icons',
    widgets: [
      'Image',
      'Icon',
      'RawImage',
      'AssetBundle',
    ],
  ),
  Post(
    title: 'Input',
    widgets: [
      'Form',
      'FormField',
      'RawKeyboardListener',
    ],
  ),
  Post(
    title: '动画和Motion',
    widgets: [
      'AnimatedContainer',
      'AnimatedCrossFade',
      'Hero',
      'AnimatedBuilder',
      'DecoratedBoxTransition',
      'FadeTransition',
      'PositionedTransition',
      'RotationTransition',
      'ScaleTransition',
      'SizeTransition',
      'SlideTransition',
      'AnimatedDefaultTextStyle',
      'AnimatedListState',
      'AnimatedModalBarrier',
      'AnimatedOpacity',
      'AnimatedPhysicalModel',
      'AnimatedPositioned',
      'AnimatedSize',
      'AnimatedWidget',
      'AnimatedWidgetBaseState',
    ],
  ),
  Post(
    title: '交互模型',
    widgets: [
      'LongPressDraggable',
      'GestureDetector',
      'DragTarget',
      'Dismissible',
      'IgnorePointer',
      'AbsorbPointer',
      'Navigator',
      'Scrollable',

    ],
  ),
  Post(
    title: '样式',
    widgets: [
      'Padding',
      'Theme',
      'MediaQuery',
    ],
  ),
  Post(
    title: '绘制和效果',
    widgets: [
      'Opacity',
      'Transform',
      'DecoratedBox',
      'FractionalTranslation',
      'RotatedBox',
      'ClipOval',
      'ClipPath',
      'ClipRect',
      'CustomPaint',
      'BackdropFilter',

    ],
  ),
  Post(
    title: 'Async',
    widgets: [
      'FutureBuilder',
      'StreamBuilder',
    ],
  ),

  Post(
    title: '滚动',
    widgets: [
      'ListView',
      'NestedScrollView',
      'GridView',
      'SingleChildScrollView',
      'Scrollable',
      'Scrollbar',
      'CustomScrollView',
      'NotificationListener',
      'ScrollConfiguration',
      'RefreshIndicator',
      'SliverAppBar',
      'SliverSafeArea',
    ],
  ),
  Post(
    title: '辅助功能',
    widgets: [
      'Semantics',
      'MergeSemantics',
      'ExcludeSemantics',
    ],
  ),
];
