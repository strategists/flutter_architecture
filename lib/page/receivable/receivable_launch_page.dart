import 'package:flutter/material.dart';
import 'package:flutter_architecture/widget/invoice.dart';
import 'package:flutter_architecture/widget/dash_semicircle.dart';
import 'package:flutter_architecture/component/specific_app_bar.dart';
import 'package:flutter_architecture/style/style.dart';
import 'package:provider/provider.dart';
import 'receivable_view_model.dart';
import 'package:flutter_architecture/widget/button.dart';
import 'apply_record.dart';

class ReceivableLaunchPage extends StatefulWidget {
  @override
  _ReceivableLaunchPageState createState() {
    return _ReceivableLaunchPageState();
  }
}

class _ReceivableLaunchPageState extends State<ReceivableLaunchPage> {
  var _receivableViewModel = new ReceivableViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _receivableViewModel.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) {
        return _receivableViewModel;
      },
      child: _buildScaffold(),
    );
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      appBar: SpecificAppBar("应收通"),
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          _buildGroundContainer(),
          Consumer<ReceivableViewModel>(
            builder: (context, model, child) {
              return _buildPositioned();
            },
          ),
        ],
      ),
    );
  }

  Positioned _buildPositioned() {
    return Positioned(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13),
        child: _buildCard(),
      ),
      left: 0,
      right: 0,
      bottom: 37,
      height: 314,
    );
  }

  Widget _buildGroundContainer() {
    return Column(
      children: <Widget>[
        Container(
          height: 189,
          color: Colors.blue,
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCard() {
    var column = Column(
      children: <Widget>[
        SolidButton(
          round: 25,
          text: "立即融资",
          width: 295,
          height: 50,
          onPressed: () {},
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
        _buildTable(),
      ],
    );
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: column,
      ),
    );
  }

  Widget _buildTable() {
    List<TableRow> tabRow = [];
    var data = "我要还款";
    var row = InkResponse(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ApplyRecordPage();
            },
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Icon(
            Icons.error,
            size: 43,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
          ),
          Text(data)
        ],
      ),
    );
    var tableRow = TableRow(children: <Widget>[
      row,
      row,
      row,
    ]);
    tabRow.add(tableRow);
    var gap = Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
    );
    tabRow.add(
      TableRow(children: <Widget>[gap, gap, gap]),
    );
    tabRow.add(tableRow);
    return Table(
//      border: TableBorder.all(color: Colors.blue),
      children: tabRow,
    );
  }
}
