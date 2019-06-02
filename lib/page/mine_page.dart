import 'package:flutter/material.dart';
import 'package:flutter_architecture/style/style.dart';
import 'package:flutter_architecture/entity/profile_entity.dart';
import 'package:flutter_architecture/viewmodel/mine_view_model.dart';
import 'package:provide/provide.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture/component/component.dart';
import 'package:flutter_architecture/account/settlement/settlement_page.dart';
import 'package:flutter_architecture/account/business/business_page.dart';


class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  static const double FOLD_HEAD = 220;

  var _listScrollController = ScrollController();
  var _scrollController = ScrollController();

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
    _listScrollController.addListener(() {
      double offset = _listScrollController.offset;
      print("offset:$offset");
      _scrollController.jumpTo(offset);
    });

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double statusBarHeight = MediaQuery.of(context).padding.top;
      if (offset == FOLD_HEAD) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark));
      } else if (offset == 0) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
            .copyWith(
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light));
      }
    });
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

  void _itemClick(PreferenceItem item) {
    Navigator.push(
      context,
      /*CupertinoPageRoute(builder: (context) {
        return AccountCommPage(
          title: item.text,
          body: Container(),
        );
      }),*/
      CupertinoPageRoute(builder: (context) {
        return BusinessPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var safeArea = SafeArea(
      child: Stack(
        children: <Widget>[_buildPreferenceIteBg(), _buildList()],
      ),
    );
    var container = Container(
//      color: AppColors.mine_header,
      child: Stack(
        children: <Widget>[
          _buildScrollBg(),
          SafeArea(
            child: _buildList(),
          )
        ],
      ),
//      child: _buildCollapsible(),
    );
    return ProviderNode(
      providers: _providers,
      child: container,
    );
  }

  Widget _buildScrollBg() {
    return NestedScrollView(
      controller: _scrollController,
      physics: NeverScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: FOLD_HEAD,
              child: Image.asset(
                "assets/fold_head.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ];
      },
      body: Container(
        color: AppColors.home_bg,
      ),
    );
  }

  Widget _buildCollapsible() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        var sliverToBoxAdapter = SliverToBoxAdapter(
          child: Stack(
            children: <Widget>[
              _buildPreferenceIteBg(),
              _buildHeaderItem(),
            ],
          ),
        );
        return <Widget>[
          new SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            child: new SliverAppBar(
              pinned: true,
              expandedHeight: 300.0,
              // 这个高度必须比flexibleSpace高度大
              forceElevated: innerBoxIsScrolled,
              bottom: PreferredSize(
                  child: new Container(
                    color: Colors.redAccent[200],
                  ),
                  preferredSize: new Size(double.infinity, 46.0)),
              // 46.0为TabBar的高度，也就是tabs.dart中的_kTabHeight值，因为flutter不支持反射所以暂时没法通过代码获取
              flexibleSpace: new Container(
                child: new Column(
                  children: <Widget>[
                    new AppBar(
                      title: Text("this is title"),
                    ),
                    new Expanded(
                      child: new Container(
                        child: Image.asset(
                          "images/test.jpg",
                          repeat: ImageRepeat.repeat,
                        ),
                        width: double.infinity,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      physics: FixedExtentScrollPhysics(),
      scrollDirection: Axis.vertical,
      body: Container(
        child: _buildList(),
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
        color: AppColors.mine_header,
      ),
    );
  }

  Widget _buildHeaderItem() {
    return Column(
      children: <Widget>[
        _buildTitle(),
        _buildSubTitle(),
        _buildHeader(),
      ],
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
          controller: _listScrollController,
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
      onTap: () {
        _itemClick(item);
      },
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

  @override
  // TODO: 页面切换保存状态
  bool get wantKeepAlive => false;
}
