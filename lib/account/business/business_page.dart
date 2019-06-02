import 'package:flutter/material.dart';

class BusinessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BusinessState();
  }
}

class _BusinessState extends State<BusinessPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: choices.length);
    _pageController = new PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("结算账户"),
        bottom: new PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: new Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: new Container(
              height: 48.0,
              alignment: Alignment.center,
//              child: new TabPageSelector(controller: _tabController),
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.red,
      /*child: DefaultTabController(
        length: choices.length,
        child: Column(
          children: <Widget>[
            _buildTabBar(),
            Expanded(
              flex: 1,
              child: _buildTabBarView(),
            ),
          ],
        ),
      ),*/
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("adASDs"),
              Icon(
                Icons.accessibility,
                size: 30,
              ),
              Text("adASDs"),
              Text("adASDs"),
            ],
          ),
          // _buildDefaultTabController(),
          _buildTabBar(),
          Expanded(
            flex: 1,
//              child: _buildTabBarView(),
            child: _buildPageView(),
          ),
        ],
      ),
    );
  }

  DefaultTabController _buildDefaultTabController() {
    return DefaultTabController(
      length: choices.length,
      child: _buildTabBar(),
    );
  }

  TabBar _buildTabBar() {
    return new TabBar(
      controller: _tabController,
      isScrollable: true,
      tabs: choices.map((Choice choice) {
        return new Tab(
          text: choice.title,
          icon: new Icon(choice.icon),
        );
      }).toList(),
    );
  }

  TabBarView _buildTabBarView() {
    return new TabBarView(
      controller: _tabController,
      children: choices.map((Choice choice) {
        return new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new ChoiceCard(choice: choice),
        );
      }).toList(),
    );
  }

  PageView _buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        _tabController.index = index;
      },
      children: choices.map((Choice choice) {
        return new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new ChoiceCard(choice: choice),
        );
      }).toList(),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(choice.icon, size: 128.0, color: textStyle.color),
            new Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
