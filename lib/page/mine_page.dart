import 'package:flutter/material.dart';
import 'package:flutter_architecture/style/style.dart';
import 'package:flutter_architecture/entity/profile_entity.dart';

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
    for (int i = 0; i < 10; i++) {
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
        children: <Widget>[_buildPreferenceIteBg(), _buildList()],
      ),
    );
    return Container(
      color: AppColors.mine_header,
      child: SafeArea(child: safeArea),
    );
  }

  Widget _buildCollapsible() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          _buildSliverAppBar(),
        ];
      },
      body: _buildList(),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      //展开高度
      expandedHeight: 150.0,
      //是否随着滑动隐藏标题
      floating: false,
      //是否固定在顶部
      pinned: true,
      //可折叠的应用栏
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          '可折叠的组件',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        background: Image.network(
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549129578802&di=f866c638ea12ad13c5d603bcc008a6c2&imgtype=0&src=http%3A%2F%2Fpic2.16pic.com%2F00%2F07%2F66%2F16pic_766297_b.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPreferenceIteBg() {
    return Positioned(
      bottom: 0,
      height: 300,
      left: 0,
      right: 0,
      child: Container(
        color: AppColors.mine_preference,
      ),
    );
  }

  Widget _buildList() {
    List<Widget> children = [];
    children.add(_buildTitle());
    children.add(_buildSubTitle());
    children.add(_buildHeader());
    children.addAll(_buildGroup(_preferenceItems));
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
  List<Widget> _buildGroup(List<PreferenceItem> items) {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      PreferenceItem item = items[i];
      widgets.add(_buildItem(item));
      if (!item.isGroupHeader) {
        if (item.isGroup) {
          widgets.add(_buildLine());
        } else {
          widgets.add(_buildGap());
        }
      }
    }
    return widgets;
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: item.isGroupHeader
            ? BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              )
            : null,
      ),
//      color: Colors.white,
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
//      color: Colors.grey,
      height: 6.0,
    );
  }
}
