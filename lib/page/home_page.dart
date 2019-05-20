import 'package:flutter/material.dart';
import 'package:flutter_architecture/style/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/receivable/receivable_launch_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  static const double FOLD_HEAD = 150;
  static const String url =
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549129578802&di=f866c638ea12ad13c5d603bcc008a6c2&imgtype=0&src=http%3A%2F%2Fpic2.16pic.com%2F00%2F07%2F66%2F16pic_766297_b.jpg';

  ScrollController _scrollController;
  ScrollController _listScrollController;
  double w, h;
  FixedExtentScrollPhysics _scrollPhysics = new FixedExtentScrollPhysics();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController();
    _listScrollController = new ScrollController(initialScrollOffset: 0);
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
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _listScrollController.dispose();
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    print("w= $w");
    print("h= $h");
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    var stack = Stack(
      children: <Widget>[
        _buildNestedScrollView(),
        Positioned(
          left: 16,
          right: 16,
          top: 0,
          bottom: 0,
          child: SafeArea(child: _buildListView()),
        )
      ],
    );
    return Container(
      color: AppColors.home_bg,
      child: stack,
    );
  }

  Widget _buildNestedScrollView() {
    return NestedScrollView(
      controller: _scrollController,
      physics: NeverScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        debugPrint("innerBoxIsScrolled: $innerBoxIsScrolled");
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

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.access_alarms,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
          ),
          Text(
            "中链融",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20.0),
      child: Text(
        "链接信用，融通资金",
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildListView() {
    List<Widget> widgets = [];
    widgets.add(_buildTitle());
    widgets.add(_buildSubTitle());
    for (int i = 0; i < 50; i++) {
      widgets.add(_buildItemCard());
    }
    return ListView(
      children: widgets,
      controller: _listScrollController,
    );
  }

  Widget _buildItemCard() {
    var column = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: 100),
          child: _buildSubRow(),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 315,maxWidth: 315),
          child: _buildSubCard(),
        ),
      ],
    );

    var card = Card(
      child: Padding(
        padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 10),
        child: column,
      ),
    );
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 210,
      ),
      child: card,
    );
  }

  Widget _buildSubRow() {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "应收通",
              style: TextStyle(color: AppColors.home_item_title, fontSize: 18),
            ),
            Text(
              "最高可借额度(元)",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text("500000", style: TextStyle(color: Colors.grey, fontSize: 24)),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: RaisedButton(
            textTheme: ButtonTextTheme.primary,
            color: AppColors.home_item_button,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18))),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ReceivableLaunchPage();
              }));
            },
            child: Text("我要融资"),
          ),
        ),
      ],
    );
  }

  Widget _buildSubCard() {
    List<Widget> widgets = [];
    var listTile = Chip(
      backgroundColor: Colors.white,
      label: Text(
        "线上申请极速放款",
        style: TextStyle(fontSize: 10),
      ),
      avatar: Icon(Icons.ac_unit),
    );
    for (int i = 0; i < 4; i++) {
      widgets.add(listTile);
    }
    return Card(
      color: AppColors.home_item_sub_card,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        direction: Axis.horizontal,
        spacing: 18.0,
        // gap between adjacent chips
        runSpacing: 10.0,
        // gap between lines
        children: widgets,
      ),
    );
  }
}
