import 'package:flutter/material.dart';
import 'package:flutter_architecture/widget/invoice.dart';
import 'package:flutter_architecture/widget/dash_semicircle.dart';
import 'package:flutter_architecture/component/specific_app_bar.dart';
import 'package:flutter_architecture/style/style.dart';
import 'package:provider/provider.dart';
import 'apply_record_bloc.dart';

class ApplyRecordPage extends StatefulWidget {
  @override
  _ApplyRecordPageState createState() {
    return _ApplyRecordPageState();
  }
}

class _ApplyRecordPageState extends State<ApplyRecordPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    Provider.of<ApplyRecordBloc>(context).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
//        Provider<ApplyRecordBloc>.value(value: ApplyRecordBloc()),
        Provider(
          builder: (context) => ApplyRecordBloc(),
        ),
      ],
      child: _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    var column = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Invoice(),
        Invoice(),
        Invoice(),
      ],
    );
    return Scaffold(
      appBar: SpecificAppBar("收款记录"),
      backgroundColor: Colors.grey,
      body: StreamBuilder<Object>(
        builder: (context, snapshot) {
          var data = snapshot.data;
          print("data : $data");
          return column;
        },
//        initialData: Provider.of<ApplyRecordBloc>(context).data,
//        stream: Provider.of<ApplyRecordBloc>(context).stream,
      ),
    );
  }
}
