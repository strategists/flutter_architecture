import 'package:flutter/material.dart';
import 'package:flutter_architecture/style/style.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  String _uname = "张北海";
  String _mobile = "13693302061";
  List<PreferenceItem> _preferenceItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 5; i++) {
      PreferenceItem item;
      if (i == 0) {
        item = PreferenceItem(text: "账户管理", isGroupHeader: true);
      } else if (i == 1) {
        item = PreferenceItem(text: "结算账户", isGroup: true);
      } else {
        item = PreferenceItem(
          text: "业务账户",
        );
      }
      _preferenceItems.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    var safeArea = SafeArea(
      child: Stack(
        children: <Widget>[_buildList()],
      ),
    );
    return Container(
      color: AppColors.mine_header,
      child: safeArea,
    );
  }

  Widget _buildList() {
    List<Widget> children = [];
    children.add(_buildTitle());
    children.add(_buildSubTitle());
    children.add(_buildHeader());
    children.addAll(_buildGrop(_preferenceItems));
    return ListView(
      children: children,
      controller: ScrollController(),
    );
  }

  Widget _buildTitle() {
    var text = Text(
      "Hi，欢迎来到中链融",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
    return Padding(
      padding: EdgeInsets.only(top: 28, right: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: text,
      ),
    );
  }

  Widget _buildSubTitle() {
    var text = Text(
      "专为中小企业打造的供应链资金服务平台",
      maxLines: 1,
      strutStyle: StrutStyle(
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
      style: TextStyle(
        color: Colors.white54,
        fontSize: 12,
      ),
    );
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: text,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 18, left: 8, right: 8),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
        color: Colors.blueAccent,
        child: _buildCardChild(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
    );
  }

  Widget _buildCardChild() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.person,
          size: 68,
        ),
        _buildProfile(),
        Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_right,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Column _buildProfile() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              _uname,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
        Text(
          _mobile,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  /// build group

  List<Widget> _buildGrop(List<PreferenceItem> items) {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      PreferenceItem item = items[i];
      widgets.add(_buildItem(item));
      if (item.isGroup) {
        widgets.add(_buildLine());
      } else {
        widgets.add(_buildGap());
      }
    }
  }

  Widget _buildItem(PreferenceItem item) {
    var listTile = ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      onTap: () {},
      title: Text(
        item.text,
        style: TextStyle(
          fontWeight: item.isGroupHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: item.isGroupHeader ? null : Icon(Icons.chevron_right),
    );
    return Container(
      color: Colors.white,
      child: listTile,
    );
  }

  Widget _buildLine() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        color: Colors.grey,
        height: 2,
      ),
    );
  }

  Widget _buildGap() {
    return Container(
      color: Colors.grey,
      height: 6.0,
    );
  }
}

class Profile {}

class PreferenceItem {
  dynamic icon;
  String text;
  bool isGroup;
  bool isGroupHeader;

  PreferenceItem(
      {this.icon,
      @required this.text,
      this.isGroup = false,
      this.isGroupHeader = false});
}
