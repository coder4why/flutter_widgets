import 'package:flutter/material.dart';
import 'package:flutter_widgets/models/post.dart';

class FlutterDataTables extends StatefulWidget {
  //外部参数
  FlutterDataTables(this.selectIndex);

  int selectIndex;

  @override
  _FlutterDataTablesState createState() => _FlutterDataTablesState();
}

//'DataTable',
//'PaginatedDataTable',
//'Card',
//'Stepper',
class _FlutterDataTablesState extends State<FlutterDataTables>
    with SingleTickerProviderStateMixin {
  int stepSelectIndex = 0;

  _dataTableWidgets() {
    return DataTable(
        columns: [
          DataColumn(
            label: Text('Title'),
          ),
          DataColumn(
            label: Text('Author'),
          ),
          DataColumn(
            label: Text('Image'),
          ),
        ],
        rows: posts.map((f) {
          return DataRow(cells: [
            DataCell(Text(f.title)),
            DataCell(Text(f.author)),
            DataCell(Image.network(f.imageUrl)),
          ]);
        }).toList());
  }

  _paginatedDataTable() {
    return PaginatedDataTable(
        header: Text('Hello Flutter'),
        columns: [
          DataColumn(
            label: Text('Title'),
          ),
          DataColumn(
            label: Text('Image'),
          ),
        ],
        source: DataSource());
  }

  _card() {
    return Column(
      children: posts.map((p) {
        return Card(
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  p.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(p.imageUrl),
                ),
                title: Text(p.title),
                subtitle: Text(p.author),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  p.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                        onPressed: null,
                        child: Text(
                          'LIKE',
                          style: TextStyle(color: Colors.blue),
                        )),
                    FlatButton(
                        onPressed: null,
                        child: Text(
                          'READ',
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  _stepper() {
    return Stepper(
      type: StepperType.vertical,
      currentStep: stepSelectIndex,
      onStepTapped: (int index) {
        setState(() {
          stepSelectIndex = index;
        });
      },
      onStepCancel: () {},
      onStepContinue: () {},
      steps: posts.map((post) {
        return Step(
            title: Text(post.title),
            subtitle: Text(post.author),
            content: Image.network(post.imageUrl),
            isActive: posts.indexOf(post) == stepSelectIndex);
      }).toList(),
    );
  }

  _widgets() {
    List<Widget> widgets = [
      _dataTableWidgets(),
      _paginatedDataTable(),
      _card(),
      _stepper()
    ];
    return widgets[widget.selectIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter DataTables', style: TextStyle(fontSize: 20.0)),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_widgets()],
          )
        ],
      ),
    );
  }
}

class DataSource extends DataTableSource {
  /*数据源*/
  final List _desserts = posts;

  int selectCount = 0;

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => posts.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => selectCount;

  @override
  DataRow getRow(int index) {
    // TODO: implement getRow
    if (index >= posts.length) {
      return null;
    } else {
      final Post p = posts[index];
      return DataRow.byIndex(
        index: index,
        selected: p.selected,
        onSelectChanged: (value) {
          if (p.selected != value) {
            selectCount += value ? 1 : -1;
            p.selected = value;
          }
        },
        cells: <DataCell>[
          DataCell(Text('${p.title}')),
//            DataCell(Text('${p.author}')),
          DataCell(Image.network(p.imageUrl)),
        ],
      );
    }
  }
}
