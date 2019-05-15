import 'package:flutter/material.dart';
import 'package:flutter_architecture/style/style.dart';
import 'package:flutter_architecture/entity/profile_entity.dart';
import 'package:flutter_architecture/viewmodel/mine_view_model.dart';
import 'package:provide/provide.dart';

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
  MineViewModel model = new MineViewModel();

  Providers _providers = new Providers();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("initState");
    _providers.provide(Provider.value(model));
    model.loadProfile(context);
    model.fetch();
  }

  @override
  void didUpdateWidget(MinePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    debugPrint("didUpdateWidget");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    debugPrint("didChangeDependencies");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    debugPrint("deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    debugPrint("dispose");
    model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var safeArea = SafeArea(
      child: Stack(
        children: <Widget>[_buildPreferenceIteBg(), _buildList()],
      ),
    );
    var container = Container(
      color: AppColors.mine_header,
      child: SafeArea(child: safeArea),
    );
    return ProviderNode(
      providers: _providers,
      child: container,
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
    return Provide<MineViewModel>(
      builder: (context, child, model) {
        print("model $model");
        List<Widget> children = [];
        children.add(_buildTitle());
        children.add(_buildSubTitle());
        children.add(_buildHeader());
        children.addAll(_buildGroup(model.items));
        var listView = ListView(
          children: children,
          controller: ScrollController(),
        );
        return listView;
      },
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
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Divider(
          color: Colors.grey,
          height: 2,
        ),
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
