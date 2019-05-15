import 'package:flutter/material.dart';
import 'package:flutter_architecture/style/app_colors.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  ScrollController _listScrollController;
  double w, h;
  FixedExtentScrollPhysics _scrollPhysics= new FixedExtentScrollPhysics();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController();
    _listScrollController = new ScrollController();
    _scrollController.addListener(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    print("w= $w");
    print("h= $h");
    return Container(
      color: AppColors.mine_header,
      child: Stack(
        children: <Widget>[
          _buildBody(),
          Positioned(
            left: 16,
            right: 16,
            top: 100,
            bottom: 0,
            child: _buildListView(),
          )
        ],
      ),
    );
  }

  CustomScrollView buildCustomScrollView() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        Container(
          child: Image.network(
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549129578802&di=f866c638ea12ad13c5d603bcc008a6c2&imgtype=0&src=http%3A%2F%2Fpic2.16pic.com%2F00%2F07%2F66%2F16pic_766297_b.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Colors.white,
        )
      ],
    );
  }

  Widget _buildScroll() {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Demo'),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: Text('grid item $index'),
              );
            },
            childCount: 20,
          ),
        ),
        _sliverFixedExtentList(),
      ],
    );
  }

  SliverFixedExtentList _sliverFixedExtentList() {
    return SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9)],
            child: Text('list item $index'),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        debugPrint("innerBoxIsScrolled: $innerBoxIsScrolled");
        return <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              child: Image.network(
                'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549129578802&di=f866c638ea12ad13c5d603bcc008a6c2&imgtype=0&src=http%3A%2F%2Fpic2.16pic.com%2F00%2F07%2F66%2F16pic_766297_b.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ];
      },
      body: Container(
        color: Colors.white,
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      //展开高度
      expandedHeight: 150.0,
//            title: Text("中链融"),
      centerTitle: true,
      //是否随着滑动隐藏标题
      floating: false,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.black,
        ),
      ),
      //是否固定在顶部
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      //可折叠的应用栏
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        title: Text(
          '中链融',
          style: TextStyle(
            color: Colors.black,
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

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.access_alarms),
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
      padding: EdgeInsets.symmetric(horizontal: 0),
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
      physics: ClampingScrollPhysics(parent: _scrollPhysics),
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
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.input_error,
            ),
            child: _buildSubRow(),
          ),
        ),
        _buildSubCard(),
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
        DecoratedBox(
          decoration: BoxDecoration(color: AppColors.login_bg),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "应收通",
                style:
                    TextStyle(color: AppColors.home_item_title, fontSize: 18),
              ),
              Text(
                "最高可借额度(元)",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text("500000",
                  style: TextStyle(color: Colors.grey, fontSize: 24)),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: RaisedButton(
            onPressed: () {},
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
