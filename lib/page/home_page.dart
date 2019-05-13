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
  double w, h;
  FixedExtentScrollPhysics _scrollPhysics= new FixedExtentScrollPhysics();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
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
            top: 130,
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
          SliverAppBar(
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
          ),
        ];
      },
      physics: _scrollPhysics,
      body: Container(
        color: Colors.white,
      ),
    );
  }

  Widget _buildListView() {
    List<Widget> widgets = [];
    for (int i = 0; i < 50; i++) {
      widgets.add(_buildItemCard());
    }
    return ListView(
      physics:FixedExtentScrollPhysics(parent: _scrollPhysics),
      children: widgets,
    );
  }

  Widget _buildItemCard() {
    return Card(
      child: Stack(
        children: <Widget>[
          _buildSubRow(),
          _buildSubCard(),
        ],
      ),
    );
  }

  Widget _buildSubRow() {
    return Row(
      children: <Widget>[Text("我要融资")],
    );
  }

  Widget _buildSubCard() {
    return Card(
      child: Icon(Icons.keyboard),
    );
  }
}
